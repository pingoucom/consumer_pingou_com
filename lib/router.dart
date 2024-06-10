part of 'main.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();

final _router = GoRouter(
  initialLocation: '/store',
  navigatorKey: _rootNavigatorKey,
  routes: [
    GoRoute(
      path: '/auth/sign-in-options',
      builder: (context, state) => const SignInOptionsScreen(),
    ),
    GoRoute(
      path: '/auth/local/sign-in',
      builder: (context, state) => const LocalSignInScreen(),
    ),
    GoRoute(
      path: '/auth/local/sign-up',
      builder: (context, state) => const LocalSignUpScreen(),
    ),
    GoRoute(
      path: '/onboarding/plan',
      builder: (context, state) => const PlanScreen(),
    ),
    GoRoute(
      path: '/onboarding/credit-card',
      builder: (context, state) => const CreditCardScreen(),
    ),
    GoRoute(
      path: '/onboarding/address',
      builder: (context, state) => const AddressScreen(),
    ),
    GoRoute(
      path: '/store',
      builder: (context, state) => const StoreIndexScreen(),
    ),
    GoRoute(
      path: '/home',
      builder: (context, state) => const HomeIndexScreen(),
    ),
    GoRoute(
      path: '/subscription',
      builder: (context, state) => const SubscriptionBanner(),
    ),
    GoRoute(
      path: '/subscription/allPlans',
      builder: (context, state) => const AvailablePlansPage(),
    ),
    GoRoute(
      path: '/checkout/cart',
      builder: (context, state) => const CartScreen(),
    ),
    GoRoute(
      path: '/checkout/confirmation',
      builder: (context, state) => const ConfirmationScreen(),
    ),
    GoRoute(
      path: '/addresses',
      builder: (context, state) => const AddressesIndexScreen(),
    ),
    GoRoute(
      path: '/credit-cards',
      builder: (context, state) => const CreditCardsIndexScreen(),
    ),
  ],
);
