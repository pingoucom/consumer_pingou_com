import 'package:flutter/material.dart';
part 'info_status.dart';
part 'section.dart';
part 'info_row.dart';

class AssinaturaScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Caixaça!'),
      ),
      body: Consumer<SubscriptionProvider>(
        builder: (context, provider, child) {
          if (provider.isLoading) {
            return Center(child: CircularProgressIndicator());
          }

          final subscription = provider.subscription;

          if (subscription == null) {
            return Center(child: Text('Failed to load subscription details'));
          }

          return SingleChildScrollView(
            child: Stack(
              children: [
                Positioned(
                  top: 180,
                  left: 0,
                  right: 0,
                  child: Container(
                    color: Colors.grey,
                    height: 90,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          StatusInfo(
                            title: 'Status',
                            value: subscription.status,
                          ),
                          StatusInfo(
                            title: 'Plano',
                            value: subscription.plan,
                          ),
                          StatusInfo(
                            title: 'Geração de pedido',
                            value: subscription.generationDate,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Container(
                      decoration: const BoxDecoration(
                        color: Colors.orange,
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(10),
                          bottomRight: Radius.circular(10),
                        ),
                      ),
                      padding: const EdgeInsets.all(16.0),
                      child: const Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(
                            'Nome do plano',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 28,
                            ),
                          ),
                          SizedBox(height: 100),
                          SizedBox(height: 16),
                        ],
                      ),
                    ),
                    const SizedBox(height: 80),
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 8.0, right: 14, top: 12),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Row(
                            children: [
                              Icon(Icons.local_drink),
                              SizedBox(width: 12),
                              Text("Seleção do Mês",
                                  style: TextStyle(fontSize: 16)),
                            ],
                          ),
                          IconButton(
                            icon: const Icon(Icons.arrow_forward_outlined,
                                size: 16),
                            onPressed: () {},
                          ),
                        ],
                      ),
                    ),
                    Section(
                      title: 'Entrega e pagamento',
                      children: [
                        InfoRow(
                          label: 'Data de Geração do pedido',
                          value: subscription.generationDate,
                        ),
                        const SizedBox(height: 10),
                        InfoRow(
                          label: 'Endereço',
                          value: subscription.address,
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Section(
                      title: 'Gerenciar Assinatura',
                      children: [
                        InfoRow(
                          label: 'Renovação',
                          value: subscription.renewalDate,
                        ),
                        const SizedBox(height: 10),
                        InfoRow(
                          label: 'Plano',
                          value: subscription.plan,
                        ),
                        const SizedBox(height: 10),
                        InfoRow(label: "Trocar WineBox", value: ""),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 2,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Início',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.store),
            label: 'Loja',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today),
            label: 'Assinatura',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'Pedidos',
          ),
        ],
      ),
    );
  }
}
