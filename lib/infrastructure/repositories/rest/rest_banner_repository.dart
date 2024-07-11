import 'dart:convert';
import 'dart:io';

import 'package:consumer_pingou_com/domain/entities/banner.dart';
import 'package:consumer_pingou_com/domain/repositories/banner_repository.dart';
import 'package:consumer_pingou_com/http.dart';

class RestBannerRepository implements BannerRepository {
  final HttpClient _httpClient = HttpClient();

  final String _apiUrl = 'http://10.0.2.2:8000';

  @override
  Future<List<Banner_class>> getAvailableBanner() async {
    final uri = Uri.parse('$_apiUrl/promotional-banner-index');

    final request = await _httpClient.getUrl(uri);

    final response = await HttpRequestExecutor.execute(request);
    final data = jsonDecode(await response.transform(utf8.decoder).join());

    return List.generate(
      data.length,
      (index) => Banner_class(
        id: data[index]['id'].toString(),
        category: data[index]['name'],
        image: data[index]['imageUrl'],
        deeplink: data[index]['deeplink'],
      ),
    );
  }
}
