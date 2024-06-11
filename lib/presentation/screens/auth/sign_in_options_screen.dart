import 'package:consumer_pingou_com/presentation/components/labeled_divider.dart';
import 'package:consumer_pingou_com/presentation/layouts/bottom_sheet_screen_layout.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SignInOptionsScreen extends StatelessWidget {
  const SignInOptionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomSheetScreenLayout(
      icon: CircleAvatar(
        radius: 24,
        backgroundColor: Colors.black,
        child: Image.asset(
          'assets/img/logo.png',
          height: 24,
        ),
      ),
      message: const [
        TextSpan(text: 'Que '),
        TextSpan(
          text: 'massa',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        TextSpan(text: ' te ver por aqui!'),
      ],
      children: [
        ElevatedButton.icon(
          onPressed: () {},
          icon: Image.asset('assets/img/google-g-logo.png', height: 24),
          label: const Text('Entrar com Google'),
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.black,
            backgroundColor: Colors.white,
          ),
        ),
        ElevatedButton.icon(
          onPressed: () {},
          icon: const Icon(Icons.apple),
          label: const Text('Entrar com Apple'),
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.white,
            backgroundColor: Colors.black,
          ),
        ),
        ElevatedButton.icon(
          onPressed: () {},
          icon: const Icon(Icons.facebook),
          label: const Text('Entrar com Facebook'),
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.white,
            backgroundColor: const Color(0xFF1877F2),
          ),
        ),
        Container(
          margin: const EdgeInsets.symmetric(vertical: 16),
          child: const LabeledDivider(label: 'ou'),
        ),
        ElevatedButton.icon(
          onPressed: () => GoRouter.of(context).push('/auth/local/sign-in'),
          icon: const Icon(Icons.email),
          label: const Text('Entrar com e-mail'),
          style: ElevatedButton.styleFrom(
            foregroundColor: Theme.of(context).colorScheme.onPrimary,
            backgroundColor: Theme.of(context).colorScheme.primary,
          ),
        ),
      ],
    );
  }
}
