part of 'screen.dart';

class _PlanCardCarousel extends StatelessWidget {
  final _skeletons = [
    _PlanCardSkeleton(),
    _PlanCardSkeleton(),
    _PlanCardSkeleton(),
  ];

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<OnboardingProvider>().loadInitialAvailablePlans();
    });

    return Consumer<OnboardingProvider>(
      builder: (context, onboardingProvider, _) {
        List<Widget> cards = onboardingProvider.hasLoadedAvailablePlans
            ? onboardingProvider.availablePlans
                .map((plan) => _PlanCard(plan: plan))
                .toList()
            : _skeletons;

        List<Widget> children = [];

        for (int i = 0; i < cards.length; i++) {
          children.add(cards[i]);

          if (i < cards.length - 1) {
            children.add(const SizedBox(width: 10));
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
