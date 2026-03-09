import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:skin_care_app/presentation/skin_type/model/skin_type_model.dart';

class SkinTypeCard extends StatelessWidget {
  final SkinTypeModel skinType;
  final VoidCallback onTap;

  const SkinTypeCard({
    super.key,
    required this.skinType,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final bool selected = skinType.isSelected;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: selected ? const Color(0xffFF5C93) : Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: const Color(0xffE6E6E6)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(.04),
              blurRadius: 8,
              offset: const Offset(0, 3),
            )
          ],
        ),
        child:Column(
  mainAxisAlignment: MainAxisAlignment.center,
  children: [

    Image.asset(
      skinType.image,
      height: 50,
    ),

    const SizedBox(height: 10),

    AutoSizeText(
      skinType.title,
      maxLines: 1,
      minFontSize: 10,
      style: TextStyle(
        fontWeight: FontWeight.bold,
        color: selected ? Colors.white : Colors.black,
      ),
    ),

    const SizedBox(height: 6),

    AutoSizeText(
      skinType.description,
      textAlign: TextAlign.center,
      maxLines: 2,
      minFontSize: 9,
      style: TextStyle(
        fontSize: 12,
        color: selected ? Colors.white : Colors.grey,
      ),
    ),
  ],
)
      ),
    );
  }
}