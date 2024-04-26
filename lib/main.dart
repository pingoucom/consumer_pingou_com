import 'package:consumer_pingou_com/screens/auth/local_sign_in.dart';
import 'package:consumer_pingou_com/screens/auth/local_sign_up.dart';
import 'package:consumer_pingou_com/screens/auth/sign_in_options.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

part 'router.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: _router,
    );
  }
}
