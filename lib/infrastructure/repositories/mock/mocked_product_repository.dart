import 'dart:math';

import 'package:consumer_pingou_com/domain/dto/product/product_details.dart';
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

  final List<ProductTag> _productTags = [
    ProductTag(
      id: '1',
      slug: 'white',
      name: 'Brancas',
      iconId: 'star',
    ),
    ProductTag(
      id: '2',
      slug: 'new',
      name: 'Novas',
      iconId: 'new_releases',
    ),
    ProductTag(
      id: '3',
      slug: 'regional',
      name: 'Regionais',
      iconId: 'map',
    ),
    ProductTag(
      id: '4',
      slug: 'yellow',
      name: 'Amarelas',
      iconId: 'sunny',
    ),
    ProductTag(
      id: '5',
      slug: 'premium',
      name: 'Premium',
      iconId: 'grade',
    ),
    ProductTag(
      id: '6',
      slug: 'rare',
      name: 'Raras',
      iconId: 'emoji_events',
    ),
  ];

  final List<Product> _productsWithTags = [
    Product(
      id: '00',
      name: 'Lorem',
      description: 'Ipsum dolor lorem',
      image: 'assets/img/products/sample_product_0.jpeg',
      category: '1',
      price: 25.25,
      stock: 2,
      tagIds: [
        '6',
        '2',
        '3',
      ],
    ),
    Product(
      id: '01',
      name: 'Donec',
      description: 'Vel lacus donec',
      image: 'assets/img/products/sample_product_1.jpeg',
      category: '1',
      price: 25.25,
      stock: 2,
      tagIds: [
        '3',
        '6',
        '5',
      ],
    ),
    Product(
      id: '02',
      name: 'Duis',
      description: 'Congue cursus duis',
      image: 'assets/img/products/sample_product_2.jpeg',
      category: '1',
      price: 25.25,
      stock: 2,
      tagIds: [
        '6',
        '5',
        '4',
      ],
    ),
    Product(
      id: '03',
      name: 'Nam',
      description: 'Ut nunc nam',
      image: 'assets/img/products/sample_product_3.jpeg',
      category: '1',
      price: 25.25,
      stock: 2,
      tagIds: [
        '6',
        '1',
        '5',
      ],
    ),
    Product(
      id: '04',
      name: 'Fusce',
      description: 'Gravida porttitor fusce',
      image: 'assets/img/products/sample_product_4.jpeg',
      category: '1',
      price: 25.25,
      stock: 2,
      tagIds: [
        '2',
        '6',
        '4',
      ],
    ),
    Product(
      id: '05',
      name: 'Integer',
      description: 'Non orci integer',
      image: 'assets/img/products/sample_product_5.jpeg',
      category: '1',
      price: 25.25,
      stock: 2,
      tagIds: [
        '2',
        '3',
        '1',
      ],
    ),
    Product(
      id: '06',
      name: 'Aenean',
      description: 'Nec fermentum aenean',
      image: 'assets/img/products/sample_product_6.jpeg',
      category: '1',
      price: 25.25,
      stock: 2,
      tagIds: [
        '3',
        '2',
        '4',
      ],
    ),
    Product(
      id: '07',
      name: 'Proin',
      description: 'Elit tortor proin',
      image: 'assets/img/products/sample_product_7.jpeg',
      category: '1',
      price: 25.25,
      stock: 2,
      tagIds: [
        '4',
        '6',
        '2',
      ],
    ),
    Product(
      id: '08',
      name: 'Phasellus',
      description: 'Ullamcorper fermentum phasellus',
      image: 'assets/img/products/sample_product_8.jpeg',
      category: '1',
      price: 25.25,
      stock: 2,
      tagIds: [
        '6',
        '4',
        '5',
      ],
    ),
    Product(
      id: '09',
      name: 'Nullam',
      description: 'Iaculis libero nullam',
      image: 'assets/img/products/sample_product_9.jpeg',
      category: '1',
      price: 25.25,
      stock: 2,
      tagIds: [
        '4',
        '6',
        '1',
      ],
    ),
    Product(
      id: '10',
      name: 'Fusce',
      description: 'Dignissim ante fusce',
      image: 'assets/img/products/sample_product_10.jpeg',
      category: '1',
      price: 25.25,
      stock: 2,
      tagIds: [
        '6',
        '1',
        '4',
      ],
    ),
    Product(
      id: '11',
      name: 'Quisque',
      description: 'Luctus, quisque',
      image: 'assets/img/products/sample_product_11.jpeg',
      category: '1',
      price: 25.25,
      stock: 2,
      tagIds: [
        '1',
        '6',
        '5',
      ],
    ),
    Product(
      id: '12',
      name: 'In',
      description: 'Mattis nunc in',
      image: 'assets/img/products/sample_product_12.jpeg',
      category: '1',
      price: 25.25,
      stock: 2,
      tagIds: [
        '1',
        '5',
        '3',
      ],
    ),
    Product(
      id: '13',
      name: 'Aliquam',
      description: 'Erat volutpat aliquam',
      image: 'assets/img/products/sample_product_13.jpeg',
      category: '1',
      price: 25.25,
      stock: 2,
      tagIds: [
        '4',
        '1',
        '5',
      ],
    ),
    Product(
      id: '14',
      name: 'Fusce',
      description: 'Libero nisi fusce',
      image: 'assets/img/products/sample_product_14.jpeg',
      category: '1',
      price: 25.25,
      stock: 2,
      tagIds: [
        '5',
        '2',
        '3',
      ],
    ),
    Product(
      id: '15',
      name: 'Sed',
      description: 'Porta nisi sed',
      image: 'assets/img/products/sample_product_15.jpeg',
      category: '1',
      price: 25.25,
      stock: 2,
      tagIds: [
        '2',
        '4',
        '6',
      ],
    ),
    Product(
      id: '16',
      name: 'Mauris',
      description: 'Eleifend velit mauris',
      image: 'assets/img/products/sample_product_16.jpeg',
      category: '1',
      price: 25.25,
      stock: 2,
      tagIds: [
        '3',
        '1',
        '5',
      ],
    ),
    Product(
      id: '17',
      name: 'Mauris',
      description: 'Iaculis semper mauris',
      image: 'assets/img/products/sample_product_17.jpeg',
      category: '1',
      price: 25.25,
      stock: 2,
      tagIds: [
        '1',
        '4',
        '6',
      ],
    ),
    Product(
      id: '18',
      name: 'Ut',
      description: 'Non efficitur ut',
      image: 'assets/img/products/sample_product_18.jpeg',
      category: '1',
      price: 25.25,
      stock: 2,
      tagIds: [
        '1',
        '2',
        '3',
      ],
    ),
    Product(
      id: '19',
      name: 'Vivamus',
      description: 'Finibus, vivamus',
      image: 'assets/img/products/sample_product_19.jpeg',
      category: '1',
      price: 25.25,
      stock: 2,
      tagIds: [
        '2',
        '4',
        '5',
      ],
    ),
    Product(
      id: '20',
      name: 'In',
      description: 'At accumsan in',
      image: 'assets/img/products/sample_product_20.jpeg',
      category: '1',
      price: 25.25,
      stock: 2,
      tagIds: [
        '3',
        '4',
        '6',
      ],
    ),
    Product(
      id: '21',
      name: 'Praesent',
      description: 'Pulvinar, praesent',
      image: 'assets/img/products/sample_product_21.jpeg',
      category: '1',
      price: 25.25,
      stock: 2,
      tagIds: [
        '5',
        '1',
        '6',
      ],
    ),
    Product(
      id: '22',
      name: 'Donec',
      description: 'Lacinia metus donec',
      image: 'assets/img/products/sample_product_22.jpeg',
      category: '1',
      price: 25.25,
      stock: 2,
      tagIds: [
        '6',
        '4',
        '2',
      ],
    ),
    Product(
      id: '23',
      name: 'Suspendisse',
      description: 'Dapibus urna suspendisse',
      image: 'assets/img/products/sample_product_23.jpeg',
      category: '1',
      price: 25.25,
      stock: 2,
      tagIds: [
        '1',
        '2',
        '6',
      ],
    ),
    Product(
      id: '24',
      name: 'Cras',
      description: 'Tellus arcu cras',
      image: 'assets/img/products/sample_product_24.jpeg',
      category: '1',
      price: 25.25,
      stock: 2,
      tagIds: [
        '1',
        '3',
        '5',
      ],
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
  Future<List<ProductTag>> getProductTags() async {
    int delayInMilliseconds = 1000 + _random.nextInt(2000);

    return Future.delayed(
      Duration(milliseconds: delayInMilliseconds),
      () => _productTags,
    );
  }

  @override
  Future<List<Product>> getFeaturedProducts({
    List<String>? tagIds,
    String? lastProductId,
  }) async {
    int delayInMilliseconds = 1000 + _random.nextInt(2000);

    return Future.delayed(
      Duration(milliseconds: delayInMilliseconds),
      () => _productsWithTags
          .where((product) {
            if (tagIds == null) return true;

            return product.tagIds.any((tagId) => tagIds.contains(tagId));
          })
          .where((product) => product.id.compareTo(lastProductId ?? '') > 0)
          .toList(),
    );
  }

  @override
  Future<ProductDetails> findProductAndRelated(
      {required String productId}) async {
    int delayInMilliseconds = 1000 + _random.nextInt(2000);

    return Future.delayed(
      Duration(milliseconds: delayInMilliseconds),
      () {
        final product =
            _productsWithTags.firstWhere((product) => product.id == productId);

        final related = _productsWithTags
            .where((candidate) => candidate.tagIds.any((tagId) =>
                product.tagIds.contains(tagId) && candidate.id != product.id))
            .where((candidate) => candidate.id != productId)
            .toList();

        return ProductDetails(
          product: product,
          related: related,
        );
      },
    );
  }

  @override
  getAllProducts() {
    // TODO: implement getAllProducts
    throw UnimplementedError();
  }

  @override
  Future<Product> findProduct({required String productId}) {
    // TODO: implement findProduct
    throw UnimplementedError();
  }
}
