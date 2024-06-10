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

        return ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: storeProvider.featuredProductsByTagId.length,
          itemBuilder: (context, index) {
            final tagId =
                storeProvider.featuredProductsByTagId.keys.elementAt(index);
            final tag = storeProvider.productTagsById[tagId];

            final products = storeProvider.featuredProductsByTagId[tagId];

            EdgeInsets margin = index == 0
                ? const EdgeInsets.only(top: 8, bottom: 16)
                : const EdgeInsets.only(bottom: 16);

            return Container(
              margin: margin,
              child: _ProductListByTag(tag: tag!, products: products!),
            );
          },
        );
      },
    );
  }
}
