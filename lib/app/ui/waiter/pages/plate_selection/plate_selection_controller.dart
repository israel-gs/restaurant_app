import 'package:get/get.dart';
import 'package:segundo_muelle/app/data/enums/category_enum.dart';
import 'package:segundo_muelle/app/data/models/order_model.dart';
import 'package:segundo_muelle/app/data/models/order_plate_model.dart';
import 'package:segundo_muelle/app/data/models/plate_model.dart';
import 'package:segundo_muelle/app/data/models/table_model.dart';
import 'package:segundo_muelle/app/data/models/user_model.dart';
import 'package:segundo_muelle/app/ui/waiter/pages/table_selection/table_selection_controller.dart';
import 'package:segundo_muelle/app/ui/waiter/pages/waiter_main_controller.dart';
import 'package:segundo_muelle/main_controller.dart';

class PlateSelectionController extends GetxController {
  final MainController _mainController = Get.find();
  final WaiterMainController _waiterMainController = Get.find();
  final TableSelectionController _tableSelectionController = Get.find();

  var selectedCategory = CategoryEnum.starterDish.obs;
  List<PlateModel> plates = <PlateModel>[].obs;
  var tempOrder = OrderModel(
    user: UserModel(
      name: '',
      username: '',
      password: '',
      isAdmin: false,
      isBlocked: false,
      attemptsCount: 0,
    ),
    table: TableModel(
      name: '',
      isTaken: false,
    ),
    date: DateTime.now(),
    tip: 0,
    orderPlates: [],
    orderClosed: false,
  ).obs;

  @override
  void onInit() {
    setPlates();
    setOrder();
    super.onInit();
  }

  @override
  void onClose() {
    registerOrder();
    updateTableStatus();
    _waiterMainController.clearSelectedTable();
    super.onClose();
  }

  void setPlates() {
    plates.addAll(_mainController.plateBox.values.toList());
    update();
  }

  void setOrder() {
    var orderAlreadyExist = _mainController.orderBox.values
        .toList()
        .firstWhereOrNull((element) =>
            (element.table.name ==
                _waiterMainController.selectedTable.value.name) &&
            !element.orderClosed);
    if (orderAlreadyExist != null) {
      tempOrder.value = orderAlreadyExist;
    } else {
      tempOrder.value.user = _mainController.currentUser.value;
      tempOrder.value.table = _waiterMainController.selectedTable.value;
      tempOrder.value.date = DateTime.now();
    }
    update();
  }

  void registerOrder() {
    if (tempOrder.value.orderPlates.isNotEmpty) {
      _mainController.orderBox.add(tempOrder.value);
    }
  }

  void updateTableStatus() {
    if (tempOrder.value.orderPlates.isNotEmpty) {
      _waiterMainController.selectedTable.value.isTaken = true;
      _mainController.tableBox.values.toList().indexWhere((element) =>
          element.name == _waiterMainController.selectedTable.value.name);
      _tableSelectionController.updateTables();
    }
  }

  void addPlateToOrder(PlateModel plate) {
    int plateInOrderIndex = tempOrder.value.orderPlates
        .indexWhere((element) => element.plate.code == plate.code);
    if (plateInOrderIndex >= 0) {
      tempOrder.value.orderPlates.elementAt(plateInOrderIndex).quantity++;
    } else {
      tempOrder.value.orderPlates.add(
        OrderPlateModel(
          plate: plate,
          quantity: 1,
        ),
      );
    }
    tempOrder.refresh();
  }

  void changePlateQuantity(PlateModel plate, int quantity) {
    int plateInOrderIndex = tempOrder.value.orderPlates
        .indexWhere((element) => element.plate.code == plate.code);
    if (plateInOrderIndex >= 0) {
      tempOrder.value.orderPlates.elementAt(plateInOrderIndex).quantity = quantity;
    }
    tempOrder.refresh();
  }
}
