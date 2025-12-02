import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/promotion.dart';
import '../services/app_service.dart';

class PromotionDetailPage extends StatelessWidget {
  final Promotion promotion;

  const PromotionDetailPage({super.key, required this.promotion});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(promotion.title),
      ),
      body: ListView.builder(
        itemCount: promotion.products.length,
        itemBuilder: (context, index) {
          final product = promotion.products[index];
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: ListTile(
              title: Text(product.name),
              trailing: Text('${product.price} \$'),
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text('Xác nhận thanh toán'),
                    content: Text('Bạn có chắc chắn muốn mua ${product.name} với giá ${product.price} \$ không?'),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text('Hủy'),
                      ),
                      TextButton(
                        onPressed: () {
                          Provider.of<AppService>(context, listen: false).purchaseProduct(product);
                          Navigator.pop(context);
                          Navigator.pop(context);
                        },
                        child: const Text('Thanh toán'),
                      ),
                    ],
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
