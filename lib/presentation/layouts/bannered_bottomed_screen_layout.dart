import 'package:consumer_pingou_com/infrastructure/providers/checkout_provider.dart';
import 'package:consumer_pingou_com/presentation/components/decorated_banner.dart';
import 'package:consumer_pingou_com/presentation/components/my_bottom_bar.dart';
import 'package:consumer_pingou_com/presentation/layouts/nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class BanneredBottomedScreenLayout extends StatelessWidget {
  final Widget? stickyHeader;

  final List<Widget> children;

  final IconData icon;

  final List<TextSpan> message;

  const BanneredBottomedScreenLayout({
    super.key,
    this.stickyHeader,
    required this.children,
    required this.icon,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surfaceVariant,
      appBar: AppBar(
        leading: SizedBox(
          height: 50, // Altura desejada
          width: 50, // Largura desejada
          child: Image.asset(
            'assets/img/logo.png',
            fit: BoxFit.contain,
          ),
        ),
        title: const Text('Pingou!'),
      ),
      floatingActionButton: _DynamicCartFloatingActionButton(),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Stack(
              children: [
                DecoratedBanner(
                  icon: icon,
                  message: message,
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: SizedBox(
                    height: 24,
                    width: 24,
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.surfaceVariant,
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(24),
                          topRight: Radius.circular(24),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          if (stickyHeader != null)
            SliverAppBar(
              backgroundColor: Theme.of(context).colorScheme.surfaceVariant,
              flexibleSpace: stickyHeader!,
              pinned: true,
            ),
          SliverList(
            delegate: SliverChildListDelegate(children),
          ),
        ],
      ),
    );
  }
}

class _DynamicCartFloatingActionButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<CheckoutProvider>(
      builder: (context, checkoutProvider, _) {
        return checkoutProvider.isEmpty
            ? const SizedBox.shrink()
            : IconButton(
                onPressed: () => GoRouter.of(context).push('/checkout/cart'),
                icon: Badge(
                  offset: const Offset(12, -12),
                  label: Text(checkoutProvider.aggregatedQuantity.toString()),
                  child: const Icon(Icons.shopping_cart),
                ),
                style: ElevatedButton.styleFrom(
                  foregroundColor: Theme.of(context).colorScheme.onPrimary,
                  backgroundColor: Theme.of(context).colorScheme.primary,
                ),
              );
      },
    );
  }
}
