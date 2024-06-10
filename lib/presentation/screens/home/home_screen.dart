import 'package:consumer_pingou_com/domain/entities/product.dart';
import 'package:consumer_pingou_com/infrastructure/providers/homeScreen_provider.dart';
import 'package:consumer_pingou_com/presentation/components/my_bottom_bar.dart';
import 'package:consumer_pingou_com/presentation/screens/home/banner_home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

part 'product_skeleton.dart';
part 'product_widget.dart';
part 'product_widget_carrousel.dart';
part 'category_bar.dart';
part 'category_skeleton.dart';
part 'category_widget.dart';
part 'store_home_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 23, 23, 22),
        appBar: AppBar(
          leading: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                Image.asset(
                  'assets/img/pingou-logo.png',
                  height: 25,
                  width: 25,
                ),
              ],
            ),
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.notification_important_rounded),
              onPressed: () {},
            ),
            IconButton(
              icon: const Icon(Icons.person),
              onPressed: () {},
            ),
          ],
          title: const Text("Pingou !"),
        ),
        bottomNavigationBar: MyBottomNavigationBar(),
        body: SingleChildScrollView(
          child: Stack(
            children: [
              BannerHome(),
              const Padding(
                padding: EdgeInsets.only(top: 150),
                child: Column(
                  children: [
                    _StoreHomeWidget(),
                  ],
                ),
              )
            ],
          ),
        ));
  }
}