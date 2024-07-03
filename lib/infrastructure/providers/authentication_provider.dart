import 'package:consumer_pingou_com/domain/entities/token.dart';
import 'package:consumer_pingou_com/domain/entities/user.dart';
import 'package:consumer_pingou_com/domain/repositories/authentication_repository.dart';
import 'package:consumer_pingou_com/http.dart';
import 'package:flutter/material.dart';

class AuthenticationProvider extends ChangeNotifier {
  final AuthenticationRepository _authenticationRepository;

  AuthenticationProvider(this._authenticationRepository);

  Token? _token;

  User? _user;

  Token? get token => _token;

  User? get user => _user;

  void _authenticate(Token token, User user) {
    _token = token;
    _user = user;

    HttpRequestExecutor.setToken(token.digest);

    notifyListeners();
  }

  Future<bool> signIn(String email, String password) async {
    final result = await _authenticationRepository.signIn(email, password);

    if (result == null) {
      return false;
    }

    _authenticate(result.token, result.user);

    return true;
  }

  Future<bool> signUp(String name, String email, String password) async {
    final result = await _authenticationRepository.signUp(
      name,
      email,
      password,
    );

    if (result == null) {
      return false;
    }

    _authenticate(result.token, result.user);

    return true;
  }
}
