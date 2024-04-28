import 'dart:ui';

import 'package:flutter/material.dart';

class BottomSheetScreenLayout extends StatelessWidget {
  final List<Widget> children;

  final Widget icon;

  final List<TextSpan> message;

  const BottomSheetScreenLayout({
    super.key,
    required this.children,
    required this.icon,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _TopGreetings(
            icon: icon,
            message: message,
          ),
          ConstrainedBox(
            constraints: BoxConstraints(
              maxHeight: MediaQuery.of(context).size.height -
                  MediaQuery.of(context).padding.top -
                  MediaQuery.of(context).viewInsets.bottom,
            ),
            child: Container(
              padding: const EdgeInsets.only(left: 24, right: 24, top: 24),
              child: _BottomSheet(children: children),
            ),
          ),
        ],
      ),
    );
  }
}

class _TopGreetings extends StatelessWidget {
  final Widget icon;

  final List<TextSpan> message;

  const _TopGreetings({required this.icon, required this.message});

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Flexible(
            child: Container(
              margin: const EdgeInsets.only(bottom: 8),
              child: icon,
            ),
          ),
          Flexible(
            child: RichText(
              text: TextSpan(
                style: Theme.of(context).textTheme.bodyLarge,
                children: message,
              ),
            ),
          ),
        ],
      ),
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
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 16,
              offset: const Offset(0, 0),
            ),
          ],
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(24),
            topRight: Radius.circular(24),
          ),
        ),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: FocusableActionDetector(
            onFocusChange: _handleFocusChange,
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 32),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: widget.children,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
