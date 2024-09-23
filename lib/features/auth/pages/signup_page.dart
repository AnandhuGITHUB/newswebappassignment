import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_feed_web_app/features/auth/pages/login_page.dart';

import '../../../core/theme/app_palette.dart';
import '../controllers/auth_controller.dart';
import '../../../widgets/app_text_field.dart';
import '../../../widgets/app_button.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Form(
          key: formKey,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Sign Up",
                  style: TextStyle(
                    fontSize: 50,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 30),
                AppTextField(
                  hintText: "Email",
                  controller: emailController,
                ),
                const SizedBox(height: 15),
                AppTextField(
                  hintText: "Password",
                  controller: passwordController,
                  isObscureText: true,
                ),
                const SizedBox(height: 20),
                Obx(
                  () => AuthController.instance.isLoading.value
                      ? const Center(
                          child: CircularProgressIndicator(
                            color: AppPalette.gradient2,
                          ),
                        )
                      : AppButton(
                          buttonText: "Sign Up",
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              AuthController.instance.register(
                                emailController.text.trim(),
                                passwordController.text.trim(),
                              );
                            }
                          },
                        ),
                ),
                const SizedBox(height: 20),
                GestureDetector(
                  onTap: () {
                    Get.to(() => const LoginPage());
                  },
                  child: RichText(
                    text: TextSpan(
                      text: 'Already have an account?',
                      style: Theme.of(context).textTheme.titleMedium,
                      children: [
                        TextSpan(
                          text: ' Sign In',
                          mouseCursor: SystemMouseCursors.click,
                          style:
                              Theme.of(context).textTheme.titleMedium?.copyWith(
                                    color: AppPalette.gradient2,
                                    fontWeight: FontWeight.bold,
                                  ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
