import 'dart:ui';

import 'package:flutter/material.dart';

class BlurredBottomSheet extends StatelessWidget {
  final Widget child;

  const BlurredBottomSheet({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
      child: Container(
        margin: const EdgeInsets.only(left: 24, right: 24, top: 24),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(16),
            topRight: Radius.circular(16),
          ),
        ),
        clipBehavior: Clip.antiAlias,
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            color: Theme.of(context).colorScheme.surface,
            child: Padding(
              padding: const EdgeInsets.all(32),
              child: child,
            ),
          ),
        ),
      ),
    );
  }
}

Future<T?> showModalBlurredBottomSheet<T>({
  required BuildContext context,
  required WidgetBuilder builder,
}) async {
  return showModalBottomSheet(
    isScrollControlled: true,
    context: context,
    builder: (builderContext) => BlurredBottomSheet(
      child: builder(builderContext),
    ),
    backgroundColor: Colors.transparent,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(16),
        topRight: Radius.circular(16),
      ),
    ),
  );
}
