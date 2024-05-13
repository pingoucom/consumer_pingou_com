import 'package:consumer_pingou_com/domain/entities/product.dart';
import 'package:consumer_pingou_com/domain/repositories/product_repository.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class HomeScreenProvider extends ChangeNotifier {
  final ProductRepository _productRepository;

  HomeScreenProvider(this._productRepository);
  List<Product> _availableProducts = [];
  bool _isLoadingAvailableProducts = false;
  bool _hasLoadedAvailableProducts = false;

  List<Product> get availableProducts => _availableProducts;
  bool get isLoadingAvailableProducts => _isLoadingAvailableProducts;
  bool get hasLoadedAvailableProducts => _hasLoadedAvailableProducts;

  void loadAvailableProducts() async {
    if (_hasLoadedAvailableProducts) return;

    _isLoadingAvailableProducts = true;
    notifyListeners();

    List<Product> products = await _productRepository.getAvailableProducts();
    _availableProducts = products;
    _hasLoadedAvailableProducts = true;
    _isLoadingAvailableProducts = false;
    notifyListeners();
  }

  void refreshAvailableProducts() async {
    if (_isLoadingAvailableProducts) return;

    _isLoadingAvailableProducts = true;
    notifyListeners();

    List<Product> products = await _productRepository.getAvailableProducts();
    _availableProducts = products;
    _isLoadingAvailableProducts = false;
    notifyListeners();
  }

  List<String> get availableCategories {
    return _availableProducts
        .map((product) => product.category)
        .toSet()
        .toList();
  }

  Map<String, List<Product>> get groupedProductsByCategory {
    Map<String, List<Product>> groupedProducts = {};
    for (var product in _availableProducts) {
      if (groupedProducts.containsKey(product.category)) {
        groupedProducts[product.category]!.add(product);
      } else {
        groupedProducts[product.category] = [product];
      }
    }
    return groupedProducts;
  }

  List<String> getCategoryNames() {
    return _availableProducts
        .map((product) => product.category)
        .toSet()
        .toList();
  }

  List<Product> getProductsByCategory(String category) {
    return _availableProducts
        .where((product) => product.category == category)
        .toList();
  }
}
