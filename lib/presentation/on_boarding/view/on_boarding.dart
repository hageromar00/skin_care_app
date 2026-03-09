import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:skin_care_app/core/utils/routers.dart';
import 'package:skin_care_app/presentation/auth/view/create_account.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const primaryPink = Color(0xFFE91E63);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              flex: 6,
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
                child: Image.network(
                  "https://media.istockphoto.com/id/1272479912/photo/close-up-portrait-of-young-and-beautiful-woman.jpg?s=612x612&w=0&k=20&c=2sR8vedKCijWux6TFpT6YoZeDDeyaqPt0_ZCrOzAzJg=",
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
              ),
            ),
            const SizedBox(height: 20),
     Padding(
  padding: const EdgeInsets.symmetric(horizontal: 30),
  child: Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: const [
      Align(
        alignment: Alignment.centerLeft,
        child: Text(
          "Personalized",
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      SizedBox(height: 4),
      Align(
        alignment: Alignment.center,
        child: Text(
          "AI-Powered",
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      SizedBox(height: 4),
      Align(
        alignment: Alignment.centerRight,
        child: Text(
          "Skincare Journey",
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    ],
  ),
),
            const SizedBox(height: 25),
Padding(
  padding: const EdgeInsets.symmetric(horizontal: 30),
  child: GestureDetector(
    onTap: () {
     GoRouter.of(context).push(AppRouter.kaccount);
    },
    child: Container(
      height: 60,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(35),
        border: Border.all(
          color: Colors.grey.shade300,
          width: 1.2,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade200,
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            "Get Started",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Colors.black,
            ),
          ),
          Container(
            height: 40,
            width: 40,
            decoration: const BoxDecoration(
              color: Color(0xFFE91E63),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.arrow_forward,
              color: Colors.white,
              size: 20,
            ),
          ),
        ],
      ),
    ),
  ),
),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
