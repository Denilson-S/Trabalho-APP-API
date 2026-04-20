import 'package:app_quizz/components/cards/card_select.dart';
import 'package:flutter/material.dart';

class ColumnQuestion extends StatefulWidget {
  final List<String> questions;
  final String answer;

  const ColumnQuestion({super.key, required this.questions, required this.answer});

  @override
  State<ColumnQuestion> createState() => _ColumnQuestionState();
}

class _ColumnQuestionState extends State<ColumnQuestion> {
  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 8,
      children: [
        CardSelect(latter: 'A', text: 'CJ', isCorrect: true,),
        CardSelect(latter: 'B', text: 'Tommy Vercetti', isCorrect: false,),
        CardSelect(latter: 'C', text: 'Niko Bellic', isCorrect: false,),
        CardSelect(latter: 'D', text: 'Claude', isCorrect: false,),
      ],
    );
  }
}