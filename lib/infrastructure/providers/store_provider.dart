import 'package:consumer_pingou_com/domain/dto/product/product_details.dart';
import 'package:consumer_pingou_com/domain/entities/product.dart';
import 'package:consumer_pingou_com/domain/entities/product_tag.dart';
import 'package:consumer_pingou_com/domain/repositories/product_repository.dart';
import 'package:flutter/material.dart';

class StoreProvider extends ChangeNotifier {
  final ProductRepository _productRepository;

  StoreProvider(this._productRepository);

  final Map<String, List<Product>> _featuredProductsByTagId = {};
  final Map<String, String?> _lastProductIdsByTagId = {};
  final Map<String, ProductTag> _productTagsById = {};
  String? _selectedProductTagId;
  bool _hasLoadedInitialData = false;

  Map<String, List<Product>> get featuredProductsByTagId =>
      Map.unmodifiable(_featuredProductsByTagId);
  Map<String, ProductTag> get productTagsById =>
      Map.unmodifiable(_productTagsById);
  String? get selectedProductTagId => _selectedProductTagId;
  bool get hasLoadedInitialData => _hasLoadedInitialData;

  bool hasMoreFeaturedProductsToLoad(String tagId) {
    return _lastProductIdsByTagId[tagId] != null;
  }

  void setSelectedProductTag(ProductTag productTag) {
    if (productTag.id == _selectedProductTagId) {
      return;
    }

    _selectedProductTagId = productTag.id;
    notifyListeners();
  }

  void clearSelectedProductTag() {
    _selectedProductTagId = null;
    notifyListeners();
  }

  void loadMoreFeaturedProductsForTagId(String tagId) async {
    if (!hasMoreFeaturedProductsToLoad(tagId)) return;

    final lastProductId = _lastProductIdsByTagId[tagId];
    if (lastProductId == null) return;

    final products = await _productRepository.getFeaturedProducts(
      tagIds: [tagId],
      lastProductId: lastProductId,
    );

    if (products.isNotEmpty) {
      _featuredProductsByTagId[tagId]!.addAll(products);
      _lastProductIdsByTagId[tagId] = products.last.id;
    } else {
      _lastProductIdsByTagId[tagId] = null;
    }

    notifyListeners();
  }

  void loadInitialData() async {
    if (_hasLoadedInitialData) return;

    final loadedProductTags = await _productRepository.getProductTags();

    _productTagsById.clear();

    for (final productTag in loadedProductTags) {
      _productTagsById[productTag.id] = productTag;
    }

    final products = await _productRepository.getFeaturedProducts();

    for (var product in products) {
      final tagId = product.tagIds.first;

      if (_featuredProductsByTagId[tagId] == null) {
        _featuredProductsByTagId[tagId] = [];
      }

      _featuredProductsByTagId[tagId]!.add(product);
    }

    _lastProductIdsByTagId.clear();

    for (final tagId in _featuredProductsByTagId.keys) {
      _lastProductIdsByTagId[tagId] = _featuredProductsByTagId[tagId]!.last.id;
    }

    _hasLoadedInitialData = true;
    notifyListeners();
  }

  Future<ProductDetails> findProductAndRelated(String productId) {
    return _productRepository.findProductAndRelated(
      productId: productId,
    );
  }
}
