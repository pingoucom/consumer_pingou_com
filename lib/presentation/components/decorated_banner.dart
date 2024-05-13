import 'package:flutter/material.dart';

class DecoratedBanner extends StatelessWidget {
  final IconData icon;

  final List<TextSpan> message;

  const DecoratedBanner({
    super.key,
    required this.icon,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
        top: 48,
        bottom: 72,
        left: 48,
        right: 48,
      ),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFFF7971E),
            Color(0xFFFF4E50),
          ],
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                color: Colors.white,
                size: 24,
              ),
              const SizedBox(height: 8),
              RichText(
                text: TextSpan(
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                  children: message,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
