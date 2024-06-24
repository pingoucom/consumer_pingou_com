import 'package:consumer_pingou_com/domain/dto/product/product_details.dart';
import 'package:consumer_pingou_com/infrastructure/providers/checkout_provider.dart';
import 'package:consumer_pingou_com/infrastructure/providers/store_provider.dart';
import 'package:consumer_pingou_com/presentation/components/blur_filling_image.dart';
import 'package:consumer_pingou_com/presentation/components/skeleton_shape.dart';
import 'package:consumer_pingou_com/presentation/partials/product/vertical_product_card.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

part 'product_display.dart';

class StoreShowScreen extends StatelessWidget {
  final String productId;

  const StoreShowScreen({
    super.key,
    required this.productId,
  });

  @override
  Widget build(BuildContext context) {
    final storeProvider = context.read<StoreProvider>();

    return FutureBuilder<ProductDetails>(
      future: storeProvider.findProduct(
          productId), // Altere para o método que busca apenas o produto
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return _ProductDisplay.skeleton(context);
        }

        if (snapshot.hasError) {
          GoRouter.of(context).canPop()
              ? GoRouter.of(context).pop()
              : GoRouter.of(context).push('/store');

          return _ProductDisplay.skeleton(context);
        }

        final productDetails = snapshot.data;

        if (productDetails == null) {
          GoRouter.of(context).canPop()
              ? GoRouter.of(context).pop()
              : GoRouter.of(context).push('/store');

          return _ProductDisplay.skeleton(context);
        }

        return _ProductDisplay(productDetails: productDetails);
      },
    );
  }
}
