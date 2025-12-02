import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/app_service.dart';

class NotificationsPage extends StatelessWidget {
  const NotificationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final appService = Provider.of<AppService>(context, listen: false);
    appService.clearUnreadNotifications();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Thông báo'),
      ),
      body: Consumer<AppService>(
        builder: (context, appService, child) {
          return ListView.builder(
            itemCount: appService.notifications.length,
            itemBuilder: (context, index) {
              final notification = appService.notifications[index];
              return ListTile(
                title: Text(notification.title),
                subtitle: Text(notification.body),
                trailing: Text(notification.timestamp.toString()),
              );
            },
          );
        },
      ),
    );
  }
}
