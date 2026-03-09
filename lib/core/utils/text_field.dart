import 'package:flutter/material.dart';

// class CustomTextFormField extends StatelessWidget {
//   final String hint;
//   final bool obscure;
//   final TextEditingController controller;
//   final String? Function(String?)? validator;
//   final TextInputType keyboardType;
//   final IconData? prefixIcon;

//   const CustomTextFormField({
//     super.key,
//     required this.hint,
//     required this.controller,
//     this.obscure = false,
//     this.validator,
//     this.keyboardType = TextInputType.text,
//     this.prefixIcon,
//   });

//   @override
//   Widget build(BuildContext context) {
//     const primaryPink = Color(0xFFE91E63);

//     return TextFormField(
//       controller: controller,
//       obscureText: obscure,
//       keyboardType: keyboardType,
//       validator: validator,
//       decoration: InputDecoration(
//         hintText: hint,
//         hintStyle: TextStyle(color: Colors.grey.shade500),
//         filled: true,
//         fillColor: const Color(0xFFF7F7F7),
//         contentPadding:
//             const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
//         prefixIcon: prefixIcon != null
//             ? Icon(prefixIcon, color: Colors.grey.shade600)
//             : null,
//         enabledBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(18),
//           borderSide: BorderSide(color: Colors.grey.shade300),
//         ),
//         focusedBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(18),
//           borderSide: const BorderSide(color: primaryPink, width: 1.3),
//         ),
//         errorBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(18),
//           borderSide: const BorderSide(color: Colors.red),
//         ),
//       ),
//     );
//   }
// }
class CustomTextFormField extends StatefulWidget {
  final String hint;
  final bool obscure;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final TextInputType keyboardType;
  final IconData? prefixIcon;

  const CustomTextFormField({
    super.key,
    required this.hint,
    required this.controller,
    this.obscure = false,
    this.validator,
    this.keyboardType = TextInputType.text,
    this.prefixIcon,
  });

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  bool isObscure = true;

  @override
  Widget build(BuildContext context) {
    const primaryPink = Color(0xFFE91E63);

    return TextFormField(
      controller: widget.controller,
      obscureText: widget.obscure ? isObscure : false,
      keyboardType: widget.keyboardType,
      validator: widget.validator,
      decoration: InputDecoration(
        hintText: widget.hint,
        filled: true,
        fillColor: const Color(0xFFF7F7F7),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 18,
        ),

        prefixIcon: widget.prefixIcon != null
            ? Icon(widget.prefixIcon, color: Colors.grey.shade600)
            : null,

        // 👇 هنا العين
        suffixIcon: widget.obscure
            ? IconButton(
                icon: Icon(
                  isObscure
                      ? Icons.visibility_off_outlined
                      : Icons.visibility_outlined,
                  color: Colors.grey.shade600,
                ),
                onPressed: () {
                  setState(() {
                    isObscure = !isObscure;
                  });
                },
              )
            : null,

        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: const BorderSide(color: primaryPink, width: 1.3),
        ),
      ),
    );
  }
}
