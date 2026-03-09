import 'package:flutter/material.dart';
import 'package:skin_care_app/presentation/tell_yourself/view/widget/custom_down.dart';
import 'package:skin_care_app/presentation/tell_yourself/view/widget/section_tile.dart';
import 'package:skin_care_app/presentation/tell_yourself/view/widget/stress_button.dart';

class CustomCardTwo extends StatefulWidget {
  const CustomCardTwo({super.key});

  @override
  State<CustomCardTwo> createState() => _CustomCardTwoState();
}

class _CustomCardTwoState extends State<CustomCardTwo> {
    String gender = "Female";
  bool pregnant = false;

  String age = "18-25";
  String sleep = "5-6 hours";
  String water = "4-6 glasses";
  String exercise = "Rarely";
  String stress = "Medium";
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: Colors.grey.shade300),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SectionTitle(title: "Lifestyle Factors"),

            const SizedBox(height: 16),

            const Text("Sleep Duration"),

            const SizedBox(height: 6),

            CustomDropdown(
              value: sleep,
              items: const ["5-6 hours", "6-7 hours", "7-8 hours", "8+ hours"],
              onChanged: (v) {
                setState(() {
                  sleep = v!;
                });
              },
            ),

            const SizedBox(height: 12),

            const Text("Water Intake"),

            const SizedBox(height: 6),

            CustomDropdown(
              value: water,
              items: const [
                "2-3 glasses",
                "4-6 glasses",
                "7-9 glasses",
                "10+ glasses",
              ],
              onChanged: (v) {
                setState(() {
                  water = v!;
                });
              },
            ),

            const SizedBox(height: 12),

            const Text("Exercise Frequency"),

            const SizedBox(height: 6),

            CustomDropdown(
              value: exercise,
              items: const ["Never", "Rarely", "Sometimes", "Often"],
              onChanged: (v) {
                setState(() {
                  exercise = v!;
                });
              },
            ),

            const SizedBox(height: 12),

            const Text("Stress Level"),

            const SizedBox(height: 8),

            Row(
              children: [
                Expanded(
                  child: StressButton(
                    title: "Low",
                    selected: stress == "Low",
                    onTap: () {
                      setState(() {
                        stress = "Low";
                      });
                    },
                  ),
                ),

                const SizedBox(width: 10),

                Expanded(
                  child: StressButton(
                    title: "Medium",
                    selected: stress == "Medium",
                    onTap: () {
                      setState(() {
                        stress = "Medium";
                      });
                    },
                  ),
                ),

                const SizedBox(width: 10),

                Expanded(
                  child: StressButton(
                    title: "High",
                    selected: stress == "High",
                    onTap: () {
                      setState(() {
                        stress = "High";
                      });
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
