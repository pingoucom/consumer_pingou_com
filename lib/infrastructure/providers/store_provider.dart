import 'package:consumer_pingou_com/domain/dto/product/product_details.dart';
import 'package:consumer_pingou_com/domain/entities/product.dart';
import 'package:consumer_pingou_com/domain/repositories/product_repository.dart';
import 'package:flutter/material.dart';

class StoreProvider extends ChangeNotifier {
  final ProductRepository _productRepository;

  StoreProvider(this._productRepository);

  final Map<String, List<Product>> _featuredProductsByTagId = {};
  bool _hasLoadedInitialData = false;

  Map<String, List<Product>> get featuredProductsByTagId =>
      Map.unmodifiable(_featuredProductsByTagId);

  bool get hasLoadedInitialData => _hasLoadedInitialData;

  void loadInitialData() async {
    if (_hasLoadedInitialData) return;

    final products = await _productRepository.getAvailableProducts();

    // Add all products directly to _featuredProductsByTagId without filtering by tagId
    _featuredProductsByTagId['all'] = List.from(products);

    _hasLoadedInitialData = true;
    notifyListeners();
  }

  void loadMoreFeaturedProductsForTagId(String tagId) async {
    // Implement this method if you need to load more products based on some logic
  }

  Future<ProductDetails> findProductAndRelated(String productId) {
    return _productRepository.findProductAndRelated(
      productId: productId,
    );
  }

  Future<List<Product>> findAllProducts() {
    return _productRepository.getAvailableProducts();
  }
}
