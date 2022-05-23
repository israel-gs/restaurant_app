import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:segundo_muelle/app/data/models/table_model.dart';
import 'package:segundo_muelle/app/data/repository/order_repository.dart';
import 'package:segundo_muelle/app/data/repository/table_repository.dart';
import 'package:segundo_muelle/app/ui/waiter/pages/plate_selection/plate_selection_page.dart';
import 'package:segundo_muelle/app/ui/waiter/pages/waiter_main_controller.dart';
import 'package:segundo_muelle/app/widgets/dialogs/confirmation_dialog.dart';

class TableSelectionController extends GetxController {
  final TableRepository _tableRepository = Get.find<TableRepository>();
  final WaiterMainController _waiterMainController = Get.find();
  final OrderRepository _orderRepository = Get.find<OrderRepository>();
  List<TableModel> tables = <TableModel>[].obs;

  @override
  void onInit() {
    updateTables();
    super.onInit();
  }

  updateTables() {
    tables.clear();
    tables.addAll(_tableRepository.getTables());
    update();
  }

  Future<void> updateTableStatus(bool isTaken, TableModel table) async {
    String tableKey = table.key;
    table.isTaken = isTaken;
    await _tableRepository.updateTable(tableKey, table);
    updateTables();
  }

  onSelectTable(TableModel table) {
    _waiterMainController.selectedTable(table);
    Get.to(() => const PlateSelectionPage());
  }

  onLongPressTable(TableModel table) {
    showDialog(
      context: Get.overlayContext!,
      builder: (context) => ConfirmationDialog(
        title: '¿Estás seguro de limpiar la ${table.name}?',
        denyButtonText: 'Cancelar',
        subtitle: 'Se eliminarán todos los platos de la mesa.',
        acceptButtonText: 'Limpiar Mesa',
        onDeny: () {
          Get.back();
        },
        onAccept: () {
          var orderAlreadyExist = _orderRepository.getOrders().firstWhereOrNull(
              (element) =>
                  (element.table.key == table.key) && !element.orderClosed);
          if (orderAlreadyExist != null) {
            _orderRepository.deleteOrder(orderAlreadyExist.key);
          }
          updateTableStatus(false, table);
          updateTables();
          Get.back();
        },
      ),
    );
  }
}
