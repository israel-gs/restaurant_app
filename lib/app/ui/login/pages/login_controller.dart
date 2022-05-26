import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:segundo_muelle/app/data/models/user_model.dart';
import 'package:segundo_muelle/app/ui/admin/pages/admin_dashboard_page.dart';
import 'package:segundo_muelle/app/ui/waiter/pages/waiter_main_page.dart';
import 'package:segundo_muelle/core/utils/alert_utils.dart';
import 'package:segundo_muelle/main_controller.dart';

class LoginController extends GetxController {
  final MainController _mainController = Get.find();
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
      if (userController.text == 'admin' &&
          passwordController.text == 'admin') {
        userController.clear();
        passwordController.clear();
        _mainController.currentUser(UserModel(
          name: 'Administrador',
          isAdmin: true,
          isBlocked: false,
          password: 'admin',
          username: 'admin',
          attemptsCount: 0,
        ));
        Get.offAll(() => const AdminDashboardPage());
      } else {
        _mainController.userBox.values.toList().forEach((user) {
          if (user.username == userController.text) {
            if (user.password == passwordController.text && !user.isBlocked) {
              _mainController.currentUser(user);
              if (user.isAdmin) {
                userController.clear();
                passwordController.clear();
                Get.offAll(() => const AdminDashboardPage());
              } else {
                userController.clear();
                passwordController.clear();
                Get.offAll(() => const WaiterMainPage());
              }
            } else {
              if (user.attemptsCount >= 3) {
                int index =
                    _mainController.userBox.values.toList().indexOf(user);
                UserModel newUser = UserModel(
                  name: user.name,
                  username: user.username,
                  password: user.password,
                  isAdmin: user.isAdmin,
                  isBlocked: true,
                  attemptsCount: user.attemptsCount + 1,
                );
                _mainController.userBox.putAt(index, newUser);
                AlertUtils.showError(
                    'Su usuario ha sido bloqueado por 3 intentos fallidos');
              } else {
                int index =
                    _mainController.userBox.values.toList().indexOf(user);
                UserModel newUser = UserModel(
                  name: user.name,
                  username: user.username,
                  password: user.password,
                  isAdmin: user.isAdmin,
                  isBlocked: user.isBlocked,
                  attemptsCount: user.attemptsCount + 1,
                );
                _mainController.userBox.putAt(index, newUser);
                AlertUtils.showError('Contraseña incorrecta');
              }
            }
          }
        });
      }
    }
  }
}
