import 'package:consumer_pingou_com/components/labeled_divider.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SignInOptionsScreen extends StatelessWidget {
  const SignInOptionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              margin: const EdgeInsets.only(bottom: 8),
              child: CircleAvatar(
                radius: 24,
                backgroundColor: Colors.black,
                child: Image.asset(
                  'assets/img/pingou-logo.png',
                  height: 24,
                ),
              ),
            ),
            RichText(
              text: TextSpan(
                style: Theme.of(context).textTheme.bodyMedium,
                children: const [
                  TextSpan(text: 'Que '),
                  TextSpan(
                    text: 'massa',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextSpan(text: ' te ver por aqui!'),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomSheet: SizedBox(
        width: MediaQuery.of(context).size.width - 64,
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
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
                label: const Text('Ealc-ntrar com Apple'),
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
                onPressed: () => GoRouter.of(context).go('/auth/local-sign-in'),
                icon: const Icon(Icons.email),
                label: const Text('Entrar com e-mail'),
                style: ElevatedButton.styleFrom(
                  foregroundColor: Theme.of(context).colorScheme.onPrimary,
                  backgroundColor: Theme.of(context).colorScheme.primary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
