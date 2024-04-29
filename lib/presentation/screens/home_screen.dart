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
        backgroundColor: Color.fromARGB(255, 23, 23, 22),
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
        body: Column(
          children: [
            Container(
              width: double.infinity,
              height: 150,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.orange[200]!, Colors.orange[400]!],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.delivery_dining_outlined,
                    color: Colors.white,
                    size: 30,
                  ),
                  SizedBox(width: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Sua proxima entrega será em ',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                      ),
                      Text(
                        '3 dias!',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 550,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: EdgeInsets.all(15),
                itemCount: cachacas.length,
                itemBuilder: (context, index) {
                  final cachaca = cachacas[index];
                  return CachacaWidget(cachaca: cachaca);
                },
              ),
            )
          ],
        ));
  }
}
