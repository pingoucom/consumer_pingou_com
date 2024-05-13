part of 'home_screen.dart';

class _ProductWidgetCarousel extends StatelessWidget {
  final _skeletons = [
    _SkeletonProductWidget(),
    _SkeletonProductWidget(),
    _SkeletonProductWidget(),
  ];

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<HomeScreenProvider>().loadAvailableProducts();
    });

    return Consumer<HomeScreenProvider>(
      builder: (context, homeScreenProvider, _) {
        List<Widget> cards = homeScreenProvider.hasLoadedAvailableProducts
            ? homeScreenProvider.availableProducts
                .map((product) => _ProductWidget(product: product))
                .toList()
            : _skeletons;

        List<Widget> children = [];

        for (int i = 0; i < cards.length; i++) {
          children.add(cards[i]);
        }

        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: children,
          ),
        );
      },
    );
  }
}
