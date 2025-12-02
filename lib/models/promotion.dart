import './product.dart';

class Promotion {
  final String title;
  final String description;
  final List<Product> products;

  Promotion({required this.title, required this.description, required this.products});
}
