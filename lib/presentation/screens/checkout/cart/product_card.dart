part of 'screen.dart';

class _ProductCard extends StatelessWidget {
  final Product product;

  final double quantity;

  const _ProductCard({
    required this.product,
    required this.quantity,
  });

  @override
  Widget build(BuildContext context) {
    return HorizontalProductCard(
      product: product,
      trailing: _QuantitySelector(
        quantity: quantity,
        onChanged: (newQuantity) =>
            context.read<CheckoutProvider>().setQuantity(product, newQuantity),
      ),
    );
  }
}

class _QuantitySelector extends StatelessWidget {
  final double quantity;
  final void Function(double) onChanged;

  const _QuantitySelector({
    required this.quantity,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final leftButtonIcon = quantity == 1 ? Icons.delete : Icons.remove;

    return Row(
      children: [
        IconButton(
          color: Theme.of(context).colorScheme.primary,
          icon: Icon(leftButtonIcon),
          onPressed: () => onChanged(quantity - 1),
        ),
        Text(quantity.toStringAsFixed(0)),
        IconButton(
          color: Theme.of(context).colorScheme.primary,
          icon: const Icon(Icons.add),
          onPressed: () => onChanged(quantity + 1),
        ),
      ],
    );
  }
}
