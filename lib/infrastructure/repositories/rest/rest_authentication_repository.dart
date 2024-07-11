import 'dart:convert';
import 'dart:io';

import 'package:consumer_pingou_com/domain/dto/authentication_result.dart';
import 'package:consumer_pingou_com/domain/entities/token.dart';
import 'package:consumer_pingou_com/domain/entities/user.dart';
import 'package:consumer_pingou_com/domain/enums/token_type.dart';
import 'package:consumer_pingou_com/domain/repositories/authentication_repository.dart';

class RestAuthenticationRepository implements AuthenticationRepository {
  final HttpClient _httpClient = HttpClient();

  final String _apiUrl = 'http://10.0.2.2:8000';

  @override
  Future<AuthenticationResult?> signIn(
    String email,
    String password,
  ) async {
    final uri = Uri.parse('$_apiUrl/auth/sign-in');

    try {
      final request = await _httpClient.postUrl(uri);
      request.headers.contentType = ContentType.json;
      request.write(jsonEncode({
        'email': email,
        'password': password,
      }));

      final response = await request.close();
      final data = jsonDecode(await response.transform(utf8.decoder).join());

      return _parseAuthenticationResult(data);
    } catch (e) {
      return null;
    }
  }

  @override
  Future<AuthenticationResult?> signUp(
    String name,
    String email,
    String password,
  ) async {
    final uri = Uri.parse('$_apiUrl/auth/sign-up');

    try {
      final request = await _httpClient.postUrl(uri);
      request.headers.contentType = ContentType.json;
      request.write(jsonEncode({
        'name': name,
        'email': email,
        'password': password,
      }));

      final response = await request.close();
      final data = jsonDecode(await response.transform(utf8.decoder).join());

      return _parseAuthenticationResult(data);
    } catch (e) {
      return null;
    }
  }

  AuthenticationResult _parseAuthenticationResult(Map<String, dynamic> data) {
    return AuthenticationResult(
      token: Token(
        type: TokenType.bearer,
        digest: data['token']['digest'],
        expiresAt: DateTime.parse(data['token']['expires_at']),
      ),
      user: User(
        id: data['user']['id'],
        name: data['user']['name'],
        email: data['user']['email'],
      ),
    );
  }
}
