import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:segundo_muelle/app/data/models/table_model.dart';
import 'package:segundo_muelle/app/data/repository/table_repository.dart';
import 'package:segundo_muelle/app/widgets/dialogs/confirmation_dialog.dart';
import 'package:segundo_muelle/core/utils/alert_utils.dart';

class TableCrudController extends GetxController {
  final TableRepository _tableRepository = Get.find();

  List<TableModel> tables = <TableModel>[].obs;

  final loginFormKey = GlobalKey<FormState>();
  final TextEditingController newTableNameTextController =
      TextEditingController();
  final TextEditingController editTableNameTextController =
      TextEditingController();

  @override
  void onInit() {
    _setTables();
    super.onInit();
  }

  String? _validateTewTableNameTextController(String? value) {
    if (value == null || value.isEmpty) {
      return 'El nombre de la mesa es requerido';
    }
    return null;
  }

  onDeleteTable(String key) {
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
          _tableRepository.deleteTable(key);
          _setTables();
          Get.back();
          AlertUtils.showSuccess('La mesa se eliminó correctamente');
        },
      ),
    );
  }

  onCancelDeleteTable() {
    _setTables();
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
            var table = TableModel(
              name: newTableNameTextController.text,
              isTaken: false,
            );
            _tableRepository.registerTable(table);
            newTableNameTextController.clear();
            _setTables();
            Get.back();
            AlertUtils.showSuccess('Mesa agregada correctamente');
          }
        },
      ),
    );
  }

  onEditTable(String key, TableModel table) async {
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
            var table = TableModel(
                name: editTableNameTextController.text, isTaken: false);
            _tableRepository.updateTable(key, table);
            newTableNameTextController.clear();
            _setTables();
            Get.back();
            AlertUtils.showSuccess('La mesa se editó correctamente');
          }
        },
      ),
    );
  }

  _setTables() {
    tables.clear();
    tables.addAll(_tableRepository.getTables());
    tables.sort((a, b) => a.name.compareTo(b.name));
    update();
  }
}
