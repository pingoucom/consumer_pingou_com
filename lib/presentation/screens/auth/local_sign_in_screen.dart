import 'package:consumer_pingou_com/infrastructure/providers/authentication_provider.dart';
import 'package:consumer_pingou_com/presentation/components/labeled_divider.dart';
import 'package:consumer_pingou_com/presentation/layouts/bottom_sheet_screen_layout.dart';
import 'package:consumer_pingou_com/support/str.dart';
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

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  String? _errorMessage;

  bool _isSubmitting = false;

  void _submit(BuildContext context) async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() => _isSubmitting = true);

    final authenticationProvider = context.read<AuthenticationProvider>();
    final signedIn = await authenticationProvider.signIn(
      emailController.text,
      passwordController.text,
    );

    if (!context.mounted) {
      return;
    }

    setState(() => _isSubmitting = false);

    if (!signedIn) {
      setState(() => _errorMessage = 'Credenciais inválidas');

      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
            'Boas-vindas, ${firtLetterUpperCase(authenticationProvider.user!.firstName)}!'),
      ),
    );

    GoRouter.of(context).go('/home');
  }

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
        Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: emailController,
                validator: (value) =>
                    value!.isEmpty ? 'Campo obrigatório' : null,
                keyboardType: TextInputType.emailAddress,
                autocorrect: false,
                enableSuggestions: false,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  labelText: 'E-mail',
                  hintText: 'Digite seu e-mail',
                  errorText: _errorMessage,
                  prefixIcon: const Icon(Icons.email),
                ),
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: passwordController,
                validator: (value) =>
                    value!.isEmpty ? 'Campo obrigatório' : null,
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
                onPressed: !_isSubmitting ? () => _submit(context) : null,
                icon: !_isSubmitting
                    ? const SizedBox(
                        height: 16,
                        width: 16,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Icon(Icons.check),
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
