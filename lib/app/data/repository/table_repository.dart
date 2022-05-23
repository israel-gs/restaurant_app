import 'package:segundo_muelle/app/data/models/table_model.dart';
import 'package:segundo_muelle/app/data/providers/table_provider.dart';

class TableRepository {
  final TableProvider _tableProvider = TableProvider();

  Future<String> registerTable(TableModel table) {
    return _tableProvider.registerTable(table);
  }

  Future<void> updateTable(String key, TableModel table) async {
    await _tableProvider.updateTable(key, table);
  }

  void deleteTable(String key) {
    _tableProvider.deleteTable(key);
  }

  List<TableModel> getTables() {
    return _tableProvider.getTables();
  }

  TableModel getTableByName(String name) {
    return _tableProvider.getTableByName(name);
  }
}
