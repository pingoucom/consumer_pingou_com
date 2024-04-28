import 'package:consumer_pingou_com/domain/entities/credit_card.dart';
import 'package:consumer_pingou_com/infrastructure/providers/onboarding_provider.dart';
import 'package:consumer_pingou_com/presentation/layouts/bottom_sheet_screen_layout.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class CreditCardScreen extends StatelessWidget {
  const CreditCardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomSheetScreenLayout(
      icon: Icon(
        Icons.credit_card,
        size: 32,
        color: Theme.of(context).colorScheme.onPrimaryContainer,
      ),
      message: const [
        TextSpan(text: 'Agora, precisamos de um '),
        TextSpan(
          text: 'cartão de crédito',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        TextSpan(text: '!'),
      ],
      children: [
        _CreditCardForm(),
      ],
    );
  }
}

class _CreditCardForm extends StatelessWidget {
  final holderNameController = TextEditingController();
  final holderDocumentController = TextEditingController();
  final numberController = TextEditingController();
  final expirationDateController = TextEditingController();
  final cvvController = TextEditingController();

  void _onConfirm(BuildContext context) {
    final creditCard = CreditCard(
      holderName: holderNameController.text,
      holderDocument: holderDocumentController.text,
      number: numberController.text,
      expirationDate: expirationDateController.text,
      cvv: cvvController.text,
    );

    context.read<OnboardingProvider>().setCreditCard(creditCard);
    GoRouter.of(context).push('/onboarding/address');
  }

  void _fillCreditCard(CreditCard creditCard) {
    holderNameController.text = creditCard.holderName;
    holderDocumentController.text = creditCard.holderDocument;
    numberController.text = creditCard.number;
    expirationDateController.text = creditCard.expirationDate;
    cvvController.text = creditCard.cvv;
  }

  @override
  Widget build(BuildContext context) {
    final creditCard =
        context.select((OnboardingProvider provider) => provider.creditCard);

    if (creditCard != null) {
      _fillCreditCard(creditCard);
    }

    return Form(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextFormField(
            controller: holderNameController,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Nome do titular',
              hintText: 'Digite o nome do titular do cartão',
              prefixIcon: Icon(Icons.person),
            ),
          ),
          const SizedBox(height: 12),
          TextFormField(
            controller: holderDocumentController,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'CPF do titular',
              hintText: 'Digite o CPF do titular do cartão',
              prefixIcon: Icon(Icons.badge),
            ),
          ),
          const SizedBox(height: 12),
          TextFormField(
            controller: numberController,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Número do cartão',
              hintText: 'Digite o número do cartão',
              prefixIcon: Icon(Icons.numbers),
            ),
          ),
          const SizedBox(height: 12),
          TextFormField(
            controller: expirationDateController,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Vencimento',
              hintText: 'Digite o vencimento do cartão',
              prefixIcon: Icon(Icons.event),
            ),
          ),
          const SizedBox(height: 12),
          TextFormField(
            controller: cvvController,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Código de verificação',
              hintText: 'Digite o código de verificação do cartão',
              prefixIcon: Icon(Icons.lock),
            ),
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
