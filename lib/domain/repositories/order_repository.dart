import 'package:consumer_pingou_com/domain/entities/address.dart';
import 'package:consumer_pingou_com/domain/entities/credit_card.dart';
import 'package:consumer_pingou_com/domain/entities/order.dart';
import 'package:consumer_pingou_com/domain/entities/product.dart';

abstract class OrderRepository {
  Future<Order> add(
      Map<Product, double> items, Address address, CreditCard creditCard);

  Future<List<Order>> get();

  Future<Order?> find(String orderId);
}
