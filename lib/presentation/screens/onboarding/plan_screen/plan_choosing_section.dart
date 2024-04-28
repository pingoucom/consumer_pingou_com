part of 'screen.dart';

class _PlanChoosingSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Mostrar valor '),
            const SizedBox(width: 4),
            _RecurrenceToggleButton(),
          ],
        ),
        const SizedBox(height: 16),
        _PlanCardCarousel(),
      ],
    );
  }
}

class _RecurrenceToggleButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<OnboardingProvider>(
      builder: (context, onboardingProvider, child) {
        return SegmentedButton<bool>(
          segments: const <ButtonSegment<bool>>[
            ButtonSegment(
              label: Text('Mensal'),
              value: true,
            ),
            ButtonSegment(
              label: Text('Semestral'),
              value: false,
            ),
          ],
          selected: <bool>{onboardingProvider.showingMonthlyPrice},
          showSelectedIcon: false,
          onSelectionChanged: (_) => onboardingProvider.togglePriceView(),
        );
      },
    );
  }
}
