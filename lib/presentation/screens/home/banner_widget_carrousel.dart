part of 'screen.dart';

class _BannerWidgetCarousel extends StatelessWidget {
  final _skeletons = [Column(
    children: [
      SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            _SkeletonBannerWidget(),
            _SkeletonBannerWidget(),
          ],
        ),
      ),
       SingleChildScrollView(
        scrollDirection: Axis.horizontal,
         child: Row(
          children: [
            _SkeletonBannerWidget(),
            _SkeletonBannerWidget(),
          ],
               ),
       ),
    ],
  ),]; 

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<HomeBannerScreenProvider>().loadAvailableBanners();
    });

    return Consumer<HomeBannerScreenProvider>(
      builder: (context, homeBannerScreenProvider, _) {
        if (homeBannerScreenProvider.isLoadingAvailableBanners) {
          return Column(
            children: _skeletons,
          ); // Show skeletons while loading
        } else {
          var groupedBanners = homeBannerScreenProvider.groupedBanners;

          if (groupedBanners.isEmpty) {
            return SizedBox.shrink(); // Handle empty state, you can replace this with a custom widget 
          }
          return Column( 
            children: groupedBanners.entries.map((entry) {
              final category = entry.key;
              final banners = entry.value;

              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column( 
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0, bottom: 12.0, top: 8.0),
                      child: Text(category, style: const TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 22,
                                                    fontFamily: 'Roboto',
                                                    fontWeight: FontWeight.w400,
                                                    height: 0.06,
                                                    ),),
                    ),
                    SingleChildScrollView( 
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: banners.map((banner) => _BannerWidget(banner: banner)).toList(),
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          );
        }
      },
    );
  }
}
