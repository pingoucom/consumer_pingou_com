import 'package:consumer_pingou_com/domain/dto/product/product_details.dart';
import 'package:consumer_pingou_com/domain/entities/product.dart';

abstract class ProductRepository {
  Future<List<Product>> getAvailableProducts();

  Future<List<Product>> getProductsById(List<String> ids);

  Future<ProductDetails> findProductAndRelated({
    required String productId,
  });

  getAllProducts() {}

  Future<Product> findProduct({
    required String productId,
  }) {
    return Future<Product>.value();
  }
}
