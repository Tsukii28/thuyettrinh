import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import '../main.dart';
import '../models/transaction.dart';
import '../models/notification.dart' as model;
import '../models/product.dart';

class AppService extends ChangeNotifier {
  static final AppService _instance = AppService._internal();
  factory AppService() => _instance;
  AppService._internal();

  double _balance = 1000.00;
  int _unreadNotifications = 0;
  final List<Transaction> _transactions = [
    Transaction(description: 'Giao dịch 1', amount: -50.00, date: DateTime.now()),
    Transaction(description: 'Giao dịch 2', amount: 200.00, date: DateTime.now()),
    Transaction(description: 'Giao dịch 3', amount: -20.00, date: DateTime.now()),
  ];
  final List<model.Notification> _notifications = [
    model.Notification(title: 'Khuyến mãi mới', body: 'Giảm giá 50% cho trà sữa!', timestamp: DateTime.now()),
    model.Notification(title: 'Giao dịch thành công', body: 'Bạn đã thanh toán thành công 50.000đ cho ShopeeFood.', timestamp: DateTime.now()),
  ];

  double get balance => _balance;
  int get unreadNotifications => _unreadNotifications;
  List<Transaction> get transactions => _transactions;
  List<model.Notification> get notifications => _notifications;

  Future<void> showPaymentNotification(Product product) async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'high_importance_channel', 
      'High Importance Notifications',
      channelDescription: 'This channel is used for important notifications.',
      importance: Importance.max,
      priority: Priority.high,
      showWhen: false,
    );
    const NotificationDetails platformChannelSpecifics = NotificationDetails(android: androidPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(
      0,
      'Thanh toán thành công',
      'Bạn đã thanh toán ${product.price} \$ cho ${product.name}.',
      platformChannelSpecifics,
    );
  }

  Future<void> showDeductionNotification(Product product) async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'high_importance_channel', 
      'High Importance Notifications',
      channelDescription: 'This channel is used for important notifications.',
      importance: Importance.max,
      priority: Priority.high,
      showWhen: false,
    );
    const NotificationDetails platformChannelSpecifics = NotificationDetails(android: androidPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(
      1, // Use a different ID for the second notification
      'Ví đã bị trừ tiền',
      'Đã trừ ${product.price} \$ từ ví của bạn.',
      platformChannelSpecifics,
    );
  }

  Future<void> purchaseProduct(Product product) async {
    _balance -= product.price;
    _transactions.insert(0, Transaction(description: product.name, amount: -product.price, date: DateTime.now()));
    _notifications.insert(0, model.Notification(title: 'Thanh toán thành công', body: 'Bạn đã thanh toán ${product.price} \$ cho ${product.name}.', timestamp: DateTime.now()));
    _unreadNotifications++;
    
    await showPaymentNotification(product);
    await Future.delayed(const Duration(seconds: 2)); // Add a delay for the second notification
    await showDeductionNotification(product);
    
    notifyListeners();
  }

  void clearUnreadNotifications() {
    _unreadNotifications = 0;
    notifyListeners();
  }
}
