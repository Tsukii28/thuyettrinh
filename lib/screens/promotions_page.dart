import 'package:flutter/material.dart';
import '../models/promotion.dart';
import '../models/product.dart';
import './promotion_detail_page.dart';

class PromotionsPage extends StatelessWidget {
  PromotionsPage({super.key});

  final List<Promotion> promotions = [
    Promotion(
      title: 'Giảm giá 50% cho trà sữa',
      description: 'Áp dụng cho tất cả các cửa hàng ToCoToCo',
      products: [
        Product(name: 'Trà sữa trân châu', price: 2.00),
        Product(name: 'Trà sữa thái xanh', price: 2.50),
      ],
    ),
    Promotion(
      title: 'Mua 1 tặng 1 pizza',
      description: 'Áp dụng cho Pizza Hut',
      products: [
        Product(name: 'Pizza hải sản', price: 10.00),
        Product(name: 'Pizza thập cẩm', price: 12.00),
      ],
    ),
    Promotion(
      title: 'Giảm 20k cho đơn hàng từ 50k',
      description: 'Áp dụng cho các đơn hàng trên HelloFood',
      products: [
        Product(name: 'Bún chả', price: 3.00),
        Product(name: 'Phở bò', price: 4.00),
      ],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Khuyến mãi'),
      ),
      body: ListView.builder(
        itemCount: promotions.length,
        itemBuilder: (context, index) {
          final promotion = promotions[index];
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: ListTile(
              title: Text(promotion.title, style: const TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text(promotion.description),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PromotionDetailPage(promotion: promotion),
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
