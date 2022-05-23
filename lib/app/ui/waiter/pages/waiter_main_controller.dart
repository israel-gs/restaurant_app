import 'package:get/get.dart';
import 'package:segundo_muelle/app/data/models/table_model.dart';

class WaiterMainController extends GetxController {
  var selectedTable = TableModel(name: '', isTaken: false).obs;

  clearSelectedTable() {
    selectedTable.value = TableModel(name: '', isTaken: false);
  }
}
