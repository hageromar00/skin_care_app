import 'package:flutter/material.dart';

class CustomText1 extends StatelessWidget {
  const CustomText1({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(children: [
         const Text(
                  "Tell Us About Yourself",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 6),
                const Text(
                  "This helps us personalize your experience",
                  style: TextStyle(color: Colors.grey),
                ),
                const SizedBox(height: 20),
    ],);
  }
}