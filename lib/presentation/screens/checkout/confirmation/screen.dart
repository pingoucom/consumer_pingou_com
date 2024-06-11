import 'package:consumer_pingou_com/domain/entities/product.dart';
import 'package:consumer_pingou_com/infrastructure/providers/address_provider.dart';
import 'package:consumer_pingou_com/infrastructure/providers/checkout_provider.dart';
import 'package:consumer_pingou_com/infrastructure/providers/credit_card_provider.dart';
import 'package:consumer_pingou_com/infrastructure/providers/order_provider.dart';
import 'package:consumer_pingou_com/presentation/layouts/bannered_bottom_less_screen_layout.dart';
import 'package:consumer_pingou_com/presentation/partials/address/address_card.dart';
import 'package:consumer_pingou_com/presentation/partials/credit_card/credit_card_card.dart';
import 'package:consumer_pingou_com/presentation/partials/product/horizontal_product_cart.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

part 'address_section.dart';
part 'credit_card_section.dart';
part 'empty_state.dart';

class ConfirmationScreen extends StatelessWidget {
  const ConfirmationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BanneredBottomLessScreenLayout(
      icon: Icons.shopping_cart_checkout,
      message: const [
        TextSpan(text: 'Falta muito '),
        TextSpan(
          text: 'pouco',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        TextSpan(text: '!'),
      ],
      title: const Text('Confirmação'),
      children: [
        _CheckoutData(),
      ],
    );
  }
}

class _CheckoutData extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<CheckoutProvider>(builder: (context, checkoutProvider, _) {
      if (checkoutProvider.isEmpty) {
        return _EmptyState();
      }

      return Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _ProductList(cartEntries: checkoutProvider.cartEntries),
            const SizedBox(height: 16),
            _AddressSection(),
            const SizedBox(height: 16),
            _CreditCardSection(),
            Expanded(
              child: SizedBox(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _SubtotalDisplay(subtotal: checkoutProvider.subtotal),
                    _ConfirmationButton(),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    });
  }
}

class _ProductList extends StatelessWidget {
  final Map<Product, double> cartEntries;

  const _ProductList({required this.cartEntries});

  @override
  Widget build(BuildContext context) {
    final products = cartEntries.keys;
    final quantities = cartEntries.values;

    return Column(
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
        SizedBox(
          height: 100,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            clipBehavior: Clip.none,
            itemCount: cartEntries.length,
            itemBuilder: (context, index) {
              EdgeInsets padding;

              if (index == 0) {
                padding = const EdgeInsets.only(left: 16, right: 8);
              } else if (index == cartEntries.length - 1) {
                padding = const EdgeInsets.only(right: 16, left: 8);
              } else {
                padding = const EdgeInsets.symmetric(horizontal: 0);
              }

              final product = products.elementAt(index);
              final quantity = quantities.elementAt(index);

              return Container(
                width: 300,
                padding: padding,
                child: HorizontalProductCard(
                  product: product,
                  trailing: Flexible(
                    flex: 0,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Text(
                        'x${quantity.toStringAsFixed(0)}',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
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

class _ConfirmationButton extends StatefulWidget {
  @override
  State<_ConfirmationButton> createState() => _ConfirmationButtonState();
}

class _ConfirmationButtonState extends State<_ConfirmationButton> {
  bool _isConfirming = false;

  void _confirm(BuildContext context) async {
    setState(() {
      _isConfirming = true;
    });

    final orderProvider = context.read<OrderProvider>();
    await orderProvider.add(
      context.read<CheckoutProvider>().cartEntries,
      context.read<AddressProvider>().selectedAddress,
      context.read<CreditCardProvider>().selectedCreditCard,
    );

    if (!context.mounted) {
      return;
    }

    final checkoutProvider = context.read<CheckoutProvider>();
    checkoutProvider.clear();

    GoRouter.of(context).replace('/store');
  }

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
        onPressed: _isConfirming ? null : () => _confirm(context),
        icon: _isConfirming
            ? const SizedBox(
                width: 16,
                height: 16,
                child: CircularProgressIndicator(strokeWidth: 2),
              )
            : const Icon(Icons.check),
        label: const Text('Confirmar'),
        style: ElevatedButton.styleFrom(
          foregroundColor: Theme.of(context).colorScheme.onPrimary,
          backgroundColor: Theme.of(context).colorScheme.primary,
        ),
      ),
    );
  }
}
