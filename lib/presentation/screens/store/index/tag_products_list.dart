part of 'screen.dart';

class _TagProductsList extends StatelessWidget {
  static Widget skeleton(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 8),
          _ProductListByTag.skeleton(context),
          const SizedBox(height: 8),
          _ProductListByTag.skeleton(context),
          const SizedBox(height: 8),
          _ProductListByTag.skeleton(context),
          const SizedBox(height: 8),
          _ProductListByTag.skeleton(context),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<StoreProvider>(
      builder: (context, storeProvider, _) {
        if (!storeProvider.hasLoadedInitialData) {
          return skeleton(context);
        }

        return FutureBuilder<List<Product>>(
          future: storeProvider.findAllProducts(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return skeleton(context); // Show skeleton loader while waiting
            }

            if (snapshot.hasError) {
              return Center(
                  child:
                      Text('Error: ${snapshot.error}')); // Handle error state
            }

            List<Product> products = snapshot.data ?? []; // Handle null case
            return _SingleTagProductList(
              products: products,
            );
          },
        );
      },
    );
  }
}
