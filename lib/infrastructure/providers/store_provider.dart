import 'package:consumer_pingou_com/domain/dto/product/product_details.dart';
import 'package:consumer_pingou_com/domain/entities/product.dart';
import 'package:consumer_pingou_com/domain/repositories/product_repository.dart';
import 'package:flutter/material.dart';

class StoreProvider extends ChangeNotifier {
  final ProductRepository _productRepository;

  StoreProvider(this._productRepository);

  final List<Product> _products = [];
  bool _hasLoadedInitialData = false;

  List<Product> get products => List.unmodifiable(_products);
  bool get hasLoadedInitialData => _hasLoadedInitialData;

  void loadInitialData() async {
    if (_hasLoadedInitialData) return;

    final products = await _productRepository.getAllProducts();

    _products.addAll(products);

    _hasLoadedInitialData = true;
    notifyListeners();
  }

  findProduct(String productId) {}
}
