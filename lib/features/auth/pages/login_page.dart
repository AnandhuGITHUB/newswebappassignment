import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_feed_web_app/features/auth/pages/signup_page.dart';

import '../../../core/theme/app_palette.dart';
import '../controllers/auth_controller.dart';
import '../../../widgets/app_text_field.dart';
import '../../../widgets/app_button.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
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
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Form(
          key: formKey,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Sign In",
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
                          buttonText: "Sign In",
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              AuthController.instance.login(
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
                    Get.to(() => const SignUpPage());
                  },
                  child: RichText(
                    text: TextSpan(
                      text: 'Don\'t have an account?',
                      style: Theme.of(context).textTheme.titleMedium,
                      children: [
                        TextSpan(
                          text: ' Sign Up',
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
