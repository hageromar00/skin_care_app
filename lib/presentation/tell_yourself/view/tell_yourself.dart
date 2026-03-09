import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:skin_care_app/core/utils/custom_button.dart';
import 'package:skin_care_app/core/utils/routers.dart';
import 'package:skin_care_app/presentation/tell_yourself/view/widget/custom_card_one.dart';
import 'package:skin_care_app/presentation/tell_yourself/view/widget/custom_card_two.dart';
import 'package:skin_care_app/presentation/tell_yourself/view/widget/custom_text.dart';

class AboutYourselfScreen extends StatelessWidget {
  const AboutYourselfScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                CustomText1(),

                CustomCardOne(),
                const SizedBox(height: 20),

                /// CARD 2
                const SizedBox(height: 30),
                CustomCardTwo(),

                const SizedBox(height: 30),

                CustomButton(
                  text: "Continue",
                  onPressed: () {
                    GoRouter.of(context).push(AppRouter.kskintype);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
