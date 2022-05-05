import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:segundo_muelle/app/data/models/user_model.dart';
import 'package:segundo_muelle/app/widgets/dialogs/confirmation_dialog.dart';
import 'package:segundo_muelle/core/utils/alert_utils.dart';
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
  var addUserIsBlocked = false.obs;
  var addUserIsAdmin = false.obs;

  final TextEditingController editNameTextController = TextEditingController();
  final TextEditingController editUsernameTextController =
      TextEditingController();
  final TextEditingController editPasswordTextController =
      TextEditingController();
  var editUserIsBlocked = false.obs;
  var editUserIsAdmin = false.obs;

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
          AlertUtils.showSuccess('El usuario se eliminó correctamente');
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
        subtitleContent: Obx(() {
          return Form(
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
                const SizedBox(height: 5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Bloqueado: '),
                    Switch(
                      value: addUserIsBlocked.value,
                      onChanged: (value) {
                        addUserIsBlocked(value);
                        update();
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Administrador: '),
                    Switch(
                      value: addUserIsAdmin.value,
                      onChanged: (value) {
                        addUserIsAdmin(value);
                        update();
                      },
                    ),
                  ],
                ),
              ],
            ),
          );
        }),
        onDeny: () {
          Get.back();
          formKey.currentState?.reset();
        },
        onAccept: () {
          if (formKey.currentState!.validate()) {
            _mainController.userBox.add(UserModel(
              name: addNameTextController.text,
              password: addPasswordTextController.text,
              username: addUsernameTextController.text,
              isAdmin: addUserIsAdmin.value,
              isBlocked: addUserIsBlocked.value,
              attemptsCount: 0,
            ));
            formKey.currentState?.reset();
            addUserIsBlocked(false);
            addUserIsAdmin(false);
            users.clear();
            users.addAll(_mainController.userBox.values.toList());
            update();
            Get.back();
            AlertUtils.showSuccess('Usuario creado correctamente');
          }
        },
      ),
    );
  }

  onEditUser(int index, UserModel user) async {
    editNameTextController.text = user.name;
    editUsernameTextController.text = user.username;
    editPasswordTextController.text = user.password;
    editUserIsBlocked(user.isBlocked);
    editUserIsAdmin(user.isAdmin);
    await showDialog(
      context: Get.context!,
      builder: (_) => ConfirmationDialog(
        acceptButtonText: 'Editar',
        denyButtonText: 'Cancelar',
        title: 'Editar Usuario',
        subtitle: '',
        subtitleContent: Obx(() {
          return Form(
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
                const SizedBox(height: 5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Bloqueado: '),
                    Switch(
                      value: editUserIsBlocked.value,
                      onChanged: (value) {
                        editUserIsBlocked(value);
                        update();
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Administrador: '),
                    Switch(
                      value: editUserIsAdmin.value,
                      onChanged: (value) {
                        editUserIsAdmin(value);
                        update();
                      },
                    ),
                  ],
                ),
              ],
            ),
          );
        }),
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
                  username: editUsernameTextController.text,
                  isBlocked: editUserIsBlocked.value,
                  isAdmin: editUserIsAdmin.value,
                  attemptsCount: user.isBlocked != editUserIsBlocked.value
                      ? 0
                      : user.attemptsCount,
                ));
            formKey.currentState?.reset();
            users.clear();
            users.addAll(_mainController.userBox.values.toList());
            update();
            Get.back();
            AlertUtils.showSuccess('El usuario se editó correctamente');
          }
        },
      ),
    );
  }
}
