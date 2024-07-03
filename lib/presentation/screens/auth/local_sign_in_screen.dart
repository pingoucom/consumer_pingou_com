import 'package:consumer_pingou_com/infrastructure/providers/authentication_provider.dart';
import 'package:consumer_pingou_com/presentation/components/labeled_divider.dart';
import 'package:consumer_pingou_com/presentation/layouts/bottom_sheet_screen_layout.dart';
import 'package:consumer_pingou_com/presentation/validators/validator.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class LocalSignInScreen extends StatefulWidget {
  const LocalSignInScreen({super.key});

  @override
  State<LocalSignInScreen> createState() => _LocalSignInScreenState();
}

class _LocalSignInScreenState extends State<LocalSignInScreen> {
  final _formKey = GlobalKey<FormState>();

  final _emailController = TextEditingController();

  final _passwordController = TextEditingController();

  bool _isSubmitting = false;

  void _submit() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isSubmitting = true);

    final authenticationProvider = context.read<AuthenticationProvider>();
    final signedIn = await authenticationProvider.signIn(
      _emailController.text,
      _passwordController.text,
    );

    setState(() => _isSubmitting = false);

    if (!signedIn) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('E-mail ou senha inválidos'),
          backgroundColor: Colors.red,
        ),
      );

      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Boas-vindas!'),
        backgroundColor: Colors.green,
      ),
    );

    GoRouter.of(context).go('/home');
  }

  @override
  Widget build(BuildContext context) {
    return BottomSheetScreenLayout(
      icon: Image.asset(
        'assets/img/logo.png',
        height: 64,
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
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                validator: Validator.all([
                  Validator.required(),
                  Validator.email(),
                ]),
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'E-mail',
                  hintText: 'Digite seu e-mail',
                  prefixIcon: Icon(Icons.email),
                ),
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _passwordController,
                validator: Validator.all([
                  Validator.required(),
                  Validator.minLength(6),
                ]),
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
                onPressed: _isSubmitting ? null : _submit,
                icon: _isSubmitting
                    ? const SizedBox(
                        height: 16,
                        width: 16,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Icon(Icons.login),
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
          onPressed: () => GoRouter.of(context).push('/auth/local/sign-up'),
          icon: const Icon(Icons.person_add),
          label: const Text('Criar conta'),
        ),
      ],
    );
  }
}
