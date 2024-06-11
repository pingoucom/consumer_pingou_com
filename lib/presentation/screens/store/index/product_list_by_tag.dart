part of 'screen.dart';

class _ProductListByTag extends StatelessWidget {
  final ProductTag tag;
  final List<Product> products;

  const _ProductListByTag({
    required this.tag,
    required this.products,
  });

  static Widget skeleton(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: SkeletonShape(width: 32, height: 20, borderRadius: 10),
        ),
        const SizedBox(height: 4),
        SizedBox(
          height: 244,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                const SizedBox(width: 16),
                VerticalProductCard.skeleton(context),
                const SizedBox(width: 8),
                VerticalProductCard.skeleton(context),
                const SizedBox(width: 8),
                VerticalProductCard.skeleton(context),
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
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            tag.name,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(height: 4),
        SizedBox(
          height: 244,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: products.length,
            itemBuilder: (context, index) {
              final product = products[index];

              EdgeInsets padding;

              if (index == 0) {
                padding = const EdgeInsets.only(left: 16, right: 8);
              } else if (index == products.length - 1) {
                padding = const EdgeInsets.only(right: 16);
              } else {
                padding = const EdgeInsets.only(right: 8);
              }

              return Padding(
                padding: padding,
                child: VerticalProductCard(
                  product: product,
                  onTap: () => GoRouter.of(context)
                      .pushReplacement('/store/${product.id}'),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
