import 'package:segundo_muelle/app/data/models/order_model.dart';
import 'package:segundo_muelle/app/data/providers/order_provider.dart';

class OrderRepository {
  final OrderProvider _orderProvider = OrderProvider();

  List<OrderModel> getOrders() {
    return _orderProvider.getOrders();
  }

  OrderModel? getOrder(String key) {
    return _orderProvider.getOrder(key);
  }

  String registerOrder(OrderModel order) {
    return _orderProvider.registerOrder(order);
  }

  void updateOrder(String key, OrderModel order) {
    _orderProvider.updateOrder(key, order);
  }

  void deleteOrder(String key) {
    _orderProvider.deleteOrder(key);
  }
}
