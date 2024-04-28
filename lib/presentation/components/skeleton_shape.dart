import 'package:flutter/material.dart';

class SkeletonShape extends StatefulWidget {
  final double width;
  final double height;
  final double borderRadius;

  const SkeletonShape({
    super.key,
    required this.width,
    required this.height,
    required this.borderRadius,
  });

  @override
  _SkeletonShapeState createState() => _SkeletonShapeState();
}

class _SkeletonShapeState extends State<SkeletonShape>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );

    _animation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );

    _controller.repeat(reverse: true);

    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _Shape(
      animation: _animation,
      width: widget.width,
      height: widget.height,
      borderRadius: widget.borderRadius,
    );
  }
}

class _Shape extends AnimatedWidget {
  final double width;
  final double height;
  final double borderRadius;

  const _Shape({
    required Animation<double> animation,
    required this.width,
    required this.height,
    required this.borderRadius,
  }) : super(listenable: animation);

  Animation<double> get _progress => listenable as Animation<double>;

  @override
  Widget build(BuildContext context) {
    return PhysicalShape(
      color: Colors.transparent,
      clipper: ShapeBorderClipper(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      child: SizedBox(
        width: width,
        height: height,
        child: DecoratedBox(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(borderRadius),
            gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [
                Color.alphaBlend(
                  Theme.of(context).colorScheme.surface.withAlpha(224),
                  Theme.of(context).colorScheme.onSurface,
                ),
                Color.alphaBlend(
                  Theme.of(context).colorScheme.surface.withAlpha(208),
                  Theme.of(context).colorScheme.onSurface,
                ),
                Color.alphaBlend(
                  Theme.of(context).colorScheme.surface.withAlpha(224),
                  Theme.of(context).colorScheme.onSurface,
                ),
              ],
              stops: [
                _progress.value - 1,
                _progress.value,
                _progress.value + 1,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
