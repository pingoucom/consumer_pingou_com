part of 'screen.dart';

class _CreditCardSection extends StatefulWidget {
  @override
  State<_CreditCardSection> createState() => _CreditCardSectionState();
}

class _CreditCardSectionState extends State<_CreditCardSection> {
  @override
  void initState() {
    super.initState();

    final addressProvider = context.read<CreditCardProvider>();
    addressProvider.loadInitialData();
  }

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
                  child: creditCardProvider.hasLoadedInitialData
                      ? CreditCardCard(
                          creditCard: creditCardProvider.selectedCreditCard,
                          isSelected: false,
                          trailing: IconButton(
                            onPressed: () =>
                                GoRouter.of(context).push('/credit-cards'),
                            icon: const Icon(Icons.sync_alt),
                          ),
                        )
                      : CreditCardCard.skeleton(
                          context,
                          const Padding(
                            padding: EdgeInsets.only(right: 8),
                            child: SkeletonShape(
                              width: 40,
                              height: 40,
                              borderRadius: 20,
                            ),
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
