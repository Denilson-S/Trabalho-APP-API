import 'package:app_quizz/constants/app_styles.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Padding(
          padding: const EdgeInsets.only(left: 32.0, right: 32.0, top: 84.0, bottom: 48.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            spacing: 24,
            children: [
              Container(
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 24,
                      backgroundColor: Color(0xFF7A6EFF),
                      child: Text('L'),
                    ),
                    SizedBox(width: 12),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Hello,', style: AppStyles.caption,),
                        Text('Lucas'),
                      ],
                    )
                  ],
                ),
              ),
              SizedBox(height: 24),
              Container(
                child: Row(
                  spacing: 24,
                  children: [
                    Expanded(child: Card(
                      child: Container(
                        height: 120,
                        child: Center(child: Text('Card 1')),
                      ),
                    )),
                    FilledButton(
                      onPressed: () {Navigator.pushNamed(context, '/');},
                      child: Text('Button 1'),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}