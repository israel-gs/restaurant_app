import 'package:get/get.dart';
import 'package:segundo_muelle/app/data/models/table_model.dart';
import 'package:segundo_muelle/main_controller.dart';

class TableSelectionController extends GetxController {
  final MainController _mainController = Get.find();
  List<TableModel> tables = <TableModel>[].obs;

  @override
  void onInit() {
    updateTables();
    super.onInit();
  }

  updateTables() {
    tables.clear();
    tables.addAll(_mainController.tableBox.values.toList());
    update();
  }
}
