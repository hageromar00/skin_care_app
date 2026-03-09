import 'package:flutter/material.dart';
import 'package:skin_care_app/presentation/tell_yourself/view/widget/age_button.dart';
import 'package:skin_care_app/presentation/tell_yourself/view/widget/section_tile.dart';
import 'package:skin_care_app/presentation/tell_yourself/view/widget/select_button.dart';

class CustomCardOne extends StatefulWidget {
  const CustomCardOne({super.key});

  @override
  State<CustomCardOne> createState() => _CustomCardOneState();
}

class _CustomCardOneState extends State<CustomCardOne> {
    String gender = "Female";
  bool pregnant = false;

  String age = "18-25";
  String sleep = "5-6 hours";
  String water = "4-6 glasses";
  String exercise = "Rarely";
  String stress = "Medium";
  @override
  Widget build(BuildContext context) {
    return     Card(
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
                        const SectionTitle(title: "Basic Information"),
                        const SizedBox(height: 16),
                        const Text("Gender"),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            Expanded(
                              child: SelectButton(
                                title: "Male",
                                selected: gender == "Male",
                                onTap: (){
                                  setState(() {
                                    gender = "Male";
                                  });
                                },
                              ),
                            ),

                            const SizedBox(width: 10),

                            Expanded(
                              child: SelectButton(
                                title: "Female",
                                selected: gender == "Female",
                                onTap: (){
                                  setState(() {
                                    gender = "Female";
                                  });
                                },
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 10),

                        Row(
                          children: [

                            Checkbox(
                              value: pregnant,
                              onChanged: (v){
                                setState(() {
                                  pregnant = v!;
                                });
                              },
                            ),

                            const Expanded(
                              child: Text(
                                "I am currently pregnant or breastfeeding",
                              ),
                            )

                          ],
                        ),

                        const SizedBox(height: 10),

                        const Text("Age"),

                        const SizedBox(height: 8),

                        Wrap(
                          spacing: 10,
                          runSpacing: 10,
                          children: [

                            AgeButton(
                              title: "18-25",
                              selected: age == "18-25",
                              onTap: (){
                                setState(() {
                                  age = "18-25";
                                });
                              },
                            ),

                            AgeButton(
                              title: "26-35",
                              selected: age == "26-35",
                              onTap: (){
                                setState(() {
                                  age = "26-35";
                                });
                              },
                            ),

                            AgeButton(
                              title: "36-45",
                              selected: age == "36-45",
                              onTap: (){
                                setState(() {
                                  age = "36-45";
                                });
                              },
                            ),

                            AgeButton(
                              title: "46+",
                              selected: age == "46+",
                              onTap: (){
                                setState(() {
                                  age = "46+";
                                });
                              },
                            ),
                          ],
                        ),

                      ],
                    ),
                  ),
                );
  }
}