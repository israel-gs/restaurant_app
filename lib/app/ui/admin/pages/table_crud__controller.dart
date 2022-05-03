import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:segundo_muelle/app/data/models/table_model.dart';
import 'package:segundo_muelle/app/ui/theme/color_theme.dart';
import 'package:segundo_muelle/app/widgets/dialogs/confirmation_dialog.dart';
import 'package:segundo_muelle/core/utils/alert_utils.dart';
import 'package:segundo_muelle/main_controller.dart';

class TableCrudController extends GetxController {
  final MainController _mainController = Get.find();
  List<TableModel> tables = <TableModel>[].obs;

  final loginFormKey = GlobalKey<FormState>();
  final TextEditingController newTableNameTextController =
      TextEditingController();
  final TextEditingController editTableNameTextController =
      TextEditingController();

  @override
  void onInit() {
    tables.addAll(_mainController.tableBox.values.toList());
    update();
    super.onInit();
  }

  String? _validateTewTableNameTextController(String? value) {
    if (value == null || value.isEmpty) {
      return 'El nombre de la mesa es requerido';
    }
    return null;
  }

  onDeleteTable(int index) {
    showDialog(
      context: Get.overlayContext!,
      builder: (context) => ConfirmationDialog(
        title: 'Eliminar',
        denyButtonText: 'Cancelar',
        subtitle: '¿Estás seguro de eliminar la mesa?',
        acceptButtonText: 'Eliminar',
        onDeny: () {
          onCancelDeleteTable();
        },
        onAccept: () {
          _mainController.tableBox.deleteAt(index);
          tables.clear();
          tables.addAll(_mainController.tableBox.values.toList());
          update();
          Get.back();
          AlertUtils.showSuccess('La mesa se eliminó correctamente');
        },
      ),
    );
  }

  onCancelDeleteTable() {
    tables.clear();
    tables.addAll(_mainController.tableBox.values.toList());
    update();
    Get.back();
  }

  onAddNewTable() async {
    await showDialog(
      context: Get.context!,
      builder: (_) => ConfirmationDialog(
        acceptButtonText: 'Añadir',
        denyButtonText: 'Cancelar',
        title: 'Agregar Mesa',
        subtitle: 'Se borrarán todos los datos de la tabla',
        subtitleContent: Form(
          key: loginFormKey,
          child: TextFormField(
            controller: newTableNameTextController,
            decoration: const InputDecoration(labelText: 'Nombre de la mesa'),
            validator: _validateTewTableNameTextController,
          ),
        ),
        onDeny: () {
          Get.back();
          newTableNameTextController.clear();
        },
        onAccept: () {
          if (loginFormKey.currentState!.validate()) {
            _mainController.tableBox.add(TableModel(
                name: newTableNameTextController.text, isTaken: false));
            newTableNameTextController.clear();
            tables.clear();
            tables.addAll(_mainController.tableBox.values.toList());
            update();
            Get.back();
            AlertUtils.showSuccess('Mesa agregada correctamente');
          }
        },
      ),
    );
  }

  onEditTable(int index, TableModel table) async {
    editTableNameTextController.text = table.name;
    await showDialog(
      context: Get.context!,
      builder: (_) => ConfirmationDialog(
        acceptButtonText: 'Editar',
        denyButtonText: 'Cancelar',
        title: 'Editar Mesa',
        subtitle: '',
        subtitleContent: Form(
          key: loginFormKey,
          child: TextFormField(
            controller: editTableNameTextController,
            decoration: const InputDecoration(labelText: 'Nombre de la mesa'),
            validator: _validateTewTableNameTextController,
          ),
        ),
        onDeny: () {
          Get.back();
          editTableNameTextController.clear();
        },
        onAccept: () {
          if (loginFormKey.currentState!.validate()) {
            _mainController.tableBox.putAt(
                index,
                TableModel(
                    name: editTableNameTextController.text, isTaken: false));
            newTableNameTextController.clear();
            tables.clear();
            tables.addAll(_mainController.tableBox.values.toList());
            update();
            Get.back();
            AlertUtils.showSuccess('La mesa se editó correctamente');
          }
        },
      ),
    );
  }
}
