import 'package:consumer_pingou_com/domain/entities/product.dart';
import 'package:consumer_pingou_com/presentation/components/blur_filling_image.dart';
import 'package:consumer_pingou_com/presentation/components/skeleton_shape.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class VerticalProductCard extends StatelessWidget {
  final Product product;

  final GestureTapCallback? onTap;

  const VerticalProductCard({
    super.key,
    required this.product,
    this.onTap,
  });

  static Widget skeleton(BuildContext context) {
    return const SizedBox(
      height: 244,
      width: 180,
      child: Card(
        clipBehavior: Clip.antiAlias,
        margin: EdgeInsets.symmetric(vertical: 4),
        child: Column(
          children: [
            SkeletonShape(
              height: 150,
              width: 180,
              borderRadius: 0,
            ),
            Expanded(
              child: ListTile(
                title: Padding(
                  padding: EdgeInsets.only(bottom: 4),
                  child: SkeletonShape(
                    width: 120,
                    height: 20,
                    borderRadius: 10,
                  ),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SkeletonShape(
                      width: 80,
                      height: 16,
                      borderRadius: 8,
                    ),
                    SizedBox(height: 4),
                    SkeletonShape(
                      width: 80,
                      height: 18,
                      borderRadius: 9,
                    ),
                  ],
                ),
                isThreeLine: true,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 244,
      width: 180,
      child: Card(
        clipBehavior: Clip.antiAlias,
        margin: const EdgeInsets.symmetric(vertical: 4),
        child: InkWell(
          onTap: onTap,
          child: Column(
            children: [
              BlurFillingImage(
                image: AssetImage(product.image),
                height: 150,
                width: 180,
              ),
              Expanded(
                child: ListTile(
                  title: Text(
                    product.name,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        product.description,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        NumberFormat.simpleCurrency(
                          locale: 'pt_BR',
                        ).format(product.price),
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).primaryColor,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                  isThreeLine: true,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
