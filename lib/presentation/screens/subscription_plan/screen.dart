import 'package:consumer_pingou_com/infrastructure/providers/plan_provider.dart';
import 'package:consumer_pingou_com/presentation/layouts/bannered_bottomed_screen_layout.dart';
import 'package:consumer_pingou_com/presentation/screens/subscription_plan/subscription_details.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SubscriptionScreen extends StatefulWidget {
  const SubscriptionScreen({Key? key}) : super(key: key);

  @override
  _SubscriptionScreenState createState() => _SubscriptionScreenState();
}

class _SubscriptionScreenState extends State<SubscriptionScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<PlanProvider>(context, listen: false)
          .loadInitialAvailablePlans();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<PlanProvider>(
      builder: (context, provider, child) {
        final subscription = provider.subscription;

        return BanneredBottomedScreenLayout(
          bottomBarIndex: 2,
          icon: Icons.room_preferences_outlined,
          message: [
            TextSpan(
              text: 'Plano: ${subscription.title}',
              style: const TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
          children: [
            SubscriptionDetails(
              subscription: subscription,
            ),
          ],
        );
      },
    );
  }
}
