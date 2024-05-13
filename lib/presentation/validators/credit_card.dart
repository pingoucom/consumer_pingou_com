import 'package:consumer_pingou_com/presentation/validators/rule.dart';

class CreditCardValidator {
  const CreditCardValidator();

  static Rule expirationDate() {
    return (String? value) {
      if (value == null || value.isEmpty) {
        return 'Campo obrigatório';
      }

      final expirationDate = value.split('/');

      if (expirationDate.length != 2) {
        return 'Data inválida';
      }

      final month = int.tryParse(expirationDate[0]);
      final year = int.tryParse(expirationDate[1]);

      if (month == null || month < 1 || month > 12) {
        return 'Mês inválido';
      }

      if (year == null || year < 0) {
        return 'Ano inválido';
      }

      final cardValidityDate = DateTime(2000 + year, month, 0);

      if (cardValidityDate.isBefore(DateTime.now())) {
        return 'Cartão expirado';
      }

      return null;
    };
  }
}
