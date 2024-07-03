import 'package:consumer_pingou_com/domain/enums/token_type.dart';

class Token {
  final TokenType type;

  final String digest;

  final DateTime expiresAt;

  Token({
    required this.type,
    required this.digest,
    required this.expiresAt,
  });
}
