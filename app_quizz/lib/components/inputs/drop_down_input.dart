import 'package:flutter/material.dart';

class DropDownInput extends StatelessWidget {
  final List<String> options;
  final ValueChanged<String?> onChange;

  const DropDownInput({super.key, required this.options, required this.onChange});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: DropdownButtonFormField(
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          contentPadding: EdgeInsets.symmetric(horizontal: 12 , vertical: 8),
        ),
        isExpanded: true,
        initialValue: options.first,
        items: options.map((option) {
          return DropdownMenuItem(
            value: option,
            child: Text(option),
          );
        }).toList(),
        onChanged: onChange,
      ),
    );
  }
}