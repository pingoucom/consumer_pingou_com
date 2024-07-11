part of 'main.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();

extension GoRouterExtension on GoRouter {
  Future<void> clearStackAndNavigate(String location, {Object? extra}) async {
    while (canPop()) {
      pop();
    }
    await pushReplacement(location, extra: extra);
  }
}

final _router = GoRouter(
  initialLocation: '/auth/local/sign-in',
  navigatorKey: _rootNavigatorKey,
  routes: [
    GoRoute(
      path: '/auth/local/sign-in',
      builder: (context, state) => const LocalSignInScreen(),
    ),
    GoRoute(
      path: '/auth/local/sign-up',
      builder: (context, state) => const LocalSignUpScreen(),
    ),
    GoRoute(
      path: '/splash',
      builder: (context, state) => const Splash(),
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
      builder: (context, state) {
        Map<String, String> extra =
            state.extra != null ? state.extra as Map<String, String> : {};

        return StoreIndexScreen(selectedTagId: extra['tagId']);
      },
    ),
    GoRoute(
      path: '/store/:productId',
      builder: (context, state) =>
          StoreShowScreen(productId: state.pathParameters['productId']!),
    ),
    GoRoute(
      path: '/home',
      builder: (context, state) => const HomeIndexScreen(),
    ),
    GoRoute(
      path: '/subscription',
      builder: (context, state) => const SubscriptionScreen(),
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
    GoRoute(
      path: '/orders',
      builder: (context, state) => const OrdersIndexScreen(),
    ),
    GoRoute(
      path: '/orders/:orderId',
      builder: (context, state) =>
          OrderShowScreen(orderId: state.pathParameters['orderId']!),
    ),
  ],
);
