import 'package:flutter/material.dart';

class PrimaryButton extends StatelessWidget {
  final String? text;
  final Widget? child;
  final VoidCallback? onPressed;

  const PrimaryButton({super.key, this.text, this.child, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: FilledButton(
        onPressed: onPressed,
        child: child ?? Text(text ?? ''),
      ),
    );
  }
}