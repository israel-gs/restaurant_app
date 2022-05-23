import 'package:get/get.dart';
import 'package:segundo_muelle/app/data/models/table_model.dart';
import 'package:segundo_muelle/main_controller.dart';
import 'package:uuid/uuid.dart';

class TableProvider {
  final MainController _mainController = Get.find();

  Future<String> registerTable(TableModel table) async {
    var uuid = const Uuid();
    var key = uuid.v4();
    await _mainController.tableBox.put(key, table);
    return key;
  }

  Future<void> updateTable(String key, TableModel table) async {
    int index = _mainController.tableBox.values
        .toList()
        .indexWhere((element) => element.key == key);
    await _mainController.tableBox.putAt(index, table);
  }

  void deleteTable(String key) async {
    await _mainController.tableBox.delete(key);
  }

  List<TableModel> getTables() {
    return _mainController.tableBox.values.toList();
  }

  TableModel getTableByName(String name) {
    return _mainController.tableBox.values
        .firstWhere((table) => table.name == name);
  }
}
