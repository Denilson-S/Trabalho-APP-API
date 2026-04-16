import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Color.fromARGB(255, 5, 121, 121),
      leading: Icon(Icons.draw_outlined),
      title: Text('dvdvv'),
    );
  }
}