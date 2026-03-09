import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:skin_care_app/core/utils/custom_button.dart';
import 'package:skin_care_app/core/utils/routers.dart';
import 'package:skin_care_app/presentation/skin_type/view/widget/skin_type_card.dart';
import '../model/skin_type_model.dart';


class SkinTypeScreen extends StatefulWidget {
  const SkinTypeScreen({super.key});

  @override
  State<SkinTypeScreen> createState() => _SkinTypeScreenState();
}

class _SkinTypeScreenState extends State<SkinTypeScreen> {

  int selectedIndex = -1;

  final List<SkinTypeModel> skinTypes = [

    SkinTypeModel(
      title: "Normal",
      description: "Has barely visible pores, looks hydrated",
      image: "assets/image/normal.png",
    ),

    SkinTypeModel(
      title: "Dry",
      description: "Feels tight, might be flaky",
      image: "assets/image/dry.png",
    ),

    SkinTypeModel(
      title: "Oily",
      description: "Has large pores and an overall shine",
      image: "assets/image/normal.png",
    ),

    SkinTypeModel(
      title: "Combination",
      description: "Has large pores and an oily T-zone",
      image: "assets/image/dry.png",
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

              const SizedBox(height: 20),

              const Text(
                "What's Your Skin Type?",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 8),

              const Text(
                "Choose the option that best describes your skin",
                style: TextStyle(color: Colors.grey),
              ),

              const SizedBox(height: 30),

              GridView.builder(
                shrinkWrap: true,
                itemCount: skinTypes.length,
                gridDelegate:
                    const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: .95,
                ),
                itemBuilder: (context, index) {
                  return SkinTypeCard(
                    skinType: skinTypes[index],
                    onTap: () {
                      setState(() {
                        selectedIndex = index;

                        for (var element in skinTypes) {
                          element.isSelected = false;
                        }

                        skinTypes[index].isSelected = true;
                      });
                    },
                  );
                },
              ),

              const SizedBox(height: 25),

              OutlinedButton(
                onPressed: () {},
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: Color(0xffFF5C93)),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: GestureDetector(
                  onTap: () {
                    GoRouter.of(context).push(AppRouter.kquiz);
                  },
                  child: const Padding(
                    padding: EdgeInsets.symmetric(vertical: 5),
                    child: Center(
                      child: Text(
                        "Not sure? Take our skin type quiz     >",
                        style: TextStyle(color: Color(0xffFF5C93)),
                      ),
                    ),
                  ),
                ),
              ),
              const Spacer(),
           CustomButton(onPressed: (){
            GoRouter.of(context).push(AppRouter.kskincorn);
           }, text: 'Continue',icon: Icons.arrow_forward_ios,),
               const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}