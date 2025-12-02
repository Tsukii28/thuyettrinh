import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './promotions_page.dart';
import './help_page.dart';
import './wallet_app.dart';
import './notifications_page.dart';
import '../services/app_service.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Trang chủ'),
        actions: [
          Consumer<AppService>(
            builder: (context, appService, child) {
              return Stack(
                children: [
                  IconButton(
                    icon: const Icon(Icons.notifications),
                    onPressed: () {
                      appService.clearUnreadNotifications();
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const NotificationsPage()));
                    },
                  ),
                  if (appService.unreadNotifications > 0)
                    Positioned(
                      right: 11,
                      top: 11,
                      child: Container(
                        padding: const EdgeInsets.all(2),
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        constraints: const BoxConstraints(
                          minWidth: 12,
                          minHeight: 12,
                        ),
                      ),
                    ),
                ],
              );
            },
          ),
        ],
      ),
      body: ListView(
        children: [
          ListTile(
            leading: const Icon(Icons.local_offer),
            title: const Text('Khuyến mãi'),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => PromotionsPage()));
            },
          ),
          ListTile(
            leading: const Icon(Icons.help),
            title: const Text('Trợ giúp'),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const HelpPage()));
            },
          ),
          ListTile(
            leading: const Icon(Icons.account_balance_wallet),
            title: const Text('Ví'),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const WalletApp()));
            },
          ),
        ],
      ),
    );
  }
}
