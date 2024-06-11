import 'package:consumer_pingou_com/presentation/layouts/bottom_sheet_screen_layout.dart';
import 'package:consumer_pingou_com/presentation/partials/address/address_form.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AddressScreen extends StatelessWidget {
  const AddressScreen({super.key});

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
          onAddressSubmitted: (_) => GoRouter.of(context).replace('/home'),
        ),
      ],
    );
  }
}
