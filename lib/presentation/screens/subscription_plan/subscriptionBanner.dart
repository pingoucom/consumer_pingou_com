import 'package:consumer_pingou_com/infrastructure/providers/subscription_provider.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class SubscriptionBanner extends StatelessWidget {
  const SubscriptionBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => GoRouter.of(context).canPop()
              ? GoRouter.of(context).pop()
              : GoRouter.of(context).push('/store'),
        ),
        title: const Text('Assinatura'),
      ),
      body: Consumer<SubscriptionProvider>(
        builder: (context, provider, child) {
          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              Center(child: _currentPlanCard(provider, context)),
              const SizedBox(height: 16),
              Center(child: _availablePlansCard(provider, context)),
            ],
          );
        },
      ),
    );
  }

  Widget _currentPlanCard(SubscriptionProvider provider, BuildContext context) {
    final currentPlan =
        provider.plans.firstWhere((plan) => plan.name == provider.currentPlan);

    return Card(
      color: Theme.of(context).colorScheme.surface,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Plano Atual',
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.onSurface)),
            const SizedBox(height: 8),
            Text(currentPlan.name,
                style: TextStyle(
                    fontSize: 16,
                    color: Theme.of(context).colorScheme.onSurface)),
            Text(currentPlan.benefits,
                style: TextStyle(
                    color: Theme.of(context).colorScheme.onSurfaceVariant)),
            const SizedBox(height: 16),
            Text('Início do plano: 26/01/2022',
                style: TextStyle(
                    color: Theme.of(context).colorScheme.onSurfaceVariant)),
            const SizedBox(height: 16),
            Text('Suas próximas caixas:',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.onSurface)),
            const Text('Samanau\n51 Ouro'),
            const SizedBox(height: 16),
            Text('Etapa atual',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.onSurface)),
            const Text('Separando pedido'),
            LinearProgressIndicator(
              value: 0.5,
              color: Theme.of(context).colorScheme.primary,
              backgroundColor: Theme.of(context).colorScheme.surfaceVariant,
            ),
          ],
        ),
      ),
    );
  }

  Widget _availablePlansCard(
      SubscriptionProvider provider, BuildContext context) {
    return Card(
      color: Theme.of(context).colorScheme.surface,
      child: ListTile(
        title: Text('Ver planos disponíveis',
            style: TextStyle(color: Theme.of(context).colorScheme.onSurface)),
        subtitle: Text(provider.plans.map((plan) => plan.name).join(', '),
            style: TextStyle(
                color: Theme.of(context).colorScheme.onSurfaceVariant)),
        trailing: Icon(Icons.arrow_forward,
            color: Theme.of(context).colorScheme.onSurface),
        onTap: () => GoRouter.of(context).push('/subscription/allPlans'),
      ),
    );
  }
}
