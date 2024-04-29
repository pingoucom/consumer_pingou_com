import 'package:consumer_pingou_com/domain/entities/shop.dart';
import 'package:consumer_pingou_com/domain/repositories/address_repository.dart';
import 'package:consumer_pingou_com/domain/repositories/plan_repository.dart';
import 'package:consumer_pingou_com/infrastructure/providers/onboarding_provider.dart';
import 'package:consumer_pingou_com/infrastructure/repositories/mock/mocked_plan_repository.dart';
import 'package:consumer_pingou_com/infrastructure/repositories/viacep/viacep_address_repository.dart';
import 'package:consumer_pingou_com/presentation/screens/auth/local_sign_in_screen.dart';
import 'package:consumer_pingou_com/presentation/screens/auth/local_sign_up_screen.dart';
import 'package:consumer_pingou_com/presentation/screens/auth/sign_in_options_screen.dart';
import 'package:consumer_pingou_com/presentation/screens/home_screen.dart';
import 'package:consumer_pingou_com/presentation/screens/onboarding/address_screen.dart';
import 'package:consumer_pingou_com/presentation/screens/onboarding/credit_card_screen.dart';
import 'package:consumer_pingou_com/presentation/screens/onboarding/plan_screen/screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

part 'dependencies.dart';
part 'router.dart';
part 'themes/theme.dart';

void main() {
  initializeDependencies();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => OnboardingProvider(resolve<PlanRepository>()),
        ),
        ChangeNotifierProvider(create: (context) => Shop()),
      ],
      child: const MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: _router,
      theme: _lightTheme,
    );
  }
}
