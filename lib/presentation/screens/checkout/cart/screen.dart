import 'package:consumer_pingou_com/domain/entities/product.dart';
import 'package:consumer_pingou_com/infrastructure/providers/checkout_provider.dart';
import 'package:consumer_pingou_com/presentation/layouts/bannered_bottom_less_screen_layout.dart';
import 'package:consumer_pingou_com/presentation/partials/product/horizontal_product_cart.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

part 'empty_state.dart';
part 'product_card.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BanneredBottomLessScreenLayout(
      icon: Icons.add_shopping_cart,
      message: const [
        TextSpan(text: 'Achou '),
        TextSpan(
          text: 'tudo',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        TextSpan(text: ' o que queria?'),
      ],
      title: const Text('Carrinho'),
      children: [
        _CartContent(),
      ],
    );
  }
}

class _CartContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<CheckoutProvider>(builder: (context, checkoutProvider, _) {
      if (checkoutProvider.isEmpty) {
        return _EmptyState();
      }

      final products = checkoutProvider.cartEntries.keys;
      final quantities = checkoutProvider.cartEntries.values;

      return Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                'Itens adicionados',
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
            const SizedBox(height: 4),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: ListView.builder(
                  itemCount: checkoutProvider.count,
                  itemBuilder: (context, index) => _ProductCard(
                    product: products.elementAt(index),
                    quantity: quantities.elementAt(index),
                  ),
                ),
              ),
            ),
            SizedBox(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _SubtotalDisplay(subtotal: checkoutProvider.subtotal),
                  _ContinueButton(),
                ],
              ),
            ),
          ],
        ),
      );
    });
  }
}

class _SubtotalDisplay extends StatelessWidget {
  final double subtotal;

  const _SubtotalDisplay({required this.subtotal});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Color.alphaBlend(
          Theme.of(context).colorScheme.onSurface.withAlpha(12),
          Theme.of(context).colorScheme.surfaceVariant,
        ),
      ),
      padding: const EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Subtotal',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          Text(
            NumberFormat.simpleCurrency(
              locale: 'pt_BR',
            ).format(subtotal),
            style: Theme.of(context)
                .textTheme
                .bodyLarge
                ?.copyWith(fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}

class _ContinueButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Color.alphaBlend(
          Theme.of(context).colorScheme.onSurface.withAlpha(24),
          Theme.of(context).colorScheme.surfaceVariant,
        ),
        border: Border(
          top: BorderSide(
            color: Theme.of(context).colorScheme.surfaceVariant,
          ),
        ),
      ),
      padding: const EdgeInsets.all(16),
      child: ElevatedButton.icon(
        onPressed: () => GoRouter.of(context).push('/checkout/confirmation'),
        icon: const Icon(Icons.arrow_right_alt),
        label: const Text('Continuar'),
        style: ElevatedButton.styleFrom(
          foregroundColor: Theme.of(context).colorScheme.onPrimary,
          backgroundColor: Theme.of(context).colorScheme.primary,
        ),
      ),
    );
  }
}
