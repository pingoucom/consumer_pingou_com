import 'package:consumer_pingou_com/presentation/components/skeleton_shape.dart';
import 'package:consumer_pingou_com/presentation/partials/product/vertical_product_card.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class StoreShowScreen extends StatelessWidget {
  final String productId;

  const StoreShowScreen({
    super.key,
    required this.productId,
  });

  Widget skeleton(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surfaceVariant,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => GoRouter.of(context).canPop()
              ? GoRouter.of(context).pop()
              : GoRouter.of(context).go('/home'),
        ),
        title: const SkeletonShape(
          width: 103,
          height: 28,
          borderRadius: 14,
        ),
      ),
      bottomNavigationBar: const BottomAppBar(
        child: Row(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 6),
              child: SkeletonShape(
                width: 24,
                height: 24,
                borderRadius: 12,
              ),
            ),
            SkeletonShape(
              width: 40,
              height: 28,
              borderRadius: 14,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 6),
              child: SkeletonShape(
                width: 24,
                height: 24,
                borderRadius: 12,
              ),
            ),
            Expanded(
              child: SkeletonShape(
                width: 200,
                height: 48,
                borderRadius: 24,
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SkeletonShape(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.width,
              borderRadius: 0,
            ),
            const SizedBox(
              height: 16,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: SkeletonShape(
                width: 90,
                height: 28,
                borderRadius: 14,
              ),
            ),
            const SizedBox(
              height: 12,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: SkeletonShape(
                width: MediaQuery.of(context).size.width - 32,
                height: 16,
                borderRadius: 8,
              ),
            ),
            const SizedBox(
              height: 4,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: SkeletonShape(
                width: 240,
                height: 16,
                borderRadius: 8,
              ),
            ),
            const SizedBox(
              height: 12,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: SkeletonShape(
                width: 60,
                height: 16,
                borderRadius: 8,
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: SkeletonShape(
                width: 90,
                height: 16,
                borderRadius: 8,
              ),
            ),
            const SizedBox(
              height: 4,
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  const SizedBox(
                    width: 16,
                  ),
                  VerticalProductCard.skeleton(context),
                  const SizedBox(
                    width: 8,
                  ),
                  VerticalProductCard.skeleton(context),
                  const SizedBox(
                    width: 8,
                  ),
                  VerticalProductCard.skeleton(context),
                  const SizedBox(
                    width: 8,
                  ),
                  VerticalProductCard.skeleton(context),
                  const SizedBox(
                    width: 16,
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 16,
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return skeleton(context);
  }
}
