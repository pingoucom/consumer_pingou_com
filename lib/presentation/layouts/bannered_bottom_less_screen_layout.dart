import 'package:consumer_pingou_com/presentation/components/decorated_banner.dart';
import 'package:consumer_pingou_com/presentation/components/skeleton_shape.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class BanneredBottomLessScreenLayout extends StatelessWidget {
  final List<Widget> children;

  final IconData icon;

  final List<TextSpan> message;

  final Widget title;

  const BanneredBottomLessScreenLayout({
    super.key,
    required this.children,
    required this.icon,
    required this.message,
    required this.title,
  });

  static Widget skeleton(BuildContext context, List<Widget> children) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surfaceVariant,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => GoRouter.of(context).canPop()
              ? GoRouter.of(context).pop()
              : GoRouter.of(context).push('/home'),
        ),
        title: const SkeletonShape(
          width: 160,
          height: 28,
          borderRadius: 14,
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              DecoratedBanner.skeleton(context),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: SizedBox(
                  height: 24,
                  width: 24,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.surfaceVariant,
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(24),
                        topRight: Radius.circular(24),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: children,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surfaceVariant,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => GoRouter.of(context).canPop()
              ? GoRouter.of(context).pop()
              : GoRouter.of(context).push('/home'),
        ),
        title: title,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              DecoratedBanner(
                icon: icon,
                message: message,
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: SizedBox(
                  height: 24,
                  width: 24,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.surfaceVariant,
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(24),
                        topRight: Radius.circular(24),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Expanded(
            child: Column(
              children: children,
            ),
          ),
        ],
      ),
    );
  }
}
