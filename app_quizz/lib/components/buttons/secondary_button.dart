import 'package:flutter/material.dart';

class SecondaryButton extends StatelessWidget {
  final String? text;
  final Widget? child;
  final VoidCallback onPressed;

  const SecondaryButton({super.key, this.text, this.child, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: OutlinedButton(
        onPressed: onPressed,
        child: child ?? Text(text ?? ''),
      ),
    );
  }
}