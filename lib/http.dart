import 'dart:io';

class HttpRequestExecutor {
  static String? _token;

  static void setToken(String token) {
    _token = token;
  }

  static Future<HttpClientResponse> execute(HttpClientRequest request) async {
    if (_token != null) {
      request.headers.add('Authorization', 'Bearer $_token');
    }

    final HttpClientResponse response = await request.close();

    if (response.statusCode == 401) {
      throw Exception('Unauthorized');
    }

    return response;
  }

  static HttpClientRequest prepareRequest(HttpClientRequest request) {
    if (_token == null) {
      throw Exception('Token not set');
    }

    request.headers.add('Authorization', 'Bearer $_token');

    return request;
  }
}
