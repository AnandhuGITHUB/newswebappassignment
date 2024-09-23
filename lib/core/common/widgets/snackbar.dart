import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../theme/app_palette.dart';

void showCustomSnackbar({
  required String title,
  required String message,
  Duration duration = const Duration(seconds: 2),
}) {
  Get.snackbar(
    title,
    message,
    backgroundGradient: const LinearGradient(
      colors: [
        AppPalette.gradient1,
        AppPalette.gradient2,
      ],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ),
    snackPosition: SnackPosition.TOP,
    duration: duration,
    margin: const EdgeInsets.only(top: 20),
    titleText: Text(
      title,
      style: const TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.bold,
      ),
    ),
    messageText: Text(
      message,
      style: const TextStyle(
        color: Colors.white,
      ),
    ),
    maxWidth: 395,
    borderRadius: 10,
  );
}
