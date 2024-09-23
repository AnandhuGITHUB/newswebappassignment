import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppTextField extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  final bool isObscureText;

  final int? maxLines;
  const AppTextField({
    super.key,
    required this.hintText,
    required this.controller,
    this.isObscureText = false,
    this.maxLines = 1,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 395,
      child: TextFormField(
        keyboardType: TextInputType.emailAddress,
        obscureText: isObscureText,
        controller: controller,
        maxLines: maxLines,
        decoration: InputDecoration(
          hintText: hintText,
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return '$hintText is missing';
          }
          if (hintText == "Email") {
            if (!GetUtils.isEmail(value)) {
              return 'Please enter a valid email';
            }
          }
          return null;
        },
      ),
    );
  }
}
