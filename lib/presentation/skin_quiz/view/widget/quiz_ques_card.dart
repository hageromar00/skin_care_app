import 'package:flutter/material.dart';
import 'package:skin_care_app/presentation/skin_quiz/model/skin_quiz_model.dart';
class QuizOptionCard extends StatelessWidget {
  final QuizOptionModel option;
  final VoidCallback onTap;

  const QuizOptionCard({
    super.key,
    required this.option,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final bool selected = option.isSelected;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: selected ? const Color(0xffFFF0F6) : Colors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: selected
                ? const Color(0xffFF5C93)
                : Colors.grey.shade300,
          ),
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                option.text,
                style: TextStyle(
                  color: selected
                      ? const Color(0xffFF5C93)
                      : Colors.black87,
                ),
              ),
            ),

            if (selected)
              const Icon(
                Icons.check,
                color: Color(0xffFF5C93),
              )
          ],
        ),
      ),
    );
  }
}


class QuizNextButton extends StatelessWidget {
  final VoidCallback onPressed;

  const QuizNextButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xffFF5C93),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          padding: const EdgeInsets.symmetric(vertical: 14),
        ),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Next"),
            SizedBox(width: 6),
            Icon(Icons.arrow_forward_ios, size: 16)
          ],
        ),
      ),
    );
  }
}