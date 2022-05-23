import 'package:get/get.dart';
import 'package:segundo_muelle/app/data/enums/category_enum.dart';
import 'package:segundo_muelle/app/data/models/order_model.dart';
import 'package:segundo_muelle/app/data/models/order_plate_model.dart';
import 'package:segundo_muelle/app/data/models/plate_model.dart';
import 'package:segundo_muelle/app/data/models/table_model.dart';
import 'package:segundo_muelle/app/data/models/user_model.dart';
import 'package:segundo_muelle/app/data/repository/order_repository.dart';
import 'package:segundo_muelle/app/data/repository/plate_repository.dart';
import 'package:segundo_muelle/app/data/repository/table_repository.dart';
import 'package:segundo_muelle/app/ui/waiter/pages/table_selection/table_selection_controller.dart';
import 'package:segundo_muelle/app/ui/waiter/pages/waiter_main_controller.dart';
import 'package:segundo_muelle/app/ui/waiter/pages/waiter_main_page.dart';
import 'package:segundo_muelle/main_controller.dart';

class PlateSelectionController extends GetxController {
  final MainController _mainController = Get.find();
  final WaiterMainController _waiterMainController = Get.find();
  final TableSelectionController _tableSelectionController = Get.find();

  final PlateRepository _plateRepository = Get.find();
  final TableRepository _tableRepository = Get.find();
  final OrderRepository _orderRepository = Get.find();

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
  String orderKey = '';

  @override
  void onInit() {
    setPlates();
    setOrder();
    super.onInit();
  }

  @override
  void onClose() {
    _waiterMainController.clearSelectedTable();
    super.onClose();
  }

  void setPlates() {
    plates.addAll(_plateRepository.getPlates());
    update();
  }

  void setOrder() {
    TableModel selectedTable = _waiterMainController.selectedTable.value;
    var orderAlreadyExist = _orderRepository.getOrders().firstWhereOrNull(
        (element) =>
            (element.table.key == selectedTable.key) && !element.orderClosed);
    if (orderAlreadyExist != null) {
      tempOrder.value = orderAlreadyExist;
      orderKey = orderAlreadyExist.key;
    } else {
      tempOrder.value.user = _mainController.currentUser.value;
      tempOrder.value.table = selectedTable;
      tempOrder.value.date = DateTime.now();
    }
    update();
  }

  void registerOrder() {
    if (tempOrder.value.orderPlates.isNotEmpty) {
      _orderRepository.registerOrder(tempOrder.value);
    }
  }

  void closeOrder() async {
    await _tableSelectionController.updateTableStatus(
        false, _waiterMainController.selectedTable.value);
    clearTempOrder();
    Get.offAll(() => const WaiterMainPage());
  }

  void addPlateToOrder(PlateModel plate) {
    int plateInOrderIndex = tempOrder.value.orderPlates
        .indexWhere((element) => element.plate.code == plate.code);
    if (plateInOrderIndex >= 0) {
      tempOrder.value.orderPlates.elementAt(plateInOrderIndex).quantity++;
      _orderRepository.updateOrder(orderKey, tempOrder.value);
    } else {
      tempOrder.value.orderPlates.add(
        OrderPlateModel(
          plate: plate,
          quantity: 1,
        ),
      );
      orderKey = _orderRepository.registerOrder(tempOrder.value);
    }
    _tableSelectionController.updateTableStatus(
        true, _waiterMainController.selectedTable.value);
    tempOrder.refresh();
  }

  void changePlateQuantity(PlateModel plate, int quantity) {
    int plateInOrderIndex = tempOrder.value.orderPlates
        .indexWhere((element) => element.plate.code == plate.code);
    if (plateInOrderIndex >= 0) {
      tempOrder.value.orderPlates.elementAt(plateInOrderIndex).quantity =
          quantity;
    }
    tempOrder.refresh();
  }

  void clearTempOrder() {
    tempOrder.value.orderPlates.clear();
  }
}
