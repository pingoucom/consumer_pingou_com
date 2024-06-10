import 'package:consumer_pingou_com/domain/entities/product.dart';
import 'package:consumer_pingou_com/domain/entities/product_tag.dart';

abstract class ProductRepository {
  Future<List<Product>> getAvailableProducts();

  Future<List<Product>> getProductsById(List<String> ids);

  Future<List<ProductTag>> getProductTags();

  Future<List<Product>> getFeaturedProducts({
    List<String>? tagIds,
    String? lastProductId,
  });
}
