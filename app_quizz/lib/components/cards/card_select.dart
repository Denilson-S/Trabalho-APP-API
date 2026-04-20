import 'package:app_quizz/components/custom_widgets/icon_avatar.dart';
import 'package:app_quizz/constants/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';

class CardSelect extends StatefulWidget {
  final String latter;
  final String text;
  final bool isCorrect;
  final VoidCallback? onTap;

  const CardSelect({super.key, required this.latter, required this.text, required this.isCorrect, this.onTap});

  @override
  State<CardSelect> createState() => _CardSelectState();
}

class _CardSelectState extends State<CardSelect> {
  var isSelected = false;

  @override
  Widget build(BuildContext context) {

    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(32),
        side: BorderSide(
          color: isSelected 
              ? (!widget.isCorrect ? AppColors.onError : AppColors.green) 
              : Colors.transparent, 
          width: 2.0,
        ),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(32),
        onTap: widget.onTap ?? () {
          setState(() {
            isSelected = !isSelected;
          });
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          child: Row(
            children: [
              isSelected 
                  ? (!widget.isCorrect 
                      ? IconAvatar(icon: LucideIcons.xCircle, colorIcon: AppColors.white, colorBackground: AppColors.onError, radius: 16.0, iconSize: 20.0) 
                      : IconAvatar(icon: LucideIcons.checkCircle2, colorIcon: AppColors.white, colorBackground: AppColors.green, radius: 16.0, iconSize: 20.0)) 
                  : Container(padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 6.0), child: Text(widget.latter, style: AppStyles.caption.copyWith(fontWeight: FontWeight.bold))),
              const SizedBox(width: 8.0),
              Text(widget.text, style: AppStyles.caption),
            ],
          ),
        ),
      ),
    );
  }
}