part of 'screen.dart';

class _ProductDisplay extends StatefulWidget {
  final ProductDetails productDetails;

  const _ProductDisplay({required this.productDetails});

  static Widget skeleton(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surfaceVariant,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => GoRouter.of(context).canPop()
              ? GoRouter.of(context).pop()
              : GoRouter.of(context).push('/store'),
        ),
        title: const SkeletonShape(
          width: 103,
          height: 28,
          borderRadius: 14,
        ),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SkeletonShape(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.width,
              borderRadius: 0,
            ),
            const SizedBox(
              height: 16,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: SkeletonShape(
                width: 90,
                height: 28,
                borderRadius: 14,
              ),
            ),
            const SizedBox(
              height: 12,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: SkeletonShape(
                width: MediaQuery.of(context).size.width - 32,
                height: 16,
                borderRadius: 8,
              ),
            ),
            const SizedBox(
              height: 4,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: SkeletonShape(
                width: 240,
                height: 16,
                borderRadius: 8,
              ),
            ),
            const SizedBox(
              height: 12,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: SkeletonShape(
                width: 60,
                height: 16,
                borderRadius: 8,
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: SkeletonShape(
                width: 90,
                height: 16,
                borderRadius: 8,
              ),
            ),
            const SizedBox(
              height: 4,
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  const SizedBox(
                    width: 16,
                  ),
                  VerticalProductCard.skeleton(context),
                  const SizedBox(
                    width: 8,
                  ),
                  VerticalProductCard.skeleton(context),
                  const SizedBox(
                    width: 8,
                  ),
                  VerticalProductCard.skeleton(context),
                  const SizedBox(
                    width: 8,
                  ),
                  VerticalProductCard.skeleton(context),
                  const SizedBox(
                    width: 16,
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 16,
            ),
          ],
        ),
      ),
      bottomNavigationBar: const BottomAppBar(
        child: Row(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 12),
              child: SkeletonShape(
                width: 24,
                height: 24,
                borderRadius: 12,
              ),
            ),
            SkeletonShape(
              width: 40,
              height: 28,
              borderRadius: 14,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 12),
              child: SkeletonShape(
                width: 24,
                height: 24,
                borderRadius: 12,
              ),
            ),
            Expanded(
              child: SkeletonShape(
                width: 200,
                height: 48,
                borderRadius: 24,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  _ProductDetailsState createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<_ProductDisplay> {
  double _quantity = 1;

  @override
  void initState() {
    super.initState();

    _quantity = 1;
  }

  void _increment() {
    setState(() {
      _quantity++;
    });
  }

  void _decrement() {
    setState(() {
      if (_quantity > 1) {
        _quantity--;
      }
    });
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
              : GoRouter.of(context).push('/store'),
        ),
        title: Text(widget.productDetails.product.name),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BlurFillingImage(
              image: AssetImage(widget.productDetails.product.image),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.width,
            ),
            const SizedBox(
              height: 16,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                widget.productDetails.product.name,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ),
            const SizedBox(
              height: 12,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                widget.productDetails.product.description,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(
              height: 12,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                NumberFormat.simpleCurrency(
                  locale: 'pt_BR',
                ).format(widget.productDetails.product.price),
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).primaryColor,
                  fontSize: 16,
                ),
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                'Relacionados',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
            const SizedBox(
              height: 4,
            ),
            SizedBox(
              height: 244,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: widget.productDetails.related.length,
                itemBuilder: (context, index) {
                  final product = widget.productDetails.related[index];

                  EdgeInsets padding;

                  if (index == 0) {
                    padding = const EdgeInsets.only(left: 16, right: 8);
                  } else if (index ==
                      widget.productDetails.related.length - 1) {
                    padding = const EdgeInsets.only(right: 16);
                  } else {
                    padding = const EdgeInsets.only(right: 8);
                  }

                  return Padding(
                    padding: padding,
                    child: VerticalProductCard(
                      product: product,
                      onTap: () =>
                          GoRouter.of(context).push('/store/${product.id}'),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(
              height: 16,
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          children: [
            IconButton(
              onPressed: _quantity > 1 ? _decrement : null,
              icon: const Icon(Icons.remove),
            ),
            SizedBox(
              width: 40,
              child: Text(
                _quantity.toStringAsFixed(0),
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
            IconButton(
              onPressed: _increment,
              icon: const Icon(Icons.add),
            ),
            Expanded(
              child: ElevatedButton(
                onPressed: () {
                  final checkoutProvider = context.read<CheckoutProvider>();
                  checkoutProvider.add(
                    widget.productDetails.product,
                    quantity: _quantity,
                  );

                  GoRouter.of(context).canPop()
                      ? GoRouter.of(context).pop()
                      : GoRouter.of(context).push('/store');
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: Theme.of(context).colorScheme.onPrimary,
                  backgroundColor: Theme.of(context).colorScheme.primary,
                ),
                child: const Text('Adicionar'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
