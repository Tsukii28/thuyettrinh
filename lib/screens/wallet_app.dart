import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/app_service.dart';

class WalletApp extends StatelessWidget {
  const WalletApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ví '),
      ),
      body: Column(
        children: [
          Card(
            margin: const EdgeInsets.all(16.0),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  const Text(
                    'Số dư',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  Consumer<AppService>(
                    builder: (context, appService, child) {
                      return Text(
                        '${appService.balance} \$',
                        style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              'Các giao dịch gần đây',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: Consumer<AppService>(
              builder: (context, appService, child) {
                return ListView.builder(
                  itemCount: appService.transactions.length,
                  itemBuilder: (context, index) {
                    final transaction = appService.transactions[index];
                    return ListTile(
                      leading: Icon(
                        transaction.amount < 0 ? Icons.arrow_downward : Icons.arrow_upward,
                        color: transaction.amount < 0 ? Colors.red : Colors.green,
                      ),
                      title: Text(transaction.description),
                      subtitle: Text(transaction.date.toString()),
                      trailing: Text(
                        '${transaction.amount} \$',
                        style: TextStyle(
                          color: transaction.amount < 0 ? Colors.red : Colors.green,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
