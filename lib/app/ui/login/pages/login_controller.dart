import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:segundo_muelle/app/ui/home/pages/main_page.dart';

class LoginController extends GetxController {
  final loginFormKey = GlobalKey<FormState>();

  String? validateUser(String? value) {
    if (value == null || value.isEmpty) {
      return 'El usuario es requerido';
    }
    return null;
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'La contraseña es requerida';
    }
    return null;
  }

  onContinue() {
    if (loginFormKey.currentState!.validate()) {
      Get.offAll(const MainPage());
    }
  }
}
