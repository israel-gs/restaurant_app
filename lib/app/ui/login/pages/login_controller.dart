import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:segundo_muelle/app/ui/admin/pages/admin_dashboard_page.dart';
import 'package:segundo_muelle/app/ui/home/pages/main_page.dart';

class LoginController extends GetxController {
  final loginFormKey = GlobalKey<FormState>();
  final userController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  onClose() {
    userController.dispose();
    passwordController.dispose();
    super.onClose();
  }

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
      print(userController.text);
      print(passwordController.text);

      if (userController.text == 'admin' &&
          passwordController.text == 'admin') {
        userController.clear();
        passwordController.clear();
        Get.offAll(() => const AdminDashboardPage());
        // todo: implementar el login de admin
        // todo: implementar el login de usuario
        // todo: implementar dashboard del admin
        // todo: implementar crud usuario
        // todo: implementar crud plato
        // todo: implementar crud mesa
        // todo: crear tipo para los pedidos de la mesa (array de platos)
      } else {
        Get.offAll(() => const MainPage());
      }
    }
  }
}
