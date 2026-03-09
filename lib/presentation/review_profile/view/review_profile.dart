import 'package:flutter/material.dart';
import 'package:skin_care_app/core/utils/custom_button.dart';

class ReviewProfileScreen extends StatelessWidget {
  const ReviewProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF6F6F6),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: const Icon(Icons.arrow_back, color: Colors.black),
        title: const Text(
          "Review Your Profile",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const ProfileCard(
                title: "Skin Type",
                items: [
                  "Oily: Your skin produces excess sebum, leading to a shiny appearance and enlarged pores.",
                  "Sensitivity: Mild reactivity to new products or environmental changes.",
                ],
              ),
          
              const SizedBox(height: 12),
          
              const ProfileCard(
                title: "Concerns",
                items: [
                  "Acne: Occasional breakouts, primarily in the T-zone.",
                  "Redness: Mild, generalized redness on cheeks.",
                  "Uneven Texture: Some areas feel rough to the touch.",
                ],
              ),
          
              const SizedBox(height: 12),
          
              const ProfileCard(
                title: "Lifestyle",
                items: [
                  "Hydration: Drinks 8 glasses of water daily.",
                  "Exercise: Regular physical activity, 3-4 times a week.",
                  "Sleep: Averages 7-8 hours per night.",
                  "Stress Level: Moderate, manageable.",
                ],
              ),
          
              const SizedBox(height: 20),
          
              const InfoBox(),
          
              // const Spacer(),
          SizedBox(height: 20,),
             CustomButton(onPressed: (){}, text:"Complete Setup"),
            ],
          ),
        ),
      ),
    );
  }
}

class ProfileCard extends StatelessWidget {
  final String title;
  final List<String> items;

  const ProfileCard({
    super.key,
    required this.title,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const Text(
                "Edit",
                style: TextStyle(
                  color: Colors.pink,
                  fontWeight: FontWeight.w500,
                ),
              )
            ],
          ),

          const SizedBox(height: 10),

          ...items.map(
            (e) => Padding(
              padding: const EdgeInsets.only(bottom: 6),
              child: Text(
                e,
                style: TextStyle(
                  color: Colors.grey.shade700,
                  fontSize: 13,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class InfoBox extends StatelessWidget {
  const InfoBox({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xffF7D4CF),
        borderRadius: BorderRadius.circular(12),
      ),
      child: const Row(
        children: [
          Icon(Icons.auto_awesome, color: Colors.orange),
          SizedBox(width: 10),
          Expanded(
            child: Text(
              "Based on your profile, we'll create a personalized skincare routine just for you",
              style: TextStyle(fontSize: 13),
            ),
          )
        ],
      ),
    );
  }
}
