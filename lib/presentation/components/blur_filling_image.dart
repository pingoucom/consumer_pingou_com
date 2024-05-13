import 'dart:ui';

import 'package:flutter/material.dart';

class BlurFillingImage extends StatelessWidget {
  final ImageProvider image;

  final double height;

  final double width;

  final double blurSigma;

  final Color color;

  const BlurFillingImage({
    super.key,
    required this.image,
    required this.height,
    required this.width,
    this.blurSigma = 5,
    this.color = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(color: color),
      child: Stack(
        children: [
          Center(
            child: ImageFiltered(
              imageFilter: ImageFilter.blur(
                sigmaX: blurSigma,
                sigmaY: blurSigma,
              ),
              child: Image(
                image: image,
                fit: BoxFit.cover,
                width: width,
                height: height,
              ),
            ),
          ),
          Center(
            child: Image(
              image: image,
              fit: BoxFit.contain,
              width: width,
              height: height,
            ),
          ),
        ],
      ),
    );
  }
}
