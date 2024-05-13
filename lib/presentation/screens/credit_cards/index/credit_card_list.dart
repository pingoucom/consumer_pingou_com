part of 'screen.dart';

class _CreditCardList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<CreditCardProvider>(
      builder: (context, creditCardProvider, _) {
        return ListView.builder(
          scrollDirection: Axis.vertical,
          itemCount: creditCardProvider.userCreditCards.length,
          itemBuilder: (context, index) => _CreditCardItem(
            creditCard: creditCardProvider.userCreditCards.elementAt(index),
            selectedCreditCardId: creditCardProvider.selectedCreditCardId,
            length: creditCardProvider.userCreditCards.length,
          ),
        );
      },
    );
  }
}

class _CreditCardItem extends StatelessWidget {
  final CreditCard creditCard;
  final String selectedCreditCardId;
  final int length;

  const _CreditCardItem({
    required this.creditCard,
    required this.selectedCreditCardId,
    required this.length,
  });

  @override
  Widget build(BuildContext context) {
    return CreditCardCard(
      creditCard: creditCard,
      onTap: () =>
          context.read<CreditCardProvider>().setSelectedCreditCard(creditCard),
      isSelected: creditCard.id == selectedCreditCardId,
      trailing: IconButton(
        onPressed: () async {
          context.read<CreditCardProvider>().deleteCreditCard(creditCard);
        },
        icon: const Icon(Icons.delete),
      ),
    );
  }
}
