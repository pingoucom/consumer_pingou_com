import 'package:consumer_pingou_com/domain/dto/credit_card_input.dart';
import 'package:consumer_pingou_com/presentation/validators/credit_card.dart';
import 'package:consumer_pingou_com/presentation/validators/validator.dart';
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class CreditCardForm extends StatefulWidget {
  final Future<void> Function(CreditCardInput)? onCreditCardSubmitted;

  const CreditCardForm({super.key, this.onCreditCardSubmitted});

  @override
  State<CreditCardForm> createState() => CreditCardFormState();
}

class CreditCardFormState extends State<CreditCardForm> {
  final _holderNameFieldController = TextEditingController();

  final _holderDocumentFieldController = TextEditingController();

  final _numberFieldController = TextEditingController();

  final _expirationDateFieldController = TextEditingController();

  final _cvvFieldController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  bool _isSubmitting = false;

  void handleConfirmButtonPressed() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    if (widget.onCreditCardSubmitted == null) {
      return;
    }

    setState(() {
      _isSubmitting = true;
    });

    await widget.onCreditCardSubmitted!(CreditCardInput(
      holderName: _holderNameFieldController.text,
      holderDocument: _holderDocumentFieldController.text,
      number: _numberFieldController.text,
      expirationDate: _expirationDateFieldController.text,
      cvv: _cvvFieldController.text,
    ));

    setState(() {
      _isSubmitting = false;
    });
  }

  bool get isSubmitButtonEnabled => !_isSubmitting;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextFormField(
            controller: _holderNameFieldController,
            validator: Validator.required(),
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Nome do titular',
              hintText: 'Digite o nome do titular do cartão',
              prefixIcon: Icon(Icons.person),
            ),
          ),
          const SizedBox(height: 12),
          TextFormField(
            controller: _holderDocumentFieldController,
            validator: Validator.required(),
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'CPF do titular',
              hintText: 'Digite o CPF do titular do cartão',
              prefixIcon: Icon(Icons.badge),
            ),
            inputFormatters: [
              MaskTextInputFormatter(
                mask: '###.###.###-##',
                filter: {'#': RegExp(r'[0-9]')},
                type: MaskAutoCompletionType.lazy,
              ),
            ],
          ),
          const SizedBox(height: 12),
          TextFormField(
            controller: _numberFieldController,
            validator: Validator.all([
              Validator.required(),
              Validator.length(19),
            ]),
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Número do cartão',
              hintText: 'Digite o número do cartão',
              prefixIcon: Icon(Icons.numbers),
            ),
            inputFormatters: [
              MaskTextInputFormatter(
                mask: '#### #### #### ####',
                filter: {'#': RegExp(r'[0-9]')},
                type: MaskAutoCompletionType.lazy,
              ),
            ],
          ),
          const SizedBox(height: 12),
          TextFormField(
            controller: _expirationDateFieldController,
            validator: Validator.all([
              Validator.required(),
              CreditCardValidator.expirationDate(),
            ]),
            keyboardType: TextInputType.datetime,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Vencimento',
              hintText: 'Digite o vencimento do cartão',
              prefixIcon: Icon(Icons.event),
            ),
            inputFormatters: [
              MaskTextInputFormatter(
                mask: '##/##',
                filter: {'#': RegExp(r'[0-9]')},
                type: MaskAutoCompletionType.lazy,
              ),
            ],
          ),
          const SizedBox(height: 12),
          TextFormField(
            controller: _cvvFieldController,
            validator: Validator.required(),
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Código de verificação',
              hintText: 'Digite o código de verificação do cartão',
              prefixIcon: Icon(Icons.lock),
            ),
            inputFormatters: [
              MaskTextInputFormatter(
                mask: '###',
                filter: {'#': RegExp(r'[0-9]')},
                type: MaskAutoCompletionType.lazy,
              ),
            ],
          ),
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
