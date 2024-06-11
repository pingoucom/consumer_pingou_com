part of 'screen.dart';

class _AddressSection extends StatelessWidget {
  final Address address;

  const _AddressSection({
    required this.address,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            'Endereço de entrega',
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ),
        const SizedBox(height: 4),
        Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 14),
                child: AddressCard(
                  address: address,
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
          child: AddressCard.skeleton(context, null),
        ),
      ],
    );
  }
}
