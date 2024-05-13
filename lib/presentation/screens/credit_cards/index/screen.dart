import 'package:consumer_pingou_com/domain/entities/credit_card.dart';
import 'package:consumer_pingou_com/infrastructure/providers/credit_card_provider.dart';
import 'package:consumer_pingou_com/presentation/partials/credit_card/credit_card_card.dart';
import 'package:consumer_pingou_com/presentation/partials/credit_card/credit_card_form.dart';
import 'package:consumer_pingou_com/presentation/partials/product/blurred_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

part 'credit_card_list.dart';

class CreditCardsIndexScreen extends StatelessWidget {
  const CreditCardsIndexScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surfaceVariant,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => GoRouter.of(context).canPop()
              ? GoRouter.of(context).pop()
              : GoRouter.of(context).go('/home'),
        ),
        title: const Text('Cartões de Crédito'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: _CreditCardList(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => showModalBlurredBottomSheet(
          context: context,
          builder: (_) => _CreateCreditCardBottomSheet(),
        ),
        foregroundColor: Theme.of(context).colorScheme.onPrimary,
        backgroundColor: Theme.of(context).colorScheme.primary,
        child: const Icon(Icons.add),
      ),
    );
  }
}

class _CreateCreditCardBottomSheet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CreditCardForm(
      onCreditCardSubmitted: (submittedCreditCard) async {
        final creditCardProvider = context.read<CreditCardProvider>();
        await creditCardProvider.add(submittedCreditCard);

        if (context.mounted) {
          Navigator.of(context).pop();
        }
      },
    );
  }
}
