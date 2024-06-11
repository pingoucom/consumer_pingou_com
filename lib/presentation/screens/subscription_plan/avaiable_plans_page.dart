import 'package:consumer_pingou_com/domain/entities/subscriptionPlan.dart';
import 'package:consumer_pingou_com/infrastructure/providers/subscription_provider.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class AvailablePlansPage extends StatelessWidget {
  const AvailablePlansPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surfaceVariant,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => GoRouter.of(context).canPop()
              ? GoRouter.of(context).pop()
              : GoRouter.of(context).go('/home'),
        ),
        title: const Text('Pingou!'),
      ),
      body: Consumer<SubscriptionProvider>(
        builder: (context, provider, child) {
          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: provider.plans.length,
            itemBuilder: (context, index) {
              final subscriptionPlan = provider.plans[index];
              final isActive = subscriptionPlan.is_active;

              return _planCard(subscriptionPlan, context, isActive!);
            },
          );
        },
      ),
    );
  }

  Widget _planCard(SubscriptionPlan plan, BuildContext context, bool isActive) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (isActive) // Exibe o texto "Assinado" somente se o card estiver ativo
              const Padding(
                padding: EdgeInsets.only(bottom: 8),
                child: Text(
                  'Assinado',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            Text(
              plan.name,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              plan.benefits,
            ),
            const SizedBox(height: 16),
            const Text(
              'Ultima caixa:',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            const Text('Samanau\n51 Ouro'),
          ],
        ),
      ),
    );
  }
}
