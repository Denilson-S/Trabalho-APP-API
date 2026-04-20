import 'package:flutter/material.dart';

class RowCards extends StatelessWidget {
  final List<Widget> cards;
  const RowCards({super.key, required this.cards});

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 8,
      children: [
        ...cards,
      ],
    );
  }
}