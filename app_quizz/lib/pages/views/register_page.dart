import 'package:app_quizz/constants/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:app_quizz/validators/validators.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:app_quizz/components/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => RegisterPageState();
}

class RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _isObscure = true;

  void _login() {
    if (_formKey.currentState!.validate()) {
      // Implemente a lógica de login aqui
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Login realizado!')),
      );
    }
  }

  void _googleLogin() {
    // Implemente a lógica de login com o Google aqui
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Login com Google realizado!')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Padding(
          padding: const EdgeInsets.only(left: 24.0, right: 24.0, top: 128.0, bottom: 48.0),
          child: Column(
            children: [
              Text('Quiz Master', style: AppStyles.titleLarge),
              Text('Test your knowledge and challenge your friends.', style: AppStyles.caption),
              const Spacer(),
              Card(
                child: SingleChildScrollView(
                  child: Container(
                    padding: EdgeInsets.all(16),
                    child: Column(
                      children: [
                        Text('Register', style: AppStyles.titleMedium),
                        Padding(
                          padding: const EdgeInsets.only(top: 40, bottom: 16, left: 16, right: 16),
                          child: Form(
                            key: _formKey,
                            child: Column(
                              children: [
                                TextFormField(
                                  controller: _nameController,
                                  decoration: const InputDecoration(hintText: 'Name', prefixIcon: Icon(LucideIcons.user)),
                                  validator: validateName,
                                ),
                                SizedBox(height: 12),
                                TextFormField(
                                  controller: _emailController,
                                  decoration: const InputDecoration(hintText: 'Email', prefixIcon: Icon(LucideIcons.mail)),
                                  keyboardType: TextInputType.emailAddress,
                                  validator: validateEmail,
                                ),
                                SizedBox(height: 12),
                                TextFormField(
                                  controller: _passwordController,
                                  decoration: InputDecoration(
                                    hintText: 'Senha',
                                    prefixIcon: Icon(LucideIcons.lock),
                                    suffixIcon: Icon(
                                      _isObscure ? LucideIcons.eye : LucideIcons.eyeOff,
                                    ),
                                  ),
                                  obscureText: _isObscure,
                                  validator: validatePassword,
                                ),
                                const SizedBox(height: 16.0),
                                SizedBox(
                                  width: double.infinity,
                                  child: FilledButton(
                                    onPressed: _login,
                                    child: const Text('Create Account'),
                                  ),
                                ),
                                SizedBox(height: 8),
                                CustomDivider(text: 'or login with'),
                                const SizedBox(height: 8),
                                SizedBox(
                                  width: double.infinity,
                                  child: OutlinedButton(
                                    onPressed: _googleLogin,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        SvgPicture.asset(
                                          'assets/svgs/logo_google.svg',
                                          height: 24.0,
                                          width: 24.0,
                                        ),
                                        const SizedBox(width: 8),
                                        Text('Google', style: AppStyles.googleButton),
                                      ],
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 12),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text('Already have an account? ', style: AppStyles.caption,),
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.pushNamed(context, '/');
                                      },
                                      child: Text('Login', style: AppStyles.captionActive,),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}