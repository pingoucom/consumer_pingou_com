import 'package:consumer_pingou_com/components/labeled_divider.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

const double _bottomSheetHeight = 425;

class LocalSignUp extends StatefulWidget {
  const LocalSignUp({super.key});

  @override
  LocalSignUpState createState() => LocalSignUpState();
}

class LocalSignUpState extends State<LocalSignUp> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      body: SizedBox(
        height: MediaQuery.of(context).size.height -
            _bottomSheetHeight -
            MediaQuery.of(context).viewInsets.bottom,
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
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
        height: _bottomSheetHeight,
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Form(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    TextFormField(
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Nome',
                        hintText: 'Digite seu nome',
                        prefixIcon: Icon(Icons.person),
                      ),
                    ),
                    const SizedBox(height: 12),
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
                      icon: const Icon(Icons.person_add),
                      label: const Text('Cadastrar'),
                      style: ElevatedButton.styleFrom(
                        foregroundColor:
                            Theme.of(context).colorScheme.onPrimary,
                        backgroundColor: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 16),
                child: const LabeledDivider(label: 'Já tem conta?'),
              ),
              OutlinedButton.icon(
                onPressed: () => GoRouter.of(context).go('/auth/local-sign-in'),
                icon: const Icon(Icons.login),
                label: const Text('Entrar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
