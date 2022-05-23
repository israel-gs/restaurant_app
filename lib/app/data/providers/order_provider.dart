import 'package:get/get.dart';
import 'package:segundo_muelle/app/data/models/order_model.dart';
import 'package:segundo_muelle/main_controller.dart';
import 'package:uuid/uuid.dart';

class OrderProvider {
  final MainController _mainController = Get.find();

  List<OrderModel> getOrders() {
    return _mainController.orderBox.values.toList();
  }

  OrderModel? getOrder(String key) {
    return _mainController.orderBox.get(key);
  }

  String registerOrder(OrderModel order) {
    var uuid = const Uuid();
    var key = uuid.v4();
    _mainController.orderBox.put(key, order);
    return key;
  }

  void updateOrder(String key, OrderModel order) {
    _mainController.orderBox.put(key, order);
  }

  void deleteOrder(String key) {
    _mainController.orderBox.delete(key);
  }
}
