part of 'screen.dart';

class _AddressSection extends StatefulWidget {
  final String addressId;

  const _AddressSection({
    required this.addressId,
  });

  @override
  State<_AddressSection> createState() => _AddressSectionState();

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

class _AddressSectionState extends State<_AddressSection> {
  @override
  void initState() {
    super.initState();

    final addressProvider = context.read<AddressProvider>();
    addressProvider.loadInitialData();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AddressProvider>(
      builder: (context, addressProvider, _) {
        if (!addressProvider.hasLoadedInitialData) {
          return _AddressSection.skeleton(context);
        }

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
                      address: addressProvider.userAddresses.firstWhere(
                        (address) => address.id == widget.addressId,
                      ),
                      isSelected: false,
                    ),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
