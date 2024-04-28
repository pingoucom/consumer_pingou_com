import 'package:consumer_pingou_com/domain/dto/postal_code_query_result.dart';
import 'package:consumer_pingou_com/domain/enums/address_state.dart';
import 'package:consumer_pingou_com/domain/repositories/address_repository.dart';
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class AddressForm extends StatefulWidget {
  final AddressRepository _addressRepository;

  const AddressForm({super.key, required addressRepository})
      : _addressRepository = addressRepository;

  @override
  State<AddressForm> createState() => AddressFormState();
}

class AddressFormState extends State<AddressForm> {
  final _postalCodeController = TextEditingController();

  final _streetController = TextEditingController();

  final _numberController = TextEditingController();

  final _complementController = TextEditingController();

  final _neighborhoodController = TextEditingController();

  final _cityController = TextEditingController();

  final _stateController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  bool _isLoadingPostalCodeData = false;

  Widget _getPostalCodeLoadingIndicator(BuildContext context) {
    return SizedBox(
      height: 16,
      width: 16,
      child: CircularProgressIndicator(
        color: Theme.of(context).colorScheme.secondary,
        strokeWidth: 2,
      ),
    );
  }

  Padding _getTextInputPostalCodeLoadingIndicator(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: _getPostalCodeLoadingIndicator(context),
    );
  }

  void _onPostalCodeChanged(String postalCode) async {
    if (postalCode.length != 9) {
      return;
    }

    setState(() => _isLoadingPostalCodeData = true);

    PostalCodeQueryResult? queryResult =
        await widget._addressRepository.queryPostalCode(postalCode);

    setState(() => _isLoadingPostalCodeData = false);

    if (queryResult == null) {
      return;
    }

    _streetController.text = queryResult.street;
    _neighborhoodController.text = queryResult.neighborhood;
    _cityController.text = queryResult.city;
    _stateController.value = _stateController.value.copyWith(
      text: queryResult.state.name,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextFormField(
            controller: _postalCodeController,
            keyboardType: TextInputType.number,
            onChanged: _onPostalCodeChanged,
            enabled: !_isLoadingPostalCodeData,
            decoration: InputDecoration(
              border: const OutlineInputBorder(),
              labelText: 'CEP',
              hintText: 'Digite seu CEP',
              prefixIcon: const Icon(Icons.markunread_mailbox),
              suffixIcon: _isLoadingPostalCodeData
                  ? _getTextInputPostalCodeLoadingIndicator(context)
                  : null,
            ),
            inputFormatters: [
              MaskTextInputFormatter(
                mask: '#####-###',
                filter: {'#': RegExp(r'[0-9]')},
                type: MaskAutoCompletionType.lazy,
              ),
            ],
          ),
          const SizedBox(height: 12),
          TextFormField(
            controller: _streetController,
            enabled: !_isLoadingPostalCodeData,
            decoration: InputDecoration(
              border: const OutlineInputBorder(),
              labelText: 'Rua',
              hintText: 'Digite o nome da sua rua',
              prefixIcon: const Icon(Icons.signpost),
              suffixIcon: _isLoadingPostalCodeData
                  ? _getTextInputPostalCodeLoadingIndicator(context)
                  : null,
            ),
          ),
          const SizedBox(height: 12),
          TextFormField(
            controller: _numberController,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Número',
              hintText: 'Digite o número da sua casa',
              prefixIcon: Icon(Icons.numbers),
            ),
          ),
          const SizedBox(height: 12),
          TextFormField(
            controller: _complementController,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Complemento',
              hintText: 'Digite o complemento do seu endereço',
              prefixIcon: Icon(Icons.add),
            ),
          ),
          const SizedBox(height: 12),
          TextFormField(
            controller: _neighborhoodController,
            enabled: !_isLoadingPostalCodeData,
            decoration: InputDecoration(
              border: const OutlineInputBorder(),
              labelText: 'Bairro',
              hintText: 'Digite o nome do seu bairro',
              prefixIcon: const Icon(Icons.holiday_village),
              suffixIcon: _isLoadingPostalCodeData
                  ? _getTextInputPostalCodeLoadingIndicator(context)
                  : null,
            ),
          ),
          const SizedBox(height: 12),
          TextFormField(
            controller: _cityController,
            enabled: !_isLoadingPostalCodeData,
            decoration: InputDecoration(
              border: const OutlineInputBorder(),
              labelText: 'Cidade',
              hintText: 'Digite o nome da sua cidade',
              prefixIcon: const Icon(Icons.location_city),
              suffixIcon: _isLoadingPostalCodeData
                  ? _getTextInputPostalCodeLoadingIndicator(context)
                  : null,
            ),
          ),
          const SizedBox(height: 12),
          DropdownMenu<AddressState>(
            controller: _stateController,
            enabled: !_isLoadingPostalCodeData,
            label: const Text('Estado'),
            expandedInsets: EdgeInsets.zero,
            leadingIcon: const Icon(Icons.travel_explore),
            trailingIcon: _isLoadingPostalCodeData
                ? _getPostalCodeLoadingIndicator(context)
                : null,
            dropdownMenuEntries: AddressState.values
                .map((AddressState state) => DropdownMenuEntry(
                      value: state,
                      label: state.name,
                    ))
                .toList(),
          ),
          const SizedBox(height: 16),
          ElevatedButton.icon(
            onPressed: () {},
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
