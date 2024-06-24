class CreditCardInput {
  final String userId;
  final String holderName;
  final String holderDocument;
  final String number;
  final String expirationDate;
  final String cvv;

  CreditCardInput({
    required this.userId,
    required this.holderName,
    required this.holderDocument,
    required this.number,
    required this.expirationDate,
    required this.cvv,
  });
}
