import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:segundo_muelle/app/data/models/user_model.dart';
import 'package:segundo_muelle/app/ui/theme/color_theme.dart';
import 'package:segundo_muelle/app/widgets/dialogs/confirmation_dialog.dart';
import 'package:segundo_muelle/main_controller.dart';

class UserCrudController extends GetxController {
  final MainController _mainController = Get.find();
  List<UserModel> users = <UserModel>[].obs;

  final formKey = GlobalKey<FormState>();
  final TextEditingController addNameTextController = TextEditingController();
  final TextEditingController addUsernameTextController =
      TextEditingController();
  final TextEditingController addPasswordTextController =
      TextEditingController();

  final TextEditingController editNameTextController = TextEditingController();
  final TextEditingController editUsernameTextController =
      TextEditingController();
  final TextEditingController editPasswordTextController =
      TextEditingController();

  @override
  void onInit() {
    users.addAll(_mainController.userBox.values.toList());
    update();
    super.onInit();
  }

  String? _validateTewTableNameTextController(String? value) {
    if (value == null || value.isEmpty) {
      return 'El campo es requerido';
    }
    return null;
  }

  onDeleteUser(int index) {
    showDialog(
      context: Get.overlayContext!,
      builder: (context) => ConfirmationDialog(
        title: 'Eliminar',
        denyButtonText: 'Cancelar',
        subtitle: '¿Estás seguro de eliminar al usuario?',
        acceptButtonText: 'Eliminar',
        onDeny: () {
          onCancelDeleteUser();
        },
        onAccept: () {
          _mainController.userBox.deleteAt(index);
          users.clear();
          users.addAll(_mainController.userBox.values.toList());
          update();
          Get.back();
          Get.showSnackbar(const GetSnackBar(
            duration: Duration(seconds: 2),
            message: 'El usuario se eliminó correctamente',
            backgroundColor: ColorTheme.primary,
          ));
        },
      ),
    );
  }

  onCancelDeleteUser() {
    users.clear();
    users.addAll(_mainController.userBox.values.toList());
    update();
    Get.back();
  }

  onAddNewUser() async {
    await showDialog(
      context: Get.context!,
      builder: (_) => ConfirmationDialog(
        acceptButtonText: 'Añadir',
        denyButtonText: 'Cancelar',
        title: 'Añadir usuario',
        subtitle: '',
        subtitleContent: Form(
          key: formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: addNameTextController,
                decoration:
                    const InputDecoration(labelText: 'Nombre y Apeliido'),
                validator: _validateTewTableNameTextController,
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: addUsernameTextController,
                decoration:
                    const InputDecoration(labelText: 'Nombre de usuario'),
                validator: _validateTewTableNameTextController,
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: addPasswordTextController,
                decoration: const InputDecoration(labelText: 'Contraseña'),
                validator: _validateTewTableNameTextController,
              ),
            ],
          ),
        ),
        onDeny: () {
          Get.back();
          formKey.currentState?.reset();
        },
        onAccept: () {
          if (formKey.currentState!.validate()) {
            _mainController.userBox.add(UserModel(
                name: addNameTextController.text,
                password: addPasswordTextController.text,
                username: addUsernameTextController.text));
            formKey.currentState?.reset();
            users.clear();
            users.addAll(_mainController.userBox.values.toList());
            update();
            Get.back();
            Get.showSnackbar(const GetSnackBar(
              duration: Duration(seconds: 2),
              message: 'Usuario creado correctamente',
              backgroundColor: ColorTheme.primary,
            ));
          }
        },
      ),
    );
  }

  onEditUser(int index, UserModel user) async {
    editNameTextController.text = user.name;
    editUsernameTextController.text = user.username;
    editPasswordTextController.text = user.password;
    await showDialog(
      context: Get.context!,
      builder: (_) => ConfirmationDialog(
        acceptButtonText: 'Editar',
        denyButtonText: 'Cancelar',
        title: 'Editar Usuario',
        subtitle: '',
        subtitleContent: Form(
          key: formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: editNameTextController,
                decoration:
                    const InputDecoration(labelText: 'Apellido y Nombre'),
                validator: _validateTewTableNameTextController,
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: editUsernameTextController,
                decoration:
                    const InputDecoration(labelText: 'Nombre de usuario'),
                validator: _validateTewTableNameTextController,
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: editPasswordTextController,
                decoration: const InputDecoration(labelText: 'Contraseña'),
                validator: _validateTewTableNameTextController,
              ),
            ],
          ),
        ),
        onDeny: () {
          Get.back();
          formKey.currentState?.reset();
        },
        onAccept: () {
          if (formKey.currentState!.validate()) {
            _mainController.userBox.putAt(
                index,
                UserModel(
                    name: editNameTextController.text,
                    password: editPasswordTextController.text,
                    username: editUsernameTextController.text));
            formKey.currentState?.reset();
            users.clear();
            users.addAll(_mainController.userBox.values.toList());
            update();
            Get.back();
            Get.showSnackbar(const GetSnackBar(
              duration: Duration(seconds: 2),
              message: 'El usuario se editó correctamente',
              backgroundColor: ColorTheme.primary,
            ));
          }
        },
      ),
    );
  }
}
