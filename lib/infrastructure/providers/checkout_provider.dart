import 'package:consumer_pingou_com/domain/entities/product.dart';
import 'package:consumer_pingou_com/domain/repositories/product_repository.dart';
import 'package:flutter/material.dart';

class CheckoutProvider extends ChangeNotifier {
  final ProductRepository _productRepository;

  CheckoutProvider(this._productRepository);

  final List<MapEntry<Product, double>> _cartEntries = [
    MapEntry(
      Product(
        id: '1',
        name: 'Cachaça 1',
        description: 'Descrição da cachaça 1',
        image: 'assets/img/sagatiba.jpeg',
        category: 'Recomendados',
        price: 25.25,
        stock: 2,
      ),
      1,
    ),
    MapEntry(
      Product(
        id: '2',
        name: 'Cachaça 2',
        description: 'Descrição da cachaça 2',
        image: 'assets/img/matuta.jpeg',
        category: 'Recomendados',
        price: 50.25,
        stock: 2,
      ),
      2,
    ),
    MapEntry(
      Product(
        id: '3',
        name: 'Cachaça 3',
        description: 'Descrição da cachaça 3',
        category: "Prata",
        image: 'assets/img/sagatiba.jpeg',
        price: 25.25,
        stock: 2,
      ),
      3,
    ),
  ];

  bool _isLoadingProducts = false;

  bool get isEmpty => _cartEntries.isEmpty;
  int get count => _cartEntries.length;
  Map<Product, double> get cartEntries => Map.fromEntries(_cartEntries);
  double get subtotal => _cartEntries.fold(
        0,
        (total, entry) => total + entry.key.price * entry.value,
      );

  bool get isLoadingProducts => _isLoadingProducts;

  void add(Product product, {double quantity = 1}) {
    final entryIndex = _cartEntries.indexWhere((entry) => entry.key == product);

    if (entryIndex >= 0) {
      final newQuantity = _cartEntries[entryIndex].value + quantity;
      _cartEntries[entryIndex] = MapEntry(product, newQuantity);
    } else {
      _cartEntries.add(MapEntry(product, quantity));
    }

    notifyListeners();
  }

  void remove(Product product) {
    _cartEntries.removeWhere((entry) => entry.key == product);
    notifyListeners();
  }

  void setQuantity(Product product, double quantity) {
    if (quantity <= 0) {
      remove(product);
      return;
    }

    final entryIndex = _cartEntries.indexWhere((entry) => entry.key == product);

    if (entryIndex >= 0) {
      _cartEntries[entryIndex] = MapEntry(product, quantity);
    } else {
      add(product, quantity: quantity);
    }

    notifyListeners();
  }

  void clear() {
    _cartEntries.clear();
    notifyListeners();
  }

  void refreshProducts() async {
    _isLoadingProducts = true;
    notifyListeners();

    final productIds = _cartEntries.map((entry) => entry.key.id).toList();
    final updatedProducts =
        await _productRepository.getProductsById(productIds);

    _cartEntries.removeWhere(
      (entry) =>
          updatedProducts.indexWhere((product) => product.id == entry.key.id) ==
          -1,
    );

    for (final product in updatedProducts) {
      final entryIndex =
          _cartEntries.indexWhere((entry) => entry.key == product);

      if (entryIndex >= 0) {
        _cartEntries[entryIndex] =
            MapEntry(product, _cartEntries[entryIndex].value);
      }
    }

    _isLoadingProducts = false;
    notifyListeners();
  }
}
