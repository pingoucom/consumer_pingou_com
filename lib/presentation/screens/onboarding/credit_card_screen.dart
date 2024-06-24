import 'package:consumer_pingou_com/domain/dto/credit_card_input.dart';
import 'package:consumer_pingou_com/infrastructure/providers/credit_card_provider.dart';
import 'package:consumer_pingou_com/presentation/layouts/bottom_sheet_screen_layout.dart';
import 'package:consumer_pingou_com/presentation/partials/credit_card/credit_card_form.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class CreditCardScreen extends StatelessWidget {
  const CreditCardScreen({super.key});

  Future<void> _onCreditCardSubmitted(
    BuildContext context,
    CreditCardInput creditCardInput,
  ) async {
    final creditCardProvider = context.read<CreditCardProvider>();
    await creditCardProvider.add(creditCardInput);

    if (!context.mounted) {
      return;
    }

    GoRouter.of(context).go('/onboarding/address');
  }

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
        CreditCardForm(
            onCreditCardSubmitted: (input) =>
                _onCreditCardSubmitted(context, input)),
      ],
    );
  }
}
