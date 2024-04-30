part of 'home_screen.dart';

class _CachacaWidgetCarousel extends StatelessWidget {
  final _skeletons = [
    _SkeletonCachacaWidget(),
    _SkeletonCachacaWidget(),
    _SkeletonCachacaWidget(),
  ];

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<HomeScreenProvider>().loadAvailableCachacas();
    });

    return Consumer<HomeScreenProvider>(
      builder: (context, homeScreenProvider, _) {
        List<Widget> cards = homeScreenProvider.hasLoadedAvailableCachacas
            ? homeScreenProvider.availableCachacas
                .map((cachaca) => _CachacaWidget(cachaca: cachaca))
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
