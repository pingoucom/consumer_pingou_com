import 'package:consumer_pingou_com/domain/entities/product.dart';

class ProductDetails {
  final Product product;
  final List<Product> related;

  ProductDetails({
    required this.product,
    required this.related,
  });
}
