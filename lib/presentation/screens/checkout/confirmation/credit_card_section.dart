part of 'screen.dart';

class _CreditCardSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<CreditCardProvider>(
        builder: (context, creditCardProvider, _) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              'Método de pagamento',
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ),
          const SizedBox(height: 4),
          Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 14),
                  child: CreditCardCard(
                    creditCard: creditCardProvider.selectedCreditCard,
                    isSelected: false,
                    trailing: IconButton(
                      onPressed: () =>
                          GoRouter.of(context).push('/credit-cards'),
                      icon: const Icon(Icons.sync_alt),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      );
    });
  }
}
