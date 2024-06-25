import 'package:consumer_pingou_com/domain/entities/product.dart';
import 'package:consumer_pingou_com/presentation/components/blur_filling_image.dart';
import 'package:consumer_pingou_com/presentation/components/skeleton_shape.dart';
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

  static Widget skeleton(BuildContext context, Widget? trailing) {
    return Card(
      clipBehavior: Clip.antiAlias,
      margin: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          const SkeletonShape(
            height: 96,
            width: 96,
            borderRadius: 0,
          ),
          Expanded(
            child: ListTile(
              title: const SkeletonShape(
                height: 16,
                width: 32,
                borderRadius: 8,
              ),
              subtitle: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(height: 4),
                  SkeletonShape(
                    height: 16,
                    width: double.infinity,
                    borderRadius: 8,
                  ),
                  SizedBox(height: 4),
                  SkeletonShape(
                    height: 16,
                    width: 48,
                    borderRadius: 8,
                  ),
                ],
              ),
              isThreeLine: true,
              trailing: trailing,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      margin: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          BlurFillingImage(
            image: AssetImage("assets/img/placeholder.png"),
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
