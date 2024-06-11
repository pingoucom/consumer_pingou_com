import 'package:consumer_pingou_com/domain/entities/address.dart';
import 'package:consumer_pingou_com/domain/entities/credit_card.dart';
import 'package:consumer_pingou_com/domain/entities/product.dart';
import 'package:consumer_pingou_com/domain/enums/order_status.dart';

class Order {
  final String id;
  final OrderStatus status;
  final Map<Product, double> items;
  final Address address;
  final CreditCard creditCard;
  final double serviceFee;
  final double deliveryFee;
  final double total;
  final DateTime createdAt;

  Order({
    required this.id,
    required this.status,
    required this.items,
    required this.address,
    required this.creditCard,
    required this.serviceFee,
    required this.deliveryFee,
    required this.total,
    required this.createdAt,
  });
}
