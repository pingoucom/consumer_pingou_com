import 'package:consumer_pingou_com/domain/entities/plan.dart';
import 'package:consumer_pingou_com/domain/enums/plan_flag.dart';
import 'package:consumer_pingou_com/infrastructure/providers/onboarding_provider.dart';
import 'package:consumer_pingou_com/presentation/components/labeled_divider.dart';
import 'package:consumer_pingou_com/presentation/layouts/bottom_sheet_screen_layout.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

part 'plan_card.dart';
part 'plan_card_carousel.dart';
part 'plan_choosing_section.dart';

class PlanScreen extends StatelessWidget {
  const PlanScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomSheetScreenLayout(
      icon: Icon(
        Icons.repeat,
        size: 32,
        color: Theme.of(context).colorScheme.onPrimaryContainer,
      ),
      message: const [
        TextSpan(text: 'Vamos começar escolhendo um '),
        TextSpan(
          text: 'plano',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        TextSpan(text: '!'),
      ],
      children: [
        _PlanChoosingSection(),
        Container(
          margin: const EdgeInsets.symmetric(vertical: 16),
          child: const LabeledDivider(label: 'Sem interesse nos planos?'),
        ),
        _SkipButton(),
      ],
    );
  }
}

class _SkipButton extends StatelessWidget {
  void _onPressed(OnboardingProvider onboardingProvider, BuildContext context) {
    onboardingProvider.clearSelectedPlan();
    onboardingProvider.clearCreditCard();
    GoRouter.of(context).push('/onboarding/address');
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<OnboardingProvider>(
      builder: (context, onboardingProvider, child) {
        return OutlinedButton.icon(
          onPressed: () => _onPressed(onboardingProvider, context),
          icon: const Icon(Icons.skip_next),
          label: const Text('Pular assinatura'),
        );
      },
    );
  }
}
