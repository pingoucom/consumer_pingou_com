part of 'screen.dart';

class _PlanCardCarousel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<OnboardingProvider>(
      builder: (context, onboardingProvider, _) {
        List<Widget> children = [];

        for (int i = 0; i < onboardingProvider.availablePlans.length; i++) {
          children.add(_PlanCard(
            plan: onboardingProvider.availablePlans[i],
          ));

          if (i < onboardingProvider.availablePlans.length - 1) {
            children.add(const SizedBox(width: 10));
          }
        }

        ScrollController scrollController = ScrollController();

        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          controller: scrollController,
          child: Row(
            children: children,
          ),
        );
      },
    );
  }
}
