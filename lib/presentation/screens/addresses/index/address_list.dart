part of 'screen.dart';

class _AddressList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<AddressProvider>(
      builder: (context, addressProvider, _) {
        return ListView.builder(
          scrollDirection: Axis.vertical,
          itemCount: addressProvider.userAddresses.length,
          itemBuilder: (context, index) => _AddressItem(
            address: addressProvider.userAddresses.elementAt(index),
            selectedAddressId: addressProvider.selectedAddressId,
            length: addressProvider.userAddresses.length,
          ),
        );
      },
    );
  }
}

class _AddressItem extends StatelessWidget {
  final Address address;
  final String selectedAddressId;
  final int length;

  const _AddressItem({
    required this.address,
    required this.selectedAddressId,
    required this.length,
  });

  @override
  Widget build(BuildContext context) {
    return AddressCard(
      address: address,
      onTap: () => context.read<AddressProvider>().setSelectedAddress(address),
      isSelected: address.id == selectedAddressId,
      trailing: length > 1
          ? _AddressOptionsMenu(
              address: address,
            )
          : IconButton(
              onPressed: () => showModalBlurredBottomSheet(
                context: context,
                builder: (_) => _EditAddressBottomSheet(
                  address: address,
                ),
              ),
              icon: const Icon(Icons.edit),
            ),
    );
  }
}

class _AddressOptionsMenu extends StatelessWidget {
  final Address address;

  const _AddressOptionsMenu({
    required this.address,
  });

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      icon: const Icon(Icons.more_vert),
      itemBuilder: (context) => [
        PopupMenuItem(
          onTap: () => showModalBlurredBottomSheet(
            context: context,
            builder: (_) => _EditAddressBottomSheet(
              address: address,
            ),
          ),
          child: const Row(
            children: [
              Icon(Icons.edit),
              SizedBox(width: 8),
              Text('Editar'),
            ],
          ),
        ),
        PopupMenuItem(
          onTap: () async {
            context.read<AddressProvider>().deleteAddress(address);
          },
          child: const Row(
            children: [
              Icon(Icons.delete),
              SizedBox(width: 8),
              Text('Excluir'),
            ],
          ),
        ),
      ],
    );
  }
}

class _EditAddressBottomSheet extends StatelessWidget {
  final Address address;

  const _EditAddressBottomSheet({required this.address});

  @override
  Widget build(BuildContext context) {
    return AddressForm(
      address: address,
      onAddressSubmitted: (input) async {
        final addressProvider = context.read<AddressProvider>();
        await addressProvider.update(address, input);

        if (context.mounted) {
          Navigator.of(context).pop();
        }
      },
    );
  }
}
