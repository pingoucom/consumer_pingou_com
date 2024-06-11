import 'package:consumer_pingou_com/domain/entities/address.dart';
import 'package:consumer_pingou_com/domain/entities/credit_card.dart';
import 'package:consumer_pingou_com/domain/entities/order.dart';
import 'package:consumer_pingou_com/domain/entities/product.dart';
import 'package:consumer_pingou_com/infrastructure/providers/order_provider.dart';
import 'package:consumer_pingou_com/presentation/components/order_status_icon_factory.dart';
import 'package:consumer_pingou_com/presentation/components/order_status_message_factory.dart';
import 'package:consumer_pingou_com/presentation/components/skeleton_shape.dart';
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

class OrderShowScreen extends StatelessWidget {
  final String orderId;

  const OrderShowScreen({
    super.key,
    required this.orderId,
  });

  @override
  Widget build(BuildContext context) {
    final orderProvider = context.read<OrderProvider>();

    return FutureBuilder(
      future: orderProvider.find(orderId),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return _OrderData.skeleton(context);
        }

        if (snapshot.hasError) {
          GoRouter.of(context).canPop()
              ? GoRouter.of(context).pop()
              : GoRouter.of(context).pushReplacement('/home');

          return _OrderData.skeleton(context);
        }

        final order = snapshot.data;

        if (order == null) {
          GoRouter.of(context).canPop()
              ? GoRouter.of(context).pop()
              : GoRouter.of(context).pushReplacement('/home');

          return _OrderData.skeleton(context);
        }

        return _OrderData(order: order);
      },
    );
  }
}

class _OrderData extends StatelessWidget {
  final Order order;

  const _OrderData({
    required this.order,
  });

  static Widget skeleton(BuildContext context) {
    return BanneredBottomLessScreenLayout.skeleton(
      context,
      [
        _ProductList.skeleton(context),
        const SizedBox(height: 16),
        _AddressSection.skeleton(context),
        const SizedBox(height: 16),
        _CreditCardSection.skeleton(context),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return BanneredBottomLessScreenLayout(
      icon: OrderStatusIconFactory.make(order.status),
      message: OrderStatusMessageFactory.make(order.status),
      title: Text('Pedido #${order.id}'),
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _ProductList(items: order.items),
              const SizedBox(height: 16),
              _AddressSection(address: order.address),
              const SizedBox(height: 16),
              _CreditCardSection(creditCard: order.creditCard),
              Expanded(
                child: SizedBox(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      _AmountsDisplay(order: order),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _ProductList extends StatelessWidget {
  final Map<Product, double> items;

  const _ProductList({required this.items});

  static Widget skeleton(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: SkeletonShape(
            width: 129,
            height: 24,
            borderRadius: 12,
          ),
        ),
        const SizedBox(height: 4),
        SizedBox(
          height: 100,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            clipBehavior: Clip.none,
            child: Row(
              children: [
                const SizedBox(width: 16),
                SizedBox(
                  width: 276,
                  child: HorizontalProductCard.skeleton(
                    context,
                    const Flexible(
                      flex: 0,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SkeletonShape(
                            height: 24,
                            width: 24,
                            borderRadius: 12,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                SizedBox(
                  width: 276,
                  child: HorizontalProductCard.skeleton(
                    context,
                    const Flexible(
                      flex: 0,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SkeletonShape(
                            height: 24,
                            width: 24,
                            borderRadius: 12,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                SizedBox(
                  width: 276,
                  child: HorizontalProductCard.skeleton(
                    context,
                    const Flexible(
                      flex: 0,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SkeletonShape(
                            height: 24,
                            width: 24,
                            borderRadius: 12,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
              ],
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final products = items.keys;
    final quantities = items.values;

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
            itemCount: items.length,
            itemBuilder: (context, index) {
              EdgeInsets padding;

              if (index == 0) {
                padding = const EdgeInsets.only(left: 16, right: 8);
              } else if (index == items.length - 1) {
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

class _AmountsDisplay extends StatelessWidget {
  final Order order;

  const _AmountsDisplay({required this.order});

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
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Taxa de antrega',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              Text(
                NumberFormat.simpleCurrency(
                  locale: 'pt_BR',
                ).format(order.deliveryFee),
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Taxa de serviço',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              Text(
                NumberFormat.simpleCurrency(
                  locale: 'pt_BR',
                ).format(order.serviceFee),
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Total',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              Text(
                NumberFormat.simpleCurrency(
                  locale: 'pt_BR',
                ).format(order.total),
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge
                    ?.copyWith(fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
