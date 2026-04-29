import 'dart:async';
import 'package:app_quizz/components/widgets.dart';
import 'package:app_quizz/constants/app_styles.dart';
import 'package:app_quizz/pages/view_models/quizz_view_model.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:provider/provider.dart';

class QuizzPage extends StatefulWidget {
  const QuizzPage({super.key});

  @override
  State<QuizzPage> createState() => _QuizzPageState();
}

class _QuizzPageState extends State<QuizzPage> {
  int _currentIndex = 0;
  int _seconds = 60;
  Timer? _timer;
  bool _canNavigate = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final viewModel = context.read<QuizzViewModel>();
      viewModel.fetchQuizzes().then((_) {
        _startTimer();
        viewModel.startQuestionTimer();
      });
    });
  }

  void _startTimer() {
    _timer?.cancel();
    setState(() => _seconds = 60);
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_seconds > 0) {
        setState(() => _seconds--);
      } else {
        _timer?.cancel();
        _nextQuestion();
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _nextQuestion() async {
    final viewModel = context.read<QuizzViewModel>();
    if (_currentIndex < viewModel.quizzes.length - 1) {
      setState(() {
        _currentIndex++;
        _canNavigate = false;
      });
      _startTimer();
      viewModel.startQuestionTimer();
    } else {
      _timer?.cancel();
      await viewModel.saveQuizzHistory();
      if (mounted) {
        Navigator.of(context).pushReplacementNamed('/quizz_result');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<QuizzViewModel>();
    final isLastQuestion = _currentIndex == viewModel.quizzes.length - 1;
    
    return Scaffold(
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Padding(
          padding: const EdgeInsets.only(left: 24.0, right: 24.0, top: 128.0, bottom: 24.0),
          child: viewModel.isLoading 
            ? const Center(child: CircularProgressIndicator())
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 8,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    spacing: 12,
                    children: [
                      CircleButton(icon: LucideIcons.chevronLeft, onPressed: () => viewModel.goBack(context, 3)),
                      Tag(text: viewModel.getTotalScore().toString(), icon: LucideIcons.flame, color: AppColors.primary, backgroundColor: AppColors.avatarBackground)
                    ],
                  ),
                  SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Question ${_currentIndex + 1} of ${viewModel.quizzes.length}', style: AppStyles.caption),
                      Row(
                        children: [
                          Icon(LucideIcons.timer, size: 16.0, color: AppColors.primary),
                          const SizedBox(width: 4.0),
                          Text('${_seconds}s', style: AppStyles.captionActive),
                        ],
                      ),
                    ],
                  ),
                  ProgressBar(
                    progress: viewModel.quizzes.isEmpty ? 0 : (_currentIndex + 1) / viewModel.quizzes.length, 
                    color: AppColors.primary
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    spacing: 8,
                    children: [
                      if (viewModel.selectedCategory != null)
                        Tag(text: viewModel.selectedCategory!, icon: LucideIcons.gamepad2, color: AppColors.white, backgroundColor: AppColors.primary),
                      if (viewModel.selectedLevel != null)
                        Tag(text: viewModel.selectedLevel!, icon: LucideIcons.flame, color: AppColors.white, backgroundColor: AppColors.onError),
                    ],
                  ),
                  SizedBox(height: 4),
                  if (viewModel.quizzes.isNotEmpty) ...[
                    CardOption(
                      rows: [
                        Text(viewModel.quizzes[_currentIndex].question!, style: AppStyles.titleSmall)
                      ],
                    ),
                    ColumnQuestion(
                      key: ValueKey('question_$_currentIndex'),
                      questions: [
                        viewModel.quizzes[_currentIndex].option1!,
                        viewModel.quizzes[_currentIndex].option2!,
                        viewModel.quizzes[_currentIndex].option3!,
                        viewModel.quizzes[_currentIndex].answer!,
                      ], 
                      answer: viewModel.quizzes[_currentIndex].answer!,
                      onOptionSelected: (option, isCorrect) {
                        viewModel.recordAnswer(_currentIndex, option);
                        setState(() => _canNavigate = true);
                      },
                    ),
                  ] else ...[
                    const Center(child: Text('No questions found.')),
                  ],
                  Spacer(),
                  PrimaryButton(
                    onPressed: _canNavigate ? _nextQuestion : null, 
                    child: Text(isLastQuestion ? 'See Result' : 'Next Question')
                  ),
                ],
              ),
        ),
      ),
    );
  }
}