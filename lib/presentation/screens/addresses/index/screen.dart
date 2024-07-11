import 'package:consumer_pingou_com/domain/entities/address.dart';
import 'package:consumer_pingou_com/infrastructure/providers/address_provider.dart';
import 'package:consumer_pingou_com/presentation/components/skeleton_shape.dart';
import 'package:consumer_pingou_com/presentation/partials/address/address_card.dart';
import 'package:consumer_pingou_com/presentation/partials/address/address_form.dart';
import 'package:consumer_pingou_com/presentation/partials/product/blurred_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

part 'address_list.dart';

class AddressesIndexScreen extends StatefulWidget {
  const AddressesIndexScreen({super.key});

  @override
  State<AddressesIndexScreen> createState() => _AddressesIndexScreenState();
}

class _AddressesIndexScreenState extends State<AddressesIndexScreen> {
  @override
  void initState() {
    super.initState();

    final addressProvider = context.read<AddressProvider>();
    addressProvider.loadInitialData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surfaceVariant,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => GoRouter.of(context).canPop()
              ? GoRouter.of(context).pop()
              : GoRouter.of(context).push('/home'),
        ),
        title: const Text('Endereços'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: _AddressList(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => showModalBlurredBottomSheet(
          context: context,
          builder: (_) => _CreateAddressBottomSheet(),
        ),
        foregroundColor: Theme.of(context).colorScheme.onPrimary,
        backgroundColor: Theme.of(context).colorScheme.primary,
        child: const Icon(Icons.add),
      ),
    );
  }
}

class _CreateAddressBottomSheet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AddressForm(
      onAddressSubmitted: (submittedAddress) async {
        final addressProvider = context.read<AddressProvider>();
        await addressProvider.add(submittedAddress);

        if (context.mounted) {
          Navigator.of(context).pop();
        }
      },
    );
  }
}
