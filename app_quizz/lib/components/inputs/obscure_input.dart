import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ObscureInput extends StatelessWidget {
  final String hintText;
  final bool isObscure;
  final IconData prefixIcon;
  final IconData suffixIcon;
  final TextEditingController controller;
  final FormFieldValidator<String>? validator;
  final TextInputFormatter? inputFormatter;
  final VoidCallback? onToggle;
  final TextInputType keyboardType;

  const ObscureInput({
    super.key,
    required this.controller,
    required this.hintText,
    required this.prefixIcon,
    required this.suffixIcon,
    required this.keyboardType,
    this.validator,
    this.inputFormatter,
    this.isObscure = true,
    this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        hintText: hintText,
        prefixIcon: Icon(prefixIcon, size: 20),
        suffixIcon: IconButton(
          icon: Icon(suffixIcon, size: 20),
          onPressed: onToggle,
        ),
      ),
      validator: validator,
      inputFormatters: inputFormatter != null ? [inputFormatter!] : null,
      textAlign: TextAlign.left,
      obscureText: isObscure,
      keyboardType: keyboardType,
    );
  }
}