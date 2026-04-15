import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SimpleInput extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final IconData prefixIcon;
  final FormFieldValidator<String>? validator;
  final TextInputFormatter? inputFormatter;
  final TextInputType keyboardType;

  const SimpleInput({
    super.key,
    required this.controller,
    required this.hintText,
    required this.prefixIcon,
    required this.keyboardType,
    this.validator,
    this.inputFormatter,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        hintText: hintText,
        prefixIcon: Icon(prefixIcon, size: 20),
      ),
      validator: validator,
      inputFormatters: inputFormatter != null ? [inputFormatter!] : null,
      textAlign: TextAlign.left,
      keyboardType: keyboardType,
    );
  }
}