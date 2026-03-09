import 'package:flutter/material.dart';
import 'package:skin_care_app/core/utils/custom_button.dart';
import 'package:skin_care_app/presentation/skin_quiz/model/skin_quiz_model.dart';
import 'package:skin_care_app/presentation/skin_quiz/view/widget/quiz_progress.dart';
import 'package:skin_care_app/presentation/skin_quiz/view/widget/quiz_ques_card.dart';

class SkinQuizScreen extends StatefulWidget {
  const SkinQuizScreen({super.key});

  @override
  State<SkinQuizScreen> createState() => _SkinQuizScreenState();
}

class _SkinQuizScreenState extends State<SkinQuizScreen> {
  int selectedIndex = -1;

  final List<QuizOptionModel> options = [
    QuizOptionModel(
      text: "I adapt quickly and find new ways to proceed without much fuss.",
    ),
    QuizOptionModel(
      text:
          "I feel a bit stressed and prefer to stick closely to my original plan.",
    ),
    QuizOptionModel(
      text: "I can feel overwhelmed and need some time to process and adjust.",
    ),
    QuizOptionModel(
      text:
          "I usually rely on others to guide me through changes or new situations.",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Icon(Icons.arrow_back_ios),
                  ),
                  Text(
                    "Skin quiz",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Icon(Icons.close),
                ],
              ),

              const SizedBox(height: 20),

              const QuizProgress(progress: .5, stepText: "5/10"),

              const SizedBox(height: 25),

              const Text(
                "How do you typically react to unexpected changes in your daily routine or plans?",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 6),

              const Text("(select one)", style: TextStyle(color: Colors.grey)),

              const SizedBox(height: 20),

              /// هنا الاسكرول
              Expanded(
                child: ListView.builder(
                  itemCount: options.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: QuizOptionCard(
                        option: options[index],
                        onTap: () {
                          setState(() {
                            selectedIndex = index;

                            for (var element in options) {
                              element.isSelected = false;
                            }

                            options[index].isSelected = true;
                          });
                        },
                      ),
                    );
                  },
                ),
              ),

              CustomButton(
                onPressed: () {},
                text: 'Next',
                icon: Icons.arrow_forward_ios,
              ),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
