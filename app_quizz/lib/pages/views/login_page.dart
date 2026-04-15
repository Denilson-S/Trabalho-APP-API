import 'package:app_quizz/constants/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:app_quizz/validators/validators.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:app_quizz/components/widgets.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _isObscure = true;
  void _togglePasswordVisibility() {
    setState(() {
      _isObscure = !_isObscure;
    });
  }

  void _login() {
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Login realizado!')),
      );
      Navigator.pushNamed(context, '/home');
    }
  }

  void _googleLogin() {
    // Implemente a lógica de login com o Google aqui
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Login com Google realizado!')),
    );
  }


  void _navigateToRegister() {
    Navigator.pushNamed(context, '/register');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 24.0, right: 24.0, top: 128.0, bottom: 48.0),
              child: Column(
                children: [
                  Text('Quiz Master', style: AppStyles.titleLarge),
                  Text('Test your knowledge and challenge your friends.', style: AppStyles.caption, textAlign: TextAlign.center),
                ],
              ),
            ),
            Expanded(
              child: ScrollConfiguration(
                behavior: ScrollConfiguration.of(context).copyWith(overscroll: false),
                child: SingleChildScrollView(
                  physics: const ClampingScrollPhysics(),
                  padding: const EdgeInsets.only(left: 24.0, right: 24.0, top: 156.0, bottom: 24.0),
                  child: CardLogin(
                    title: 'Login',
                    formKey: _formKey,
                    children: [
                      SimpleInput(controller: _emailController, keyboardType: TextInputType.emailAddress, hintText: 'Email', prefixIcon: LucideIcons.mail, validator: validateEmail),
                      ObscureInput(controller: _passwordController, keyboardType: TextInputType.visiblePassword, hintText: 'Password', prefixIcon: LucideIcons.lock, validator: validatePassword, suffixIcon: _isObscure ? LucideIcons.eye : LucideIcons.eyeOff, isObscure: _isObscure, onToggle: _togglePasswordVisibility),
                      PrimaryButton(onPressed: _login, text: 'Sign In',),
                      CustomDivider(text: 'or login with'),
                      SecondaryButton(onPressed: _googleLogin, child: SvgText(path: 'assets/svgs/logo_google.svg', text: 'Google')),
                      ActionText(simpleText: 'Don\'t have an account? ', actionText: 'Register', onPressed: _navigateToRegister)
                    ]
                  ),
                )
              )
            )
          ],
        ),
      ),
    );
  }
}