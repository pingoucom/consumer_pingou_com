part of 'screen.dart';

class _AddressSection extends StatelessWidget {
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
                  child: AddressCard(
                    address: addressProvider.selectedAddress,
                    isSelected: false,
                    trailing: IconButton(
                      onPressed: () =>
                          GoRouter.of(context).pushReplacement('/addresses'),
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
