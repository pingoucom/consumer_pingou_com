import 'package:consumer_pingou_com/domain/entities/token.dart';
import 'package:consumer_pingou_com/domain/entities/user.dart';

class AuthenticationResult {
  final Token token;

  final User user;

  AuthenticationResult({
    required this.token,
    required this.user,
  });
}
