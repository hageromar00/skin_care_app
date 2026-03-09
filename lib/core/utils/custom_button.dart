import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    this.height,
    this.wid,
    required this.onPressed,
    required this.text,
    this.icon,
  });
  final double? height;
  final double? wid;
  final void Function()? onPressed;
  final String text;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: wid ?? double.infinity,
      height: height ?? 50,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xfff55c97),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
        onPressed: onPressed,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              text,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),

            if (icon != null) ...[
              const SizedBox(width: 6),
              Icon(icon, size: 16, color: Colors.white),
            ],
          ],
        ),
        //  Text(
        //   text,
        //   style: const TextStyle(fontSize: 16, color: Colors.white,fontWeight: FontWeight.bold),
        // ),
      ),
    );
  }
}
