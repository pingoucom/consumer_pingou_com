part of 'screen.dart';

class _TagList extends StatelessWidget {
  static Widget skeleton(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          const SizedBox(width: 16),
          TagChip.skeleton(context, 120),
          const SizedBox(width: 8),
          TagChip.skeleton(context, 90),
          const SizedBox(width: 8),
          TagChip.skeleton(context, 140),
          const SizedBox(width: 8),
          TagChip.skeleton(context, 100),
          const SizedBox(width: 8),
          TagChip.skeleton(context, 60),
          const SizedBox(width: 16),
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

        final tags = storeProvider.productTagsById.values;

        return ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: tags.length,
          itemBuilder: (context, index) {
            final tag = tags.elementAt(index);
            EdgeInsetsGeometry margin;

            if (index == 0) {
              margin = const EdgeInsets.only(left: 16, right: 4);
            } else if (index == tags.length - 1) {
              margin = const EdgeInsets.only(right: 16);
            } else {
              margin = const EdgeInsets.only(right: 4);
            }

            return Container(
              margin: margin,
              child: TagChip(
                tag: tag,
                onSelected: (selected) => selected
                    ? storeProvider.setSelectedProductTag(tag)
                    : storeProvider.clearSelectedProductTag(),
                selectedTagId: storeProvider.selectedProductTagId,
              ),
            );
          },
        );
      },
    );
  }
}
