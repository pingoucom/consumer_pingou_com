import 'package:consumer_pingou_com/domain/entities/cachaca.dart';
import 'package:flutter/material.dart';

class Shop extends ChangeNotifier {
  final List<Cachaca> _shop = [
    Cachaca(
        id: 1,
        name: 'Sagatiba',
        description: "Cachaça Sagatiba",
        image: "assets/img/sagatiba.jpeg",
        price: 25.25,
        stock: 2),
    Cachaca(
        id: 2,
        name: 'matuta',
        description: "Cachaça Matuta",
        image: "assets/img/matuta.jpeg",
        price: 50.25,
        stock: 2),
    Cachaca(
        id: 3,
        name: 'Sagatiba3',
        description: "Cachaça Sagatiba",
        image: "assets/img/sagatiba.jpeg",
        price: 25.25,
        stock: 2),
    Cachaca(
        id: 4,
        name: 'matuta2',
        description: "Cachaça matuta",
        image: "assets/img/matuta.jpeg",
        price: 50.25,
        stock: 2),
  ];
  List<Cachaca> _cart = [];

  List<Cachaca> get shop => _shop;

  List<Cachaca> get cart => _cart;

  void addToCart(Cachaca cachaca) {
    _cart.add(cachaca);
    notifyListeners();
  }

  void removeFromCart(Cachaca cachaca) {
    _cart.remove(cachaca);
    notifyListeners();
  }
}
