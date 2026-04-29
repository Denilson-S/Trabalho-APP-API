import 'package:app_quizz/components/cards/card_select.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ColumnQuestion extends StatefulWidget {
  final List<String> questions;
  final String answer;
  final Function(String option, bool isCorrect)? onOptionSelected;

  const ColumnQuestion({
    super.key, 
    required this.questions, 
    required this.answer,
    this.onOptionSelected,
  });

  @override
  State<ColumnQuestion> createState() => _ColumnQuestionState();
}

class _ColumnQuestionState extends State<ColumnQuestion> {
  final List<String> letters = ['A', 'B', 'C', 'D', 'E'];
  late List<String> shuffledQuestions;
  String? selectedOption;
  bool hasSelected = false;

  @override
  void initState() {
    super.initState();
    shuffledQuestions = List.from(widget.questions)..shuffle();
  }

  @override
  void didUpdateWidget(ColumnQuestion oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Compara o conteúdo das listas em vez da referência
    if (!listEquals(oldWidget.questions, widget.questions)) {
      shuffledQuestions = List.from(widget.questions)..shuffle();
      selectedOption = null;
      hasSelected = false;
    }
  }

  void handleSelection(String option) {
    if (hasSelected) return;

    setState(() {
      selectedOption = option;
      hasSelected = true;
    });

    if (widget.onOptionSelected != null) {
      widget.onOptionSelected!(option, option == widget.answer);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 8,
      children: List.generate(shuffledQuestions.length, (index) {
        final optionText = shuffledQuestions[index];
        final isCorrect = optionText == widget.answer;
        
        bool isSelected = (optionText == selectedOption) || 
                         (hasSelected && isCorrect && selectedOption != widget.answer);

        return CardSelect(
          key: ValueKey(optionText),
          latter: letters[index % letters.length],
          text: optionText,
          isCorrect: isCorrect,
          isSelected: isSelected,
          onTap: () => handleSelection(optionText),
        );
      }),
    );
  }
}