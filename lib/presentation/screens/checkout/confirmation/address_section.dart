part of 'screen.dart';

class _AddressSection extends StatefulWidget {
  @override
  State<_AddressSection> createState() => _AddressSectionState();
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
    return Consumer<AddressProvider>(builder: (context, addressProvider, _) {
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
                  child: addressProvider.hasLoadedInitialData
                      ? AddressCard(
                          address: addressProvider.selectedAddress,
                          isSelected: false,
                          trailing: IconButton(
                            onPressed: () =>
                                GoRouter.of(context).push('/addresses'),
                            icon: const Icon(Icons.sync_alt),
                          ),
                        )
                      : AddressCard.skeleton(
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
