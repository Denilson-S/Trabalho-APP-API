import 'package:app_quizz/constants/app_styles.dart';
import 'package:app_quizz/pages/view_models/login_view_model.dart';
import 'package:app_quizz/services/auth_service.dart';
import 'package:app_quizz/storages/user_storage.dart';
import 'package:flutter/material.dart';
import 'package:app_quizz/validators/validators.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:app_quizz/components/widgets.dart';
import 'package:provider/provider.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => RegisterPageState();
}

class RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final UserStorage _userStorage = UserStorage();
  final AuthService _authService = AuthService();

  @override
  void dispose() {
    context.read<LoginViewModel>().dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => LoginViewModel(context, _authService, _userStorage),
      child: Builder(
        builder: (context) {
          final viewModel = context.watch<LoginViewModel>();
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
                        reverse: true,
                        padding: const EdgeInsets.only(left: 24.0, right: 24.0, bottom: 24.0),
                        child: CardLogin(
                          title: 'Register',
                          formKey: _formKey,
                          children: [
                            SimpleInput(controller: viewModel.nameController, hintText: 'Name', prefixIcon: LucideIcons.user, keyboardType: TextInputType.name, validator: validateName),
                            SimpleInput(controller: viewModel.emailController, keyboardType: TextInputType.emailAddress, hintText: 'Email', prefixIcon: LucideIcons.mail, validator: validateEmail),
                            ObscureInput(controller: viewModel.passwordController, keyboardType: TextInputType.visiblePassword, hintText: 'Password', prefixIcon: LucideIcons.lock, validator: validatePassword, suffixIcon: viewModel.isObscure ? LucideIcons.eye : LucideIcons.eyeOff, isObscure: viewModel.isObscure, onToggle: viewModel.togglePasswordVisibility),
                            PrimaryButton(onPressed: () => viewModel.register(context, _formKey), text: 'Create Account',),
                            CustomDivider(text: 'or login with'),
                            SecondaryButton(onPressed: () => viewModel.googleLogin(context), child: SvgText(path: 'assets/svgs/logo_google.svg', text: 'Google')),
                            ActionText(simpleText: 'Already have an account? ', actionText: 'Login', onPressed: () => viewModel.navigateToLogin(context))
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
      ),
    );
  }
}