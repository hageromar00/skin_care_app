import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:skin_care_app/core/utils/custom_button.dart';
import 'package:skin_care_app/core/utils/routers.dart';
import 'package:skin_care_app/core/utils/text_field.dart';

class CreateAccountScreen extends StatefulWidget {
  const CreateAccountScreen({super.key});

  @override
  State<CreateAccountScreen> createState() => _CreateAccountScreenState();
}

class _CreateAccountScreenState extends State<CreateAccountScreen> {
  final _formKey = GlobalKey<FormState>();

  final emailController = TextEditingController();
  final usernameController = TextEditingController();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    const primaryPink = Color(0xFFE91E63);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 28),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 40),

                /// Title
                const Center(
                  child: Text(
                    "Create Your GlowGuide Account",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
                  ),
                ),

                const SizedBox(height: 35),

                const Text(
                  "Basic Information",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),

                const SizedBox(height: 20),

                CustomTextFormField(
                  hint: "Email Address",
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  prefixIcon: Icons.email_outlined,
                ),
                const SizedBox(height: 18),

                CustomTextFormField(
                  hint: "Username",
                  controller: usernameController,
                  prefixIcon: Icons.person_outline,
                ),
                const SizedBox(height: 18),

                CustomTextFormField(
                  hint: "Phone Number",
                  controller: phoneController,
                  keyboardType: TextInputType.phone,
                  prefixIcon: Icons.phone_outlined,
                ),
                const SizedBox(height: 18),

                CustomTextFormField(
                  hint: "Password",
                  controller: passwordController,
                  obscure: true,
                  prefixIcon: Icons.lock_outline,
                ),
                const SizedBox(height: 18),

                CustomTextFormField(
                  hint: "Confirm Password",
                  controller: confirmPasswordController,
                  obscure: true,
                  prefixIcon: Icons.lock_outline,
                ),

                const SizedBox(height: 30),

                /// Continue with Google
                Container(
                  height: 60,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30),
                    border: Border.all(color: Colors.grey.shade300),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.network(
                        "https://cdn-icons-png.flaticon.com/512/2991/2991148.png",
                        height: 22,
                      ),
                      const SizedBox(width: 10),
                      const Text(
                        "Continue with Google",
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 18),

                CustomButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      GoRouter.of(context).push(AppRouter.kabout);
                    }
                  },
                  text: 'Create Account',
                ),

                const SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
