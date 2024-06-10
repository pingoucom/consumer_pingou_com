import 'package:consumer_pingou_com/domain/entities/product.dart';
import 'package:consumer_pingou_com/presentation/components/blur_filling_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HorizontalProductCard extends StatelessWidget {
  final Product product;

  final Widget? trailing;

  const HorizontalProductCard({
    super.key,
    required this.product,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      margin: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          BlurFillingImage(
            image: AssetImage(product.image),
            height: 96,
            width: 96,
          ),
          Expanded(
            child: ListTile(
              title: Text(product.name),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    product.description,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    NumberFormat.simpleCurrency(
                      locale: 'pt_BR',
                    ).format(product.price),
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                ],
              ),
              isThreeLine: true,
            ),
          ),
          if (trailing != null) trailing!,
        ],
      ),
    );
  }
}
