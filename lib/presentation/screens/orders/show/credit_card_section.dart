part of 'screen.dart';

class _CreditCardSection extends StatefulWidget {
  final String creditCardId;

  const _CreditCardSection({
    required this.creditCardId,
  });

  @override
  State<_CreditCardSection> createState() => _CreditCardSectionState();

  static skeleton(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: SkeletonShape(
            width: 148,
            height: 24,
            borderRadius: 12,
          ),
        ),
        const SizedBox(height: 4),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: CreditCardCard.skeleton(context, null),
        ),
      ],
    );
  }
}

class _CreditCardSectionState extends State<_CreditCardSection> {
  @override
  void initState() {
    super.initState();

    final creditCardProvider = context.read<CreditCardProvider>();
    creditCardProvider.loadInitialData();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<CreditCardProvider>(
      builder: (context, creditCardProvider, _) {
        if (!creditCardProvider.hasLoadedInitialData) {
          return _CreditCardSection.skeleton(context);
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                'Cartão de crédito',
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
            const SizedBox(height: 4),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: CreditCardCard(
                creditCard: creditCardProvider.userCreditCards.firstWhere(
                  (creditCard) => creditCard.id == widget.creditCardId,
                ),
                isSelected: false,
              ),
            ),
          ],
        );
      },
    );
  }
}
