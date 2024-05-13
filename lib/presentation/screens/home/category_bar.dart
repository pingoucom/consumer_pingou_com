part of 'home_screen.dart';

class _CategoryBar extends StatelessWidget {
  final _skeletons1 = [
    _SkeletonCategory(),
    _SkeletonCategory(),
    _SkeletonCategory(),
  ];

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<HomeScreenProvider>().getCategoryNames();
    });
    return Consumer<HomeScreenProvider>(
      builder: (context, homeScreenProvider, _) {
        List<Widget> categories = homeScreenProvider.hasLoadedAvailableProducts
            ? homeScreenProvider.availableCategories
                .map((category) => _CategoryWidget(category: category))
                .toList()
            : _skeletons1;

        List<Widget> children = [];

        for (int i = 0; i < categories.length; i++) {
          children.add(categories[i]);
          if (i != categories.length - 1) {
            // Adicionando um espaço entre os widgets
            children.add(
                SizedBox(width: 15)); // Ajuste o tamanho conforme necessário
          }
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
