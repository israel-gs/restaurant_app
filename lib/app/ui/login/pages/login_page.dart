import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:segundo_muelle/app/ui/login/pages/login_controller.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final LoginController _loginController = Get.put(LoginController());

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 50),
            child: Form(
              key: _loginController.loginFormKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SvgPicture.asset(
                    'lib/app/assets/logo.svg',
                    width: Get.width * 0.4,
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  TextFormField(
                    controller: _loginController.userController,
                    decoration: const InputDecoration(labelText: 'Usuario'),
                    validator: _loginController.validateUser,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: _loginController.passwordController,
                    decoration: const InputDecoration(labelText: 'Contraseña'),
                    validator: _loginController.validatePassword,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            elevation: 0,
                            padding: const EdgeInsets.all(16),
                            shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(6)),
                            ),
                          ),
                          onPressed: _loginController.onContinue,
                          child: const Text(
                            'Ingresar',
                            style: TextStyle(fontWeight: FontWeight.w500),
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
