import 'package:consumer_pingou_com/domain/dto/address_input.dart';
import 'package:consumer_pingou_com/infrastructure/providers/address_provider.dart';
import 'package:consumer_pingou_com/main.dart';
import 'package:consumer_pingou_com/presentation/layouts/bottom_sheet_screen_layout.dart';
import 'package:consumer_pingou_com/presentation/partials/address/address_form.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class AddressScreen extends StatelessWidget {
  const AddressScreen({super.key});

  Future<void> _onAddressSubmitted(
      BuildContext context, AddressInput addressInput) async {
    final addressProvider = context.read<AddressProvider>();
    await addressProvider.add(addressInput);

    if (!context.mounted) {
      return;
    }

    GoRouter.of(context).clearStackAndNavigate('/home');
  }

  @override
  Widget build(BuildContext context) {
    return BottomSheetScreenLayout(
      icon: Icon(
        Icons.location_on,
        size: 32,
        color: Theme.of(context).colorScheme.onPrimaryContainer,
      ),
      message: const [
        TextSpan(text: 'Por fim, precisamos do seu '),
        TextSpan(
          text: 'endereço',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        TextSpan(text: '!'),
      ],
      children: [
        AddressForm(
          onAddressSubmitted: (input) => _onAddressSubmitted(context, input),
        ),
      ],
    );
  }
}
