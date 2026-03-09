import 'package:flutter/material.dart';
import 'package:skin_care_app/presentation/select_skin/model/concern_skin.dart';


class ConcernChip extends StatelessWidget {
  final ConcernModel concern;
  final VoidCallback onTap;

  const ConcernChip({
    super.key,
    required this.concern,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(
          vertical: 12,
          horizontal: 18,
        ),
        decoration: BoxDecoration(
          color: concern.isSelected ? const Color(0xffFF5C93) : Colors.white,
          borderRadius: BorderRadius.circular(30),
          border: Border.all(
            color: const Color(0xffE0E0E0),
          ),
        ),
        child: Text(
          concern.title,
          style: TextStyle(
            color: concern.isSelected ? Colors.white : Colors.black87,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}

class ContinueButton extends StatelessWidget {
  final VoidCallback onPressed;

  const ContinueButton({super.key, required this.onPressed});

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
            Text(
              "Continue",
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(width: 6),
            Icon(Icons.arrow_forward_ios, size: 16)
          ],
        ),
      ),
    );
  }
}