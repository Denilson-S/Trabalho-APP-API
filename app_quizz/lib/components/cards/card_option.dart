import 'package:flutter/material.dart';

class CardOption extends StatelessWidget {
  final List<Widget> rows;

  const CardOption({super.key, required this.rows});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: Column(
          spacing: 16,
          children: rows,
        ),
      ),
    );
  }
}
