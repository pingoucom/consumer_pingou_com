import 'package:consumer_pingou_com/presentation/validators/rule.dart';

class Validator {
  static Rule all(List<Rule> rules) {
    return (String? value) {
      String? result;
      var ruleIndex = 0;

      while (result == null && ruleIndex < rules.length) {
        result = rules[ruleIndex](value);
        ruleIndex++;
      }

      return result;
    };
  }

  static Rule required() {
    return (String? value) {
      if (value == null || value.isEmpty) {
        return 'Essa informação é obrigatória';
      }

      return null;
    };
  }

  static Rule length(int expected) {
    return (String? value) {
      if (value == null || value.length != expected) {
        return 'Essa informação deve ter $expected caracteres';
      }

      return null;
    };
  }

  static Rule minLength(int expected) {
    return (String? value) {
      if (value == null || value.length < expected) {
        return 'Essa informação deve ter no mínimo $expected caracteres';
      }

      return null;
    };
  }

  static Rule email() {
    const pattern = r"^[\d\w_\-\.]+@[\d\w]{2,}(\.[\d\w]{2,})+$";
    final regex = RegExp(pattern);

    return (String? value) {
      if (value == null || !regex.hasMatch(value)) {
        return 'E-mail inválido';
      }

      return null;
    };
  }
}
