part of 'main.dart';

final _router = GoRouter(
  initialLocation: '/auth/sign-in-options',
  routes: [
    GoRoute(
      path: '/auth/sign-in-options',
      builder: (context, state) => const SignInOptionsScreen(),
    ),
    GoRoute(
      path: '/auth/local-sign-in',
      pageBuilder: (context, state) {
        return CustomTransitionPage(
          key: state.pageKey,
          child: const LocalSignIn(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) =>
              SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(1, 0),
              end: Offset.zero,
            ).animate(animation),
            child: child,
          ),
        );
      },
    ),
    GoRoute(
      path: '/auth/local-sign-up',
      pageBuilder: (context, state) {
        return CustomTransitionPage(
          key: state.pageKey,
          child: const LocalSignUp(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) =>
              SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(1, 0),
              end: Offset.zero,
            ).animate(animation),
            child: child,
          ),
        );
      },
    ),
  ],
);
