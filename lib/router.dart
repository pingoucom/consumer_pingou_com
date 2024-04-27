part of 'main.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();

final _router = GoRouter(
  initialLocation: '/auth/sign-in-options',
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
  ],
);
