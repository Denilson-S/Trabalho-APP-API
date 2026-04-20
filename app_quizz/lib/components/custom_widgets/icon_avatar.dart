import 'package:flutter/material.dart';

class IconAvatar extends StatelessWidget {
  final IconData icon;
  final Color colorIcon;
  final Color colorBackground;
  final double radius;
  final double iconSize;

  const IconAvatar({super.key, required this.icon, required this.colorIcon, required this.colorBackground, this.radius = 24.0, this.iconSize = 24.0});

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: radius,
      backgroundColor: colorBackground,
      child: Icon(
        icon,
        color: colorIcon,
        size: iconSize,
      ),
    );
  }
}