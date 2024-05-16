part of 'screen.dart';

class _BannerWidgetCarousel extends StatelessWidget {
  final _skeletons = [
    _SkeletonBannerWidget(),
    _SkeletonBannerWidget(),
    _SkeletonBannerWidget(),
  ];

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<HomeBannerScreenProvider>().loadAvailableBanners();
    });

    return Consumer<HomeBannerScreenProvider>(
      builder: (context, homeBannerScreenProvider, _) {
        List<Widget> cards = homeBannerScreenProvider.hasLoadedAvailableProducts
            ? homeBannerScreenProvider.avaibleBanners
                .map((banner) => _BannerWidget(banner: banner))
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
