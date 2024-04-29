import 'package:consumer_pingou_com/domain/entities/cachaca.dart';
import 'package:consumer_pingou_com/domain/entities/shop.dart';
import 'package:flutter/material.dart';

class CachacaWidget extends StatelessWidget {
  final Cachaca cachaca;

  const CachacaWidget({Key? key, required this.cachaca}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Color(0xFFF6F0E7),
        borderRadius: BorderRadius.circular(15),
      ),
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            cachaca.image,
            width: 250,
            height: 250,
            fit: BoxFit.cover,
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  cachaca.name,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  cachaca.description,
                  style: TextStyle(
                    fontSize: 14,
                  ),
                ),
                Text(
                  '\$${cachaca.price.toStringAsFixed(2)}',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Shop().addToCart(cachaca);
            },
            child: Text('Add to Cart'),
          ),
        ],
      ),
    );
  }
}
