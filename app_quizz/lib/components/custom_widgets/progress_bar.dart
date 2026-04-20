import 'package:flutter/material.dart';

class ProgressBar extends StatelessWidget {
  final double progress; // Valor entre 0.0 e 1.0
  final Color color;
  final Color trackColor;
  final double height;

  const ProgressBar({
    super.key,
    required this.progress,
    this.color = const Color(0xFF00C48C),
    this.trackColor = const Color(0xFF2A2A38),
    this.height = 10.0,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10.0),
            child: LinearProgressIndicator(
              value: progress,
              backgroundColor: trackColor,
              valueColor: AlwaysStoppedAnimation<Color>(color),
              minHeight: height,
            ),
          ),
        ),
        const SizedBox(width: 16),
        Text(
          '${(progress * 100).toInt()}%',
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}