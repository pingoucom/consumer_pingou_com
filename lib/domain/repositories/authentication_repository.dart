import 'package:consumer_pingou_com/domain/dto/authentication_result.dart';

abstract class AuthenticationRepository {
  Future<AuthenticationResult?> signIn(String email, String password);

  Future<AuthenticationResult?> signUp(
    String name,
    String email,
    String password,
  );
}
