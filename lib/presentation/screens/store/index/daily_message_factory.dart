part of 'screen.dart';

class _DailyMessageFactory {
  static List<TextSpan> _makeMondayMessage() {
    return const [
      TextSpan(text: 'Bora '),
      TextSpan(
        text: 'começar',
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      TextSpan(text: ' a semana direito!'),
    ];
  }

  static List<TextSpan> _makeTuesdayMessage() {
    return const [
      TextSpan(text: 'Que tal '),
      TextSpan(
        text: 'animar',
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      TextSpan(text: ' a terça?'),
    ];
  }

  static List<TextSpan> _makeWednesdayMessage() {
    return const [
      TextSpan(text: 'A semana já '),
      TextSpan(
        text: 'está',
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      TextSpan(text: ' na metade!'),
    ];
  }

  static List<TextSpan> _makeThursdayMessage() {
    return const [
      TextSpan(text: 'Respira! Falta '),
      TextSpan(
        text: 'pouco',
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      TextSpan(text: ' para a sexta!'),
    ];
  }

  static List<TextSpan> _makeFridayMessage() {
    return const [
      TextSpan(text: 'Bora '),
      TextSpan(
        text: 'sextar',
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      TextSpan(text: ' com tudo!'),
    ];
  }

  static List<TextSpan> _makeSaturdayMessage() {
    return const [
      TextSpan(text: 'Hora de '),
      TextSpan(
        text: 'animar',
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      TextSpan(text: ' o sábado!'),
    ];
  }

  static List<TextSpan> _makeSundayMessage() {
    return const [
      TextSpan(text: 'Dia de '),
      TextSpan(
        text: 'descansar',
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      TextSpan(text: ' e recarregar as energias!'),
    ];
  }

  static List<TextSpan> _makeDefaultMessage() {
    return const [
      TextSpan(text: 'Bom '),
      TextSpan(
        text: 'dia',
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      TextSpan(text: '!'),
    ];
  }

  static List<TextSpan> make() {
    final now = DateTime.now();
    final day = now.weekday;

    switch (day) {
      case DateTime.monday:
        return _makeMondayMessage();
      case DateTime.tuesday:
        return _makeTuesdayMessage();
      case DateTime.wednesday:
        return _makeWednesdayMessage();
      case DateTime.thursday:
        return _makeThursdayMessage();
      case DateTime.friday:
        return _makeFridayMessage();
      case DateTime.saturday:
        return _makeSaturdayMessage();
      case DateTime.sunday:
        return _makeSundayMessage();
      default:
        return _makeDefaultMessage();
    }
  }
}
