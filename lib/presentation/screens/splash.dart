import 'package:another_flutter_splash_screen/another_flutter_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class Splash extends StatelessWidget {
  const Splash({super.key});

  @override
  Widget build(BuildContext context) {
    return FlutterSplashScreen.fadeIn(
      backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      duration: const Duration(seconds: 5),
      childWidget: SizedBox(
        height: 600,
        width: 600,
        child: Image.asset('assets/img/logo2.png'),
      ),
      onAnimationEnd: () => GoRouter.of(context).replace('/auth/local/sign-in'),
    );
  }
}
