import 'package:flutter/material.dart';

class QuizProgress extends StatelessWidget {
  final double progress;
  final String stepText;

  const QuizProgress({
    super.key,
    required this.progress,
    required this.stepText,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: LinearProgressIndicator(
              value: progress,
              minHeight: 6,
              backgroundColor: Colors.grey.shade300,
              valueColor: const AlwaysStoppedAnimation(
                Color(0xffFF5C93),
              ),
            ),
          ),
        ),
        const SizedBox(width: 10),
        Text(stepText)
      ],
    );
  }
}