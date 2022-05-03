import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class AlertUtils {
  static showError(String message) {
    Get.snackbar(
      'Error',
      message,
      colorText: Colors.white,
      margin: const EdgeInsets.all(10),
      icon: const Icon(
        Iconsax.close_circle,
        color: Colors.white,
      ),
      backgroundColor: Colors.redAccent,
      snackPosition: SnackPosition.BOTTOM,
      duration: const Duration(seconds: 2),
    );
  }

  static showSuccess(String message) {
    Get.snackbar(
      'Éxito',
      message,
      colorText: Colors.black54,
      margin: const EdgeInsets.all(10),
      icon: const Icon(
        Iconsax.tick_circle,
        color: Colors.black54,
      ),
      backgroundColor: Colors.greenAccent,
      snackPosition: SnackPosition.BOTTOM,
      duration: const Duration(seconds: 2),
    );
  }
}
