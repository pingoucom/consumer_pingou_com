import 'package:consumer_pingou_com/domain/enums/order_status.dart';
import 'package:flutter/material.dart';

class OrderStatusMessageFactory {
  static List<TextSpan> _makeReceivedMessage() {
    return const [
      TextSpan(text: 'Seu pedido foi '),
      TextSpan(
        text: 'recebido',
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      TextSpan(text: '!'),
    ];
  }

  static List<TextSpan> _makeConfirmedMessage() {
    return const [
      TextSpan(text: 'Nós já '),
      TextSpan(
        text: 'confirmamos',
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      TextSpan(text: ' seu pedido'),
    ];
  }

  static List<TextSpan> _makePreparingMessage() {
    return const [
      TextSpan(text: 'Estamos '),
      TextSpan(
        text: 'preparando',
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      TextSpan(text: ' seu pedido'),
    ];
  }

  static List<TextSpan> _makeReadyMessage() {
    return const [
      TextSpan(text: 'Seu pedido está '),
      TextSpan(
        text: 'pronto',
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      TextSpan(text: '!'),
    ];
  }

  static List<TextSpan> _makeOnTheWayMessage() {
    return const [
      TextSpan(text: 'Seu pedido está '),
      TextSpan(
        text: 'a caminho',
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      TextSpan(text: '!'),
    ];
  }

  static List<TextSpan> _makeDeliveredMessage() {
    return const [
      TextSpan(text: 'Oba! Seu pedido '),
      TextSpan(
        text: 'chegou',
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      TextSpan(text: '!'),
    ];
  }

  static List<TextSpan> _makeCanceledMessage() {
    return const [
      TextSpan(text: 'Esse pedido foi '),
      TextSpan(
        text: 'cancelado',
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      TextSpan(text: '!'),
    ];
  }

  static List<TextSpan> _makeErrorMessage() {
    return const [
      TextSpan(text: 'Ops! Algo deu '),
      TextSpan(
        text: 'errado',
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      TextSpan(text: '!'),
    ];
  }

  static List<TextSpan> make(OrderStatus orderStatus) {
    switch (orderStatus) {
      case OrderStatus.received:
        return _makeReceivedMessage();
      case OrderStatus.confirmed:
        return _makeConfirmedMessage();
      case OrderStatus.preparing:
        return _makePreparingMessage();
      case OrderStatus.ready:
        return _makeReadyMessage();
      case OrderStatus.onTheWay:
        return _makeOnTheWayMessage();
      case OrderStatus.delivered:
        return _makeDeliveredMessage();
      case OrderStatus.canceled:
        return _makeCanceledMessage();
      default:
        return _makeErrorMessage();
    }
  }
}
