import 'package:consumer_pingou_com/presentation/components/labeled_divider.dart';
import 'package:consumer_pingou_com/presentation/layouts/bottom_sheet_screen_layout.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class LocalSignInScreen extends StatefulWidget {
  const LocalSignInScreen({super.key});

  @override
  State<LocalSignInScreen> createState() => _LocalSignInScreenState();
}

class _LocalSignInScreenState extends State<LocalSignInScreen> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BottomSheetScreenLayout(
      icon: CircleAvatar(
        radius: 24,
        backgroundColor: Colors.black,
        child: Image.asset(
          'assets/img/pingou-logo.png',
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
        Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'E-mail',
                  hintText: 'Digite seu e-mail',
                  prefixIcon: Icon(Icons.email),
                ),
              ),
              const SizedBox(height: 12),
              TextFormField(
                obscureText: true,
                autocorrect: false,
                enableSuggestions: false,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Senha',
                  hintText: 'Digite sua senha',
                  prefixIcon: Icon(Icons.lock),
                ),
              ),
              const SizedBox(height: 16),
              ElevatedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.login),
                label: const Text('Entrar'),
                style: ElevatedButton.styleFrom(
                  foregroundColor: Theme.of(context).colorScheme.onPrimary,
                  backgroundColor: Theme.of(context).colorScheme.primary,
                ),
              ),
            ],
          ),
        ),
        Container(
          margin: const EdgeInsets.symmetric(vertical: 16),
          child: const LabeledDivider(label: 'Não tem uma conta?'),
        ),
        OutlinedButton.icon(
          onPressed: () async =>
              GoRouter.of(context).push('/auth/local/sign-up'),
          icon: const Icon(Icons.person_add),
          label: const Text('Criar conta'),
        ),
      ],
    );
  }
}
