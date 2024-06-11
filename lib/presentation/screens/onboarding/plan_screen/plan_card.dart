part of 'screen.dart';

class _PlanCard extends StatelessWidget {
  final Plan plan;

  const _PlanCard({
    required this.plan,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 18, bottom: 1),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Card.outlined(
            surfaceTintColor: Colors.white,
            margin: EdgeInsets.zero,
            child: Container(
              padding: const EdgeInsets.only(
                top: 36,
                bottom: 28,
                left: 28,
                right: 28,
              ),
              child: SizedBox(
                width: 200,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          plan.title,
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _PlanPriceTag(
                          monthlyPrice: plan.monthlyPrice,
                          semiAnnualPrice: plan.semiAnnualPrice,
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Esse plano inclui:',
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium
                          ?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 4),
                    _PlanFeatureList(features: plan.features),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: _ChoosePlanButton(plan: plan),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          if (plan.flag != null)
            Positioned(
              left: 0,
              right: 0,
              top: -22,
              child: _PlanFlagChip(flag: plan.flag!),
            ),
        ],
      ),
    );
  }
}

class _PlanPriceTag extends StatelessWidget {
  final double monthlyPrice;
  final double semiAnnualPrice;

  const _PlanPriceTag({
    required this.monthlyPrice,
    required this.semiAnnualPrice,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<OnboardingProvider>(
      builder: (context, onboardingProvider, child) {
        double price = onboardingProvider.showingMonthlyPrice
            ? monthlyPrice
            : semiAnnualPrice;

        String formattedPrice = price.toStringAsFixed(2);

        String recurringPeriod = onboardingProvider.showingMonthlyPrice
            ? 'por mês'
            : 'a cada 6 meses';

        String tagText = 'R\$ $formattedPrice $recurringPeriod';

        return Text(
          tagText,
          style: Theme.of(context).textTheme.titleSmall?.copyWith(
                color:
                    Theme.of(context).colorScheme.onSurface.withOpacity(0.75),
              ),
        );
      },
    );
  }
}

class _PlanFeatureList extends StatelessWidget {
  final List<String> features;

  const _PlanFeatureList({required this.features});

  @override
  Widget build(BuildContext context) {
    List<Widget> children = [];

    for (int i = 0; i < features.length; i++) {
      children.add(_PlanFeature(feature: features[i]));

      if (i < features.length - 1) {
        children.add(const SizedBox(height: 4));
      }
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: children,
    );
  }
}

class _PlanFeature extends StatelessWidget {
  final String feature;

  const _PlanFeature({required this.feature});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('\u2022'),
        const SizedBox(width: 8),
        Flexible(
          child: Text(
            feature,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ),
      ],
    );
  }
}

class _ChoosePlanButton extends StatelessWidget {
  final Plan plan;

  const _ChoosePlanButton({required this.plan});

  void _onPressed(OnboardingProvider onboardingProvider, BuildContext context) {
    onboardingProvider.setSelectedPlan(plan);
    GoRouter.of(context).pushReplacement('/onboarding/credit-card');
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<OnboardingProvider>(
      builder: (context, onboardingProvider, child) {
        bool chosen = onboardingProvider.selectedPlan?.id == plan.id;

        if (chosen) {
          return ElevatedButton.icon(
            onPressed: () => _onPressed(onboardingProvider, context),
            icon: const Icon(Icons.check),
            label: const Text('Plano escolhido'),
            style: ElevatedButton.styleFrom(
              foregroundColor: Theme.of(context).colorScheme.onPrimary,
              backgroundColor: Theme.of(context).colorScheme.primary,
            ),
          );
        }

        return OutlinedButton.icon(
          onPressed: () => _onPressed(onboardingProvider, context),
          icon: const Icon(Icons.check),
          label: const Text('Escolher plano'),
        );
      },
    );
  }
}

class _PlanFlagChip extends StatelessWidget {
  final PlanFlag flag;

  const _PlanFlagChip({required this.flag});

  IconData _getIcon() {
    switch (flag) {
      case PlanFlag.cheapest:
        return Icons.monetization_on;
      case PlanFlag.recommended:
        return Icons.star;
      case PlanFlag.premium:
        return Icons.workspace_premium;
    }
  }

  String _getText() {
    switch (flag) {
      case PlanFlag.cheapest:
        return 'Mais barato';
      case PlanFlag.recommended:
        return 'Recomendado';
      case PlanFlag.premium:
        return 'Premium';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Chip(
      color: MaterialStateProperty.all(
        Theme.of(context).colorScheme.secondaryContainer,
      ),
      avatar: Icon(_getIcon()),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(32),
      ),
      label: Text(_getText()),
    );
  }
}
