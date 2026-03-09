import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:skin_care_app/core/utils/custom_button.dart';
import 'package:skin_care_app/core/utils/routers.dart';
import 'package:skin_care_app/presentation/select_skin/model/concern_skin.dart';
import 'package:skin_care_app/presentation/select_skin/view/widget/concern_chip.dart';


class SkinConcernsScreen extends StatefulWidget {
  const SkinConcernsScreen({super.key});

  @override
  State<SkinConcernsScreen> createState() => _SkinConcernsScreenState();
}

class _SkinConcernsScreenState extends State<SkinConcernsScreen> {

  final List<ConcernModel> concerns = [
    ConcernModel(title: "Acne"),
    ConcernModel(title: "Dryness"),
    ConcernModel(title: "Wrinkles"),
    ConcernModel(title: "Redness"),
    ConcernModel(title: "Dark Spots"),
    ConcernModel(title: "Dark Circles"),
    ConcernModel(title: "Uneven Texture"),
    ConcernModel(title: "Large Pores"),
    ConcernModel(title: "Fine Lines"),
    ConcernModel(title: "Oiliness"),
    ConcernModel(title: "Blackheads"),
    ConcernModel(title: "Eczema"),
    ConcernModel(title: "Whiteheads"),
    ConcernModel(title: "Itchy"),
    ConcernModel(title: "Tight"),
    ConcernModel(title: "Acne Marks"),
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

              const SizedBox(height: 20),

              const Text(
                "Select Your Skin Concerns",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 6),

              const Text(
                "Choose all that apply",
                style: TextStyle(
                  color: Colors.grey,
                ),
              ),

              const SizedBox(height: 25),

              Expanded(
                child: Wrap(
                  spacing: 10,
                  runSpacing: 12,
                  children: List.generate(
                    concerns.length,
                    (index) => ConcernChip(
                      concern: concerns[index],
                      onTap: () {
                        setState(() {
                          concerns[index].isSelected =
                              !concerns[index].isSelected;
                        });
                      },
                    ),
                  ),
                ),
              ),

             CustomButton(onPressed: (){
              GoRouter.of(context).push(AppRouter.kreviewprofile);
             }, text: 'Continue',icon: Icons.arrow_forward_ios,),

              const SizedBox(height: 20),

            ],
          ),
        ),
      ),
    );
  }
}