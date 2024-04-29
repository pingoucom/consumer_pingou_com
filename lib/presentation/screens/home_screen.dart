import 'package:consumer_pingou_com/domain/entities/shop.dart';
import 'package:consumer_pingou_com/presentation/components/cachaca_widget.dart';
import 'package:consumer_pingou_com/presentation/components/my_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cachacas = context.watch<Shop>().shop;
    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.onSecondary,
        appBar: AppBar(
          leading: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                Image.asset(
                  'assets/img/pingou-logo.png',
                  height: 32,
                  width: 32,
                ),
              ],
            ),
          ),
          actions: [
            IconButton(
              icon: Icon(Icons.notification_important_rounded),
              onPressed: () {},
            ),
            IconButton(
              icon: Icon(Icons.person),
              onPressed: () {},
            ),
          ],
          title: const Text("Pingou !"),
        ),
        bottomNavigationBar: MyBottomNavigationBar(),
        body: ListView.builder(
          itemCount: cachacas.length,
          itemBuilder: (context, index) {
            final cachaca = cachacas[index];
            return CachacaWidget(cachaca: cachaca);
          },
        ));
  }
}
