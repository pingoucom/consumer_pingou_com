import 'dart:math';

import 'package:consumer_pingou_com/domain/entities/product.dart';
import 'package:consumer_pingou_com/domain/entities/product_tag.dart';
import 'package:consumer_pingou_com/domain/repositories/product_repository.dart';

class MockedProductRepository implements ProductRepository {
  final Random _random = Random();

  final List<Product> _products = [
    Product(
      id: '1',
      name: 'Cachaça 1',
      description: 'Descrição da cachaça 1',
      image: 'assets/img/sagatiba.jpeg',
      category: 'Recomendados',
      price: 25.25,
      stock: 2,
    ),
    Product(
      id: '2',
      name: 'Cachaça 2',
      description: 'Descrição da cachaça 2',
      image: 'assets/img/matuta.jpeg',
      category: 'Recomendados',
      price: 50.25,
      stock: 2,
    ),
    Product(
      id: '3',
      name: 'Cachaça 3',
      description: 'Descrição da cachaça 3',
      category: "Prata",
      image: 'assets/img/sagatiba.jpeg',
      price: 25.25,
      stock: 2,
    ),
    Product(
      id: '4',
      name: 'Cachaça 4',
      description: 'Descrição da cachaça 4',
      category: "Dourada",
      image: 'assets/img/matuta.jpeg',
      price: 50.25,
      stock: 2,
    ),
  ];

  final List<ProductTag> _featuredProductTags = [
    ProductTag(
      id: '1',
      slug: 'recommended',
    ),
    ProductTag(
      id: '2',
      slug: 'new',
    ),
    ProductTag(
      id: '3',
      slug: 'regional',
    ),
    ProductTag(
      id: '4',
      slug: 'yellow',
    ),
  ];

  @override
  Future<List<Product>> getAvailableProducts() async {
    int delayInMilliseconds = 1000 + _random.nextInt(2000);

    return Future.delayed(
      Duration(milliseconds: delayInMilliseconds),
      () => _products,
    );
  }

  @override
  Future<List<Product>> getProductsById(List<String> ids) async {
    int delayInMilliseconds = 1000 + _random.nextInt(2000);

    return Future.delayed(
      Duration(milliseconds: delayInMilliseconds),
      () => _products.where((product) => ids.contains(product.id)).toList(),
    );
  }

  @override
  Future<List<ProductTag>> getFeaturedProductTags() async {
    int delayInMilliseconds = 1000 + _random.nextInt(2000);

    return Future.delayed(
      Duration(milliseconds: delayInMilliseconds),
      () => _featuredProductTags,
    );
  }
}
