import 'package:consumer_pingou_com/domain/repositories/address_repository.dart';
import 'package:consumer_pingou_com/domain/repositories/banner_repository.dart';
import 'package:consumer_pingou_com/domain/repositories/credit_card_repository.dart';
import 'package:consumer_pingou_com/domain/repositories/order_repository.dart';
import 'package:consumer_pingou_com/domain/repositories/plan_repository.dart';
import 'package:consumer_pingou_com/domain/repositories/product_repository.dart';
import 'package:consumer_pingou_com/infrastructure/providers/address_provider.dart';
import 'package:consumer_pingou_com/infrastructure/providers/checkout_provider.dart';
import 'package:consumer_pingou_com/infrastructure/providers/credit_card_provider.dart';
import 'package:consumer_pingou_com/infrastructure/providers/homeBannerScreen_provider.dart';
import 'package:consumer_pingou_com/infrastructure/providers/homeScreen_provider.dart';
import 'package:consumer_pingou_com/infrastructure/providers/onboarding_provider.dart';
import 'package:consumer_pingou_com/infrastructure/providers/order_provider.dart';
import 'package:consumer_pingou_com/infrastructure/providers/store_provider.dart';
import 'package:consumer_pingou_com/infrastructure/providers/subscription_provider.dart';
import 'package:consumer_pingou_com/infrastructure/repositories/mock/mocked_address_repository.dart';
import 'package:consumer_pingou_com/infrastructure/repositories/mock/mocked_banner_repository.dart';
import 'package:consumer_pingou_com/infrastructure/repositories/mock/mocked_credit_card_repository.dart';
import 'package:consumer_pingou_com/infrastructure/repositories/mock/mocked_order_repository.dart';
import 'package:consumer_pingou_com/infrastructure/repositories/mock/mocked_plan_repository.dart';
import 'package:consumer_pingou_com/infrastructure/repositories/mock/mocked_product_repository.dart';
import 'package:consumer_pingou_com/presentation/screens/addresses/index/screen.dart';
import 'package:consumer_pingou_com/presentation/screens/auth/local_sign_in_screen.dart';
import 'package:consumer_pingou_com/presentation/screens/auth/local_sign_up_screen.dart';
import 'package:consumer_pingou_com/presentation/screens/auth/sign_in_options_screen.dart';
import 'package:consumer_pingou_com/presentation/screens/checkout/cart/screen.dart';
import 'package:consumer_pingou_com/presentation/screens/checkout/confirmation/screen.dart';
import 'package:consumer_pingou_com/presentation/screens/credit_cards/index/screen.dart';
import 'package:consumer_pingou_com/presentation/screens/home/screen.dart';
import 'package:consumer_pingou_com/presentation/screens/onboarding/address_screen.dart';
import 'package:consumer_pingou_com/presentation/screens/onboarding/credit_card_screen.dart';
import 'package:consumer_pingou_com/presentation/screens/onboarding/plan_screen/screen.dart';
import 'package:consumer_pingou_com/presentation/screens/orders/index/screen.dart';
import 'package:consumer_pingou_com/presentation/screens/orders/show/screen.dart';
import 'package:consumer_pingou_com/presentation/screens/splash.dart';
import 'package:consumer_pingou_com/presentation/screens/store/index/screen.dart';
import 'package:consumer_pingou_com/presentation/screens/store/show/screen.dart';
import 'package:consumer_pingou_com/presentation/screens/subscription_plan/avaiable_plans_page.dart';
import 'package:consumer_pingou_com/presentation/screens/subscription_plan/subscriptionBanner.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:provider/provider.dart';

part 'dependencies.dart';
part 'router.dart';
part 'themes/theme.dart';

void main() async {
  initializeDependencies();
  await initializeDateFormatting('pt_BR', null);

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => SubscriptionProvider()),
        ChangeNotifierProvider(
          create: (_) => AddressProvider(
            resolve<AddressRepository>(),
          ),
        ),
        ChangeNotifierProvider(
          create: (_) => CreditCardProvider(
            resolve<CreditCardRepository>(),
          ),
        ),
        ChangeNotifierProvider(
          create: (_) => CheckoutProvider(
            resolve<ProductRepository>(),
          ),
        ),
        ChangeNotifierProvider(
          create: (_) => StoreProvider(
            resolve<ProductRepository>(),
          ),
        ),
        ChangeNotifierProvider(
          create: (_) => OnboardingProvider(
            resolve<PlanRepository>(),
          ),
        ),
        ChangeNotifierProvider(
          create: (_) => HomeBannerScreenProvider(
            resolve<BannerRepository>(),
          ),
        ),
        ChangeNotifierProvider(
          create: (_) => OrderProvider(
            resolve<OrderRepository>(),
          ),
        ),
        ChangeNotifierProvider(
          create: (_) => HomeScreenProvider(
            resolve<ProductRepository>(),
          ),
        ),
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
