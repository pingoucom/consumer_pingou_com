import 'package:consumer_pingou_com/infrastructure/providers/subscription_provider.dart';
import 'package:consumer_pingou_com/presentation/layouts/bannered_bottomed_screen_layout.dart';
import 'package:consumer_pingou_com/presentation/screens/subscription_plan/subscription_details.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SubscriptionScreen extends StatelessWidget {
  const SubscriptionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<SubscriptionProvider>(
      builder: (context, provider, child) {
        final subscription = provider.subscription;

        return BanneredBottomedScreenLayout(
          bottomBarIndex: 2,
          icon: Icons.room_preferences_outlined,
          message: [
            TextSpan(
              text: 'Plano: ${subscription.name}',
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
