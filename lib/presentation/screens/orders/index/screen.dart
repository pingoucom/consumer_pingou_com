import 'package:consumer_pingou_com/infrastructure/providers/order_provider.dart';
import 'package:consumer_pingou_com/presentation/partials/order/order_card.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

part 'order_list.dart';

class OrdersIndexScreen extends StatefulWidget {
  const OrdersIndexScreen({super.key});

  @override
  State<OrdersIndexScreen> createState() => _OrdersIndexScreenState();
}

class _OrdersIndexScreenState extends State<OrdersIndexScreen> {
  @override
  void initState() {
    super.initState();

    final orderProvider = context.read<OrderProvider>();
    orderProvider.loadInitialOrders();
  }

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
        title: const Text('Pedidos'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: _OrderList(),
      ),
    );
  }
}
