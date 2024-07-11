part of 'screen.dart';

class _AddressList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<AddressProvider>(
      builder: (context, addressProvider, _) {
        if (!addressProvider.hasLoadedInitialData) {
          return ListView.builder(
            itemCount: 4,
            itemBuilder: (context, index) => _AddressItem.skeleton(context),
          );
        }

        if (addressProvider.userAddresses.isEmpty) {
          return _EmptyState();
        }

        return ListView.builder(
          scrollDirection: Axis.vertical,
          itemCount: addressProvider.userAddresses.length,
          itemBuilder: (context, index) => _AddressItem(
            address: addressProvider.userAddresses.elementAt(index),
            selectedAddressId: addressProvider.selectedAddressId!,
            length: addressProvider.userAddresses.length,
          ),
        );
      },
    );
  }
}

class _EmptyState extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.close,
              size: 32,
              color: Theme.of(context).colorScheme.onSurface.withOpacity(0.8),
            ),
            Text(
              'Você ainda não tem endereços.',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ],
        ),
      ),
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

  static Widget skeleton(BuildContext context) {
    return AddressCard.skeleton(
      context,
      const Padding(
        padding: EdgeInsets.only(right: 8),
        child: SkeletonShape(
          width: 40,
          height: 40,
          borderRadius: 20,
        ),
      ),
    );
  }

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
          onTap: () async =>
              await context.read<AddressProvider>().deleteAddress(address),
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
