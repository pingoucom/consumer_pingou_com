import 'package:consumer_pingou_com/domain/dto/address_input.dart';
import 'package:consumer_pingou_com/domain/dto/postal_code_query_result.dart';
import 'package:consumer_pingou_com/domain/entities/address.dart';
import 'package:consumer_pingou_com/domain/enums/address_state.dart';
import 'package:consumer_pingou_com/infrastructure/providers/address_provider.dart';
import 'package:consumer_pingou_com/infrastructure/providers/authentication_provider.dart';
import 'package:consumer_pingou_com/presentation/validators/validator.dart';
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:provider/provider.dart';

class AddressForm extends StatefulWidget {
  final Address? address;

  final Future<void> Function(AddressInput)? onAddressSubmitted;

  const AddressForm({super.key, this.address, this.onAddressSubmitted});

  @override
  State<AddressForm> createState() => AddressFormState();
}

class AddressFormState extends State<AddressForm> {
  final _postalCodeFieldController = TextEditingController();

  final _streetFieldController = TextEditingController();

  final _numberFieldController = TextEditingController();

  final _complementFieldController = TextEditingController();

  final _neighborhoodFieldController = TextEditingController();

  final _cityFieldController = TextEditingController();

  final _stateFieldController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  bool _isLoadingPostalCodeData = false;

  bool _isSubmitting = false;

  late AddressProvider _addressProvider;

  @override
  void initState() {
    super.initState();

    _addressProvider = context.read<AddressProvider>();

    if (widget.address != null) {
      _postalCodeFieldController.text = widget.address!.postalCode;
      _streetFieldController.text = widget.address!.street;
      _numberFieldController.text = widget.address!.number;
      _neighborhoodFieldController.text = widget.address!.neighborhood;
      _cityFieldController.text = widget.address!.city;
      _stateFieldController.text = widget.address!.state.name;

      if (widget.address!.complement != null) {
        _complementFieldController.text = widget.address!.complement!;
      }
    }
  }

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
        await _addressProvider.queryPostalCode(postalCode);

    setState(() => _isLoadingPostalCodeData = false);

    if (queryResult == null) {
      return;
    }

    _streetFieldController.text = queryResult.street;
    _neighborhoodFieldController.text = queryResult.neighborhood;
    _cityFieldController.text = queryResult.city;
    _stateFieldController.text = queryResult.state.name;
  }

  bool get isPostalCodeFieldEnabled =>
      !_isLoadingPostalCodeData && !_isSubmitting;

  bool get isStreetFieldEnabled => !_isLoadingPostalCodeData && !_isSubmitting;

  bool get isNumberFieldEnabled => !_isSubmitting;

  bool get isComplementFieldEnabled => !_isSubmitting;

  bool get isNeighborhoodFieldEnabled =>
      !_isLoadingPostalCodeData && !_isSubmitting;

  bool get isCityFieldEnabled => !_isLoadingPostalCodeData && !_isSubmitting;

  bool get isStateFieldEnabled => !_isLoadingPostalCodeData && !_isSubmitting;

  bool get isSubmitButtonEnabled => !_isSubmitting;

  void handleConfirmButtonPressed() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    if (widget.onAddressSubmitted == null) {
      return;
    }

    setState(() {
      _isSubmitting = true;
    });

    final authenticationProvider = context.read<AuthenticationProvider>();

    await widget.onAddressSubmitted!(AddressInput(
      userId: authenticationProvider.user != null
          ? authenticationProvider.user!.id
          : '1',
      postalCode: _postalCodeFieldController.text,
      street: _streetFieldController.text,
      number: _numberFieldController.text,
      complement: _complementFieldController.text.isNotEmpty
          ? _complementFieldController.text
          : null,
      neighborhood: _neighborhoodFieldController.text,
      city: _cityFieldController.text,
      state: AddressState.values.firstWhere(
        (AddressState state) => state.name == _stateFieldController.text,
      ),
    ));

    setState(() {
      _isSubmitting = false;
    });
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
            controller: _postalCodeFieldController,
            enabled: isPostalCodeFieldEnabled,
            keyboardType: TextInputType.number,
            onChanged: _onPostalCodeChanged,
            validator: Validator.all([
              Validator.required(),
              Validator.length(9),
            ]),
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
            controller: _streetFieldController,
            validator: Validator.required(),
            enabled: isStreetFieldEnabled,
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
            controller: _numberFieldController,
            validator: Validator.required(),
            enabled: isNumberFieldEnabled,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Número',
              hintText: 'Digite o número da sua casa',
              prefixIcon: Icon(Icons.numbers),
            ),
          ),
          const SizedBox(height: 12),
          TextFormField(
            controller: _complementFieldController,
            enabled: isComplementFieldEnabled,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Complemento',
              hintText: 'Digite o complemento do seu endereço',
              prefixIcon: Icon(Icons.add),
            ),
          ),
          const SizedBox(height: 12),
          TextFormField(
            controller: _neighborhoodFieldController,
            validator: Validator.required(),
            enabled: isNeighborhoodFieldEnabled,
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
            controller: _cityFieldController,
            validator: Validator.required(),
            enabled: isCityFieldEnabled,
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
          DropdownButtonFormField<AddressState>(
            decoration: const InputDecoration(
              prefixIcon: Icon(Icons.travel_explore),
              border: OutlineInputBorder(),
              labelText: 'Estado',
              hintText: 'Selecione o estado',
            ),
            onChanged: isStateFieldEnabled
                ? (AddressState? state) {
                    if (state != null) {
                      _stateFieldController.text = state.name;
                    }
                  }
                : null,
            value: _stateFieldController.text.isNotEmpty
                ? AddressState.values.firstWhere(
                    (AddressState state) =>
                        state.name == _stateFieldController.text,
                  )
                : null,
            validator: (value) => Validator.required()(value?.name),
            icon: _isLoadingPostalCodeData
                ? _getPostalCodeLoadingIndicator(context)
                : null,
            items: AddressState.values
                .map((AddressState state) => DropdownMenuItem(
                      value: state,
                      child: Text(state.name),
                    ))
                .toList(),
          ),
          // DropdownMenu<AddressState>(
          //   controller: _stateFieldController,
          //   enabled: isStateFieldEnabled,
          //   label: const Text('Estado'),
          //   expandedInsets: EdgeInsets.zero,
          //   leadingIcon: const Icon(Icons.travel_explore),
          //   trailingIcon: _isLoadingPostalCodeData
          //       ? _getPostalCodeLoadingIndicator(context)
          //       : null,
          //   dropdownMenuEntries: AddressState.values
          //       .map((AddressState state) => DropdownMenuEntry(
          //             value: state,
          //             label: state.name,
          //           ))
          //       .toList(),
          // ),
          const SizedBox(height: 16),
          ElevatedButton.icon(
            onPressed:
                isSubmitButtonEnabled ? handleConfirmButtonPressed : null,
            icon: _isSubmitting
                ? const SizedBox(
                    height: 16,
                    width: 16,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : const Icon(Icons.check),
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
