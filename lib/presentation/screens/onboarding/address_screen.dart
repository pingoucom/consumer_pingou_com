import 'package:consumer_pingou_com/domain/entities/address.dart';
import 'package:consumer_pingou_com/domain/enums/address_state.dart';
import 'package:consumer_pingou_com/infrastructure/providers/onboarding_provider.dart';
import 'package:consumer_pingou_com/presentation/layouts/bottom_sheet_screen_layout.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
        _AddressForm(),
      ],
    );
  }
}

class _AddressForm extends StatelessWidget {
  final postalCodeController = TextEditingController();
  final streetController = TextEditingController();
  final numberController = TextEditingController();
  final complementController = TextEditingController();
  final neighborhoodController = TextEditingController();
  final cityController = TextEditingController();
  final stateController = TextEditingController();

  void _onConfirm(BuildContext context) {
    final address = Address(
      street: streetController.text,
      number: numberController.text,
      complement: complementController.text,
      neighborhood: neighborhoodController.text,
      city: cityController.text,
      state: stateController.text,
      postalCode: postalCodeController.text,
    );

    context.read<OnboardingProvider>().setAddress(address);
  }

  void _fillAddress(Address address) {
    postalCodeController.text = address.postalCode;
    streetController.text = address.street;
    numberController.text = address.number;
    complementController.text = address.complement ?? '';
    neighborhoodController.text = address.neighborhood;
    cityController.text = address.city;
    stateController.text = address.state;
  }

  @override
  Widget build(BuildContext context) {
    final address =
        context.select((OnboardingProvider provider) => provider.address);

    if (address != null) {
      _fillAddress(address);
    }

    return Form(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextFormField(
            controller: postalCodeController,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'CEP',
              hintText: 'Digite seu CEP',
              prefixIcon: Icon(Icons.markunread_mailbox),
            ),
          ),
          const SizedBox(height: 12),
          TextFormField(
            controller: streetController,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Rua',
              hintText: 'Digite o nome da sua rua',
              prefixIcon: Icon(Icons.signpost),
            ),
          ),
          const SizedBox(height: 12),
          TextFormField(
            controller: numberController,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Número',
              hintText: 'Digite o número da sua casa',
              prefixIcon: Icon(Icons.numbers),
            ),
          ),
          const SizedBox(height: 12),
          TextFormField(
            controller: complementController,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Complemento',
              hintText: 'Digite o complemento do seu endereço',
              prefixIcon: Icon(Icons.add),
            ),
          ),
          const SizedBox(height: 12),
          TextFormField(
            controller: neighborhoodController,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Bairro',
              hintText: 'Digite o nome do seu bairro',
              prefixIcon: Icon(Icons.holiday_village),
            ),
          ),
          const SizedBox(height: 12),
          TextFormField(
            controller: cityController,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Cidade',
              hintText: 'Digite o nome da sua cidade',
              prefixIcon: Icon(Icons.location_city),
            ),
          ),
          const SizedBox(height: 12),
          DropdownMenu<AddressState>(
            controller: stateController,
            label: const Text('Estado'),
            expandedInsets: EdgeInsets.zero,
            leadingIcon: const Icon(Icons.travel_explore),
            dropdownMenuEntries: AddressState.values
                .map<DropdownMenuEntry<AddressState>>((AddressState state) {
              return DropdownMenuEntry(
                value: state,
                label: state.name,
              );
            }).toList(),
          ),
          const SizedBox(height: 16),
          ElevatedButton.icon(
            onPressed: () => _onConfirm(context),
            icon: const Icon(Icons.check),
            label: const Text('Confirmar'),
            style: ElevatedButton.styleFrom(
              foregroundColor: Theme.of(context).colorScheme.onPrimary,
              backgroundColor: Theme.of(context).colorScheme.primary,
            ),
          ),
        ],
      ),
    );
  }
}
