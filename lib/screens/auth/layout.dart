import 'dart:ui';

import 'package:flutter/material.dart';

class AuthScreenLayout extends StatelessWidget {
  final List<Widget> children;

  const AuthScreenLayout({super.key, required this.children});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      body: Container(
        alignment: Alignment.center,
        child: Column(
          children: [
            Expanded(
              child: _TopGreetings(),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: _BottomSheet(children: children),
            ),
          ],
        ),
      ),
    );
  }
}

class _TopGreetings extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          margin: const EdgeInsets.only(bottom: 8),
          child: CircleAvatar(
            radius: 24,
            backgroundColor: Colors.black,
            child: Image.asset(
              'assets/img/pingou-logo.png',
              height: 24,
            ),
          ),
        ),
        RichText(
          text: TextSpan(
            style: Theme.of(context).textTheme.bodyMedium,
            children: const [
              TextSpan(text: 'Que '),
              TextSpan(
                text: 'massa',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              TextSpan(text: ' te ver por aqui!'),
            ],
          ),
        ),
      ],
    );
  }
}

class _BottomSheet extends StatefulWidget {
  final List<Widget> children;

  const _BottomSheet({required this.children});

  @override
  State<_BottomSheet> createState() => _BottomSheetState();
}

class _BottomSheetState extends State<_BottomSheet> {
  bool _hasFocus = false;

  void _handleFocusChange(bool hasFocus) {
    setState(() {
      _hasFocus = hasFocus;
    });
  }

  @override
  Widget build(BuildContext context) {
    ImageFilter filter = ImageFilter.compose(
      outer: ColorFilter.mode(
        Colors.black.withOpacity(0.15),
        BlendMode.srcOver,
      ),
      inner: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
    );

    return BackdropFilter(
      filter: _hasFocus ? filter : ImageFilter.blur(),
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(24),
            topRight: Radius.circular(24),
          ),
        ),
        child: Container(
          padding: const EdgeInsets.all(32),
          child: FocusableActionDetector(
            onFocusChange: _handleFocusChange,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: widget.children,
            ),
          ),
        ),
      ),
    );
  }
}
