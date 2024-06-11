import 'package:consumer_pingou_com/domain/entities/address.dart';
import 'package:consumer_pingou_com/domain/entities/credit_card.dart';
import 'package:consumer_pingou_com/domain/entities/order.dart';
import 'package:consumer_pingou_com/domain/entities/product.dart';
import 'package:consumer_pingou_com/domain/repositories/order_repository.dart';
import 'package:flutter/material.dart';

class OrderProvider extends ChangeNotifier {
  final OrderRepository _orderRepository;

  OrderProvider(this._orderRepository);

  final List<Order> _userOrders = [];
  bool _hasLoadedInitialOrders = false;

  List<Order> get userOrders => List.unmodifiable(_userOrders);
  bool get hasLoadedInitialOrders => _hasLoadedInitialOrders;

  Future<void> add(Map<Product, double> product, Address address,
      CreditCard creditCard) async {
    final storedOrder =
        await _orderRepository.add(product, address, creditCard);

    _userOrders.add(storedOrder);

    notifyListeners();
  }

  void loadInitialOrders() async {
    if (_hasLoadedInitialOrders) return;

    final orders = await _orderRepository.get();

    _userOrders.clear();
    _userOrders.addAll(orders);
    _hasLoadedInitialOrders = true;

    notifyListeners();
  }

  Future<Order?> find(String orderId) async {
    return _orderRepository.find(orderId);
  }
}
