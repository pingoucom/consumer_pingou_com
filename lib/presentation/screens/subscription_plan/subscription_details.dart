import 'package:consumer_pingou_com/domain/entities/plan.dart';
import 'package:consumer_pingou_com/infrastructure/providers/store_provider.dart';
import 'package:consumer_pingou_com/presentation/screens/subscription_plan/info_row.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SubscriptionDetails extends StatelessWidget {
  final Plan subscription;

  const SubscriptionDetails({super.key, required this.subscription});
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Detalhes da Assinatura',
                  style: Theme.of(context).textTheme.headlineLarge,
                ),
                const SizedBox(height: 16),
                _buildSelectionTile(context),
                _buildDeliveryTile(context),
                _buildManageTile(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSelectionTile(BuildContext context) {
    final storeProvider = context.read<StoreProvider>();

    return ListTile(
      leading: const Icon(Icons.local_drink),
      title: const Text("Seleção do Mês"),
      trailing: IconButton(
        icon: const Icon(Icons.arrow_forward_outlined),
        onPressed: () async {
          storeProvider.loadInitialData();

          showDialog(
            context: context,
            builder: (BuildContext context) {
              final products = storeProvider.featuredProductsByTagId['1']!;
              final cachacas = products
                  .where((product) => product.id == '1' || product.id == '2')
                  .toList();

              if (cachacas.isEmpty) {
                return AlertDialog(
                  title: Text('Cachaças do Mês'),
                  content:
                      Text('Nenhuma cachaça encontrada com os IDs fornecidos.'),
                  actions: [
                    TextButton(
                      child: Text('Fechar'),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                );
              }

              return AlertDialog(
                title: Text('Cachaças do Mês'),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: cachacas.map((product) {
                    return ListTile(
                      leading: Image.network(product.image),
                      title: Text(product.name),
                      subtitle: Text(product.description),
                    );
                  }).toList(),
                ),
                actions: [
                  TextButton(
                    child: Text('Fechar'),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }

  Widget _buildDeliveryTile(BuildContext context) {
    return ExpansionTile(
      leading: const Icon(Icons.local_shipping),
      title: const Text('Entrega e pagamento'),
      children: [
        InfoRow(
          label: 'Data de Geração do pedido',
          value: '08/07/2024',
        ),
        const SizedBox(height: 10),
        InfoRow(
          label: 'Endereço',
          value: 'Endereço genérico',
        ),
      ],
    );
  }

  Widget _buildManageTile(BuildContext context) {
    return ExpansionTile(
      leading: const Icon(Icons.settings),
      title: const Text('Gerenciar Assinatura'),
      children: [
        InfoRow(
          label: 'Renovação',
          value: 'Data de Renovação',
        ),
        const SizedBox(height: 10),
        InfoRow(
          label: 'Plano',
          value: subscription.title,
        ),
        const SizedBox(height: 10),
        InfoRow(
          label: "Trocar WineBox",
          value: "",
        ),
      ],
    );
  }
}
