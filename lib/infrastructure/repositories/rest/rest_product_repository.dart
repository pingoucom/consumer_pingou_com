import 'dart:convert';
import 'dart:io';

import 'package:consumer_pingou_com/domain/dto/product/product_details.dart';
import 'package:consumer_pingou_com/domain/entities/product.dart';
import 'package:consumer_pingou_com/domain/entities/product_tag.dart';
import 'package:consumer_pingou_com/domain/repositories/product_repository.dart';
import 'package:consumer_pingou_com/http.dart';

class RestProductRepository implements ProductRepository {
  final HttpClient _httpClient = HttpClient();

  final String _apiUrl = 'http://10.0.2.2:8000';

  @override
  Future<List<Product>> getProductsById(List<String> ids) async {
    final uri = Uri.parse('$_apiUrl/product-index?productIds=${ids.join(',')}');

    final request = await _httpClient.getUrl(uri);

    final response = await HttpRequestExecutor.execute(request);
    final data = jsonDecode(await response.transform(utf8.decoder).join());

    return List.generate(
      data.length,
      (index) => Product(
        id: data[index]['id'],
        name: data[index]['name'],
        description: data[index]['description'],
        image: data[index]['image'],
        category: data[index]['category'],
        price: data[index]['price'],
        tagIds: (data[index]['tagIds'] as List<dynamic>)
            .map((e) => e.toString())
            .toList(),
      ),
    );
  }

  @override
  Future<List<ProductTag>> getProductTags() async {
    final uri = Uri.parse('$_apiUrl/tag-index');

    final request = await _httpClient.getUrl(uri);

    final response = await HttpRequestExecutor.execute(request);
    final data = jsonDecode(await response.transform(utf8.decoder).join());

    return List.generate(
      data.length,
      (index) => ProductTag(
        id: data[index]['id'],
        name: data[index]['name'],
        slug: data[index]['slug'],
        iconId: data[index]['iconId'],
      ),
    );
  }

  @override
  Future<List<Product>> getFeaturedProducts() async {
    final uri = Uri.parse('$_apiUrl/product-index-featured');

    final request = await _httpClient.getUrl(uri);

    final response = await HttpRequestExecutor.execute(request);
    final data = jsonDecode(await response.transform(utf8.decoder).join());

    return List.generate(
      data.length,
      (index) => Product(
        id: data[index]['id'],
        name: data[index]['name'],
        description: data[index]['description'],
        image: data[index]['image'],
        category: data[index]['category'],
        price: data[index]['price'],
        tagIds: (data[index]['tagIds'] as List<dynamic>)
            .map((e) => e.toString())
            .toList(),
      ),
    );
  }

  @override
  Future<ProductDetails> findProductAndRelated({
    required String productId,
  }) async {
    final uri = Uri.parse('$_apiUrl/product-details?id=$productId');

    final request = await _httpClient.getUrl(uri);

    final response = await HttpRequestExecutor.execute(request);
    final data = jsonDecode(await response.transform(utf8.decoder).join());

    final related = (data['related'] as List<dynamic>)
        .map((e) => _parseProduct(e))
        .toList();

    return ProductDetails(
      product: _parseProduct(data['product']),
      related: related,
    );
  }

  Product _parseProduct(Map<String, dynamic> data) {
    return Product(
      id: data['id'],
      name: data['name'],
      description: data['description'],
      image: data['image'],
      category: data['category'],
      price: data['price'],
      tagIds:
          (data['tagIds'] as List<dynamic>).map((e) => e.toString()).toList(),
    );
  }
}
