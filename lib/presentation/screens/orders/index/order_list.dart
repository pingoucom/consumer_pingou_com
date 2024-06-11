part of 'screen.dart';

class _OrderList extends StatelessWidget {
  Widget skeleton(BuildContext context) {
    return Column(
      children: List.generate(
        5,
        (index) => OrderCard.skeleton(),
      ),
    );
  }

  Widget emptyState(BuildContext context) {
    return Expanded(
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.close,
              size: 32,
              color: Theme.of(context).colorScheme.onSurface.withOpacity(0.8),
            ),
            Text(
              'Você ainda não fez nenhum pedido.',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<OrderProvider>(
      builder: (context, orderProvider, _) {
        if (!orderProvider.hasLoadedInitialOrders) {
          return skeleton(context);
        }

        if (orderProvider.userOrders.isEmpty) {
          return emptyState(context);
        }

        return ListView.builder(
          scrollDirection: Axis.vertical,
          itemCount: orderProvider.userOrders.length,
          itemBuilder: (context, index) => OrderCard(
            order: orderProvider.userOrders.elementAt(index),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => GoRouter.of(context).pushReplacement(
                '/orders/${orderProvider.userOrders.elementAt(index).id}'),
          ),
        );
      },
    );
  }
}
