import 'package:consumer_pingou_com/domain/entities/cachaca.dart';
import 'package:consumer_pingou_com/domain/entities/shop.dart';
import 'package:flutter/material.dart';

class CachacaWidget extends StatelessWidget {
  final Cachaca cachaca;

  const CachacaWidget({Key? key, required this.cachaca}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset(
            cachaca.image,
            width: 181,
            height: 231,
            fit: BoxFit.cover,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
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
