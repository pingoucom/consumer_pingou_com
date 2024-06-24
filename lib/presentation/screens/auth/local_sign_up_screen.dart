import 'package:consumer_pingou_com/infrastructure/providers/authentication_provider.dart';
import 'package:consumer_pingou_com/presentation/components/labeled_divider.dart';
import 'package:consumer_pingou_com/presentation/layouts/bottom_sheet_screen_layout.dart';
import 'package:consumer_pingou_com/support/str.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:provider/provider.dart';

class LocalSignUpScreen extends StatefulWidget {
  const LocalSignUpScreen({super.key});

  @override
  State<LocalSignUpScreen> createState() => _LocalSignUpScreenState();
}

class _LocalSignUpScreenState extends State<LocalSignUpScreen> {
  final _formKey = GlobalKey<FormState>();

  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final birthDateController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  bool _isSubmitting = false;

  void _submit(BuildContext context) async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() => _isSubmitting = true);

    final authenticationProvider = context.read<AuthenticationProvider>();
    final signedIn = await authenticationProvider.signUp(
      nameController.text,
      emailController.text,
      passwordController.text,
      phoneController.text,
      DateFormat.yMMMEd('pt_BR').parse(birthDateController.text),
    );

    if (!context.mounted) {
      return;
    }

    setState(() => _isSubmitting = false);

    if (!signedIn) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Erro ao cadastrar usuário'),
        ),
      );

      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
            'Boas-vindas, ${firtLetterUpperCase(authenticationProvider.user!.firstName)}!'),
      ),
    );

    GoRouter.of(context).push('/onboarding/plan');
  }

  void _selectBirthDate() async {
    final lastDate = DateTime(
        DateTime.now().year - 18, DateTime.now().month, DateTime.now().day);

    final selectedDate = await showDatePicker(
      context: context,
      initialDate: lastDate,
      firstDate: DateTime(1900),
      lastDate: lastDate,
    );

    if (selectedDate != null) {
      birthDateController.text =
          DateFormat.yMMMEd('pt_BR').format(selectedDate);
    }
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
                controller: nameController,
                validator: (value) =>
                    value!.isEmpty ? 'Campo obrigatório' : null,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Nome',
                  hintText: 'Digite seu nome',
                  prefixIcon: Icon(Icons.person),
                ),
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: phoneController,
                validator: (value) =>
                    value!.isEmpty ? 'Campo obrigatório' : null,
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Telefone',
                  hintText: 'Digite seu telefone',
                  prefixIcon: Icon(Icons.phone),
                ),
                inputFormatters: [
                  MaskTextInputFormatter(
                    mask: '(##) #####-####',
                    filter: {'#': RegExp(r'[0-9]')},
                    type: MaskAutoCompletionType.lazy,
                  ),
                ],
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: birthDateController,
                validator: (value) =>
                    value!.isEmpty ? 'Campo obrigatório' : null,
                onTap: _selectBirthDate,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Data de nascimento',
                  hintText: 'Insira sua data de nascimento',
                  prefixIcon: Icon(Icons.calendar_today),
                ),
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: emailController,
                validator: (value) =>
                    value!.isEmpty ? 'Campo obrigatório' : null,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'E-mail',
                  hintText: 'Digite seu e-mail',
                  prefixIcon: Icon(Icons.email),
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
                onPressed: _isSubmitting ? null : () => _submit(context),
                icon: _isSubmitting
                    ? const SizedBox(
                        height: 16,
                        width: 16,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Icon(Icons.person_add),
                label: const Text('Cadastrar'),
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
          child: const LabeledDivider(label: 'Já tem uma conta?'),
        ),
        OutlinedButton.icon(
          onPressed: () => GoRouter.of(context).push('/auth/local/sign-in'),
          icon: const Icon(Icons.login),
          label: const Text('Entrar'),
        ),
      ],
    );
  }
}
