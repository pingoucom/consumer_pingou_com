part of 'screen.dart';

class _CreditCardSection extends StatelessWidget {
  final CreditCard creditCard;

  const _CreditCardSection({
    required this.creditCard,
  });

  @override
  Widget build(BuildContext context) {
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
                  creditCard: creditCard,
                  isSelected: false,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

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
