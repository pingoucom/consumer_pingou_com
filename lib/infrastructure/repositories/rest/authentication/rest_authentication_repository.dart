import 'dart:convert';
import 'dart:io';

import 'package:consumer_pingou_com/domain/entities/user.dart';
import 'package:consumer_pingou_com/domain/repositories/authentication_repository.dart';

class RestAuthenticationRepository implements AuthenticationRepository {
  final baseUri = 'http://10.0.2.2:8080/pingou';

  final HttpClient _httpClient = HttpClient();

  @override
  Future<User?> signIn(String email, String password) async {
    final uri = Uri.parse('$baseUri/sign-in');

    final request = await _httpClient.postUrl(uri);
    request.headers.contentType = ContentType.json;
    request.write('{"email": "$email", "senha": "$password"}');

    final response = await request.close();
    final responseBody = await response.transform(utf8.decoder).join();

    if (response.statusCode != 200) return null;

    final responseJson = jsonDecode(responseBody);

    return User(
      id: responseJson['usuario_id'].toString(),
      name: responseJson['nome_completo'],
      email: responseJson['email'],
    );
  }

  @override
  Future<User?> signUp(String name, String email, String password,
      String phoneNumber, DateTime birthDate) async {
    final uri = Uri.parse('$baseUri/sign-up');

    final request = await _httpClient.postUrl(uri);
    request.headers.contentType = ContentType.json;
    request.write(
      jsonEncode({
        'nome_completo': name,
        'email': email,
        'senha': password,
        'numero_contato': phoneNumber,
        'data_nascimento': birthDate.toIso8601String(),
      }),
    );

    final response = await request.close();
    final responseBody = await response.transform(utf8.decoder).join();

    if (response.statusCode != 201) return null;

    final responseJson = jsonDecode(responseBody);

    return User(
      id: responseJson['usuario_id'].toString(),
      name: responseJson['nome_completo'],
      email: responseJson['email'],
    );
  }
}
