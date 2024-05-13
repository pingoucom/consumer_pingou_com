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
}
