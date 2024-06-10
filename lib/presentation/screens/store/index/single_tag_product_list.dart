part of 'screen.dart';

class _SingleTagProductList extends StatelessWidget {
  final List<Product> products;

  const _SingleTagProductList({
    required this.products,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
        bottom: 16,
        left: 16,
        right: 16,
      ),
      child: Wrap(
        direction: Axis.horizontal,
        alignment: WrapAlignment.spaceBetween,
        runSpacing: 8,
        children: List.generate(
          products.length,
          (index) => SizedBox(
            height: 244,
            child: VerticalProductCard(product: products[index]),
          ),
        ),
      ),
    );
  }
}
