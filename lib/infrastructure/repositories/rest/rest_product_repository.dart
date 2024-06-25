import 'dart:convert';
import 'dart:io';

import 'package:consumer_pingou_com/domain/dto/product/product_details.dart';
import 'package:consumer_pingou_com/domain/entities/product.dart';
import 'package:consumer_pingou_com/domain/entities/product_tag.dart';
import 'package:consumer_pingou_com/domain/repositories/product_repository.dart';

class RestProductRepository implements ProductRepository {
  final baseUri = 'http://10.0.2.2:8080/pingou';

  final HttpClient _httpClient = HttpClient();

  Future<void> subtractProductQuantity(int id, int quantity) async {
    final uri = Uri.parse('$baseUri/$id/remover_item/$quantity');

    final request = await _httpClient.patchUrl(uri);
    final response = await request.close();

    if (response.statusCode != 200) {
      throw Exception('Failed to subtract product quantity');
    }
  }

  @override
  Future<ProductDetails> findProductAndRelated(
      {required String productId}) async {
    try {
      Product product = await findProduct(productId: productId);

      List<Product> related = [product];

      return ProductDetails(product: product, related: related);
    } catch (e) {
      throw Exception('Failed to find product and related products: $e');
    }
  }

  @override
  Future<List<Product>> getAvailableProducts() async {
    final uri = Uri.parse('$baseUri/cachaca');
    final request = await _httpClient.getUrl(uri);
    final response = await request.close();
    final responseBody = await response.transform(utf8.decoder).join();

    if (response.statusCode != 200) {
      throw Exception('Failed to load products');
    }

    final responseJson = jsonDecode(responseBody);

    return (responseJson as List).map((productJson) {
      return Product(
        id: productJson['cachaca_id'].toString(),
        name: productJson['nome'],
        price: productJson['valor'],
        description: productJson['descricao'],
        category: productJson['tipo'],
        image: '',
        stock: productJson['quantidade'],
      );
    }).toList();
  }

  @override
  Future<List<Product>> getProductsById(List<String> ids) async {
    List<Product> products = [];
    for (String id in ids) {
      final uri = Uri.parse('$baseUri/cachaca/$id');
      final request = await _httpClient.getUrl(uri);
      final response = await request.close();
      final responseBody = await response.transform(utf8.decoder).join();
      if (response.statusCode != 200) {
        throw Exception('Failed to load product with ID: $id');
      }
      final productJson = jsonDecode(responseBody);
      products.add(Product(
        id: productJson['cachaca_id'].toString(),
        name: productJson['nome'],
        price: productJson['valor'],
        description: productJson['descricao'],
        category: productJson['tipo'],
        image: '',
        stock: productJson['quantidade'],
      ));
    }
    return products;
  }

  @override
  getAllProducts() async {
    final uri = Uri.parse('$baseUri/cachaca');
    final request = await _httpClient.getUrl(uri);
    final response = await request.close();
    final responseBody = await response.transform(utf8.decoder).join();

    if (response.statusCode != 200) {
      throw Exception('Failed to load products');
    }

    final responseJson = jsonDecode(responseBody);

    return (responseJson as List).map((productJson) {
      return Product(
        id: productJson['cachaca_id'].toString(),
        name: productJson['nome'],
        price: productJson['valor'],
        description: productJson['descricao'],
        category: productJson['tipo'],
        image: '',
        stock: productJson['quantidade'],
      );
    }).toList();
  }

  @override
  Future<Product> findProduct({required String productId}) async {
    final uri = Uri.parse('$baseUri/cachaca/$productId');
    final request = await _httpClient.getUrl(uri);
    final response = await request.close();
    final responseBody = await response.transform(utf8.decoder).join();

    if (response.statusCode != 200) {
      throw Exception('Failed to load products');
    }

    final responseJson = jsonDecode(responseBody);

    return Product(
      id: responseJson['cachaca_id'].toString(),
      name: responseJson['nome'],
      price: responseJson['valor'],
      description: responseJson['descricao'],
      category: responseJson['tipo'],
      image: '',
      stock: responseJson['quantidade'],
    );
  }

  @override
  Future<List<Product>> getFeaturedProducts(
      {List<String>? tagIds, String? lastProductId}) {
    // TODO: implement getFeaturedProducts
    throw UnimplementedError();
  }

  @override
  Future<List<ProductTag>> getProductTags() {
    // TODO: implement getProductTags
    throw UnimplementedError();
  }
}
