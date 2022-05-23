import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:segundo_muelle/main_controller.dart';

class GraphModel {
  final String id;
  final String name;
  int quantity;

  GraphModel({required this.id, required this.name, required this.quantity});
}

class StatisticsController extends GetxController {
  final MainController _mainController = Get.find();
  var firstDate = DateTime.now().subtract(const Duration(days: 300));
  var lastDate = DateTime.now();
  var dateTimeRange = Rx<DateTimeRange>(
    DateTimeRange(
        start: DateTime.now().subtract(const Duration(days: 30)),
        end: DateTime.now()),
  );
  var userSales = Rx<List<GraphModel>>([]);
  var plateSales = Rx<List<GraphModel>>([]);

  @override
  void onInit() {
    getSalesByUser();
    getSalesByPlate();
    super.onInit();
  }

  getSalesByUser() {
    userSales.value.clear();
    _mainController.orderBox.values.toList().forEach((order) {
      if ((order.date.isAfter(dateTimeRange.value.start) &&
              order.date.isBefore(dateTimeRange.value.end)) &&
          order.orderClosed) {
        GraphModel? userExist = userSales.value
            .firstWhereOrNull((element) => element.name == order.user.name);
        if (userExist != null) {
          userExist.quantity = userExist.quantity + 1;
        } else {
          userSales.value.add(GraphModel(
            id: order.key,
            name: order.user.name,
            quantity: 1,
          ));
        }
      }
    });
  }

  getSalesByPlate() {
    plateSales.value.clear();
    _mainController.orderBox.values.toList().forEach((order) {
      if ((order.date.isAfter(dateTimeRange.value.start) &&
              order.date.isBefore(dateTimeRange.value.end)) &&
          order.orderClosed) {
        print('----------------------------');
        print(order.key);
        print(order.date);
        print('Cantidad de platos: ${order.orderPlates.length}');
        for (var plate in order.orderPlates) {
          print(plate.plate.name);
          GraphModel? plateExist = plateSales.value
              .firstWhereOrNull((element) => element.name == plate.plate.name);
          if (plateExist != null) {
            plateExist.quantity = plateExist.quantity + plate.quantity;
          } else {
            plateSales.value.add(GraphModel(
              id: plate.plate.name,
              name: plate.plate.name,
              quantity: 1,
            ));
          }
        }
      }
    });
  }

  showDateRangeModal() {
    showDateRangePicker(
      context: Get.overlayContext!,
      firstDate: firstDate,
      lastDate: lastDate,
      initialDateRange: dateTimeRange.value,
      locale: Locale('es', 'ES'),
    ).then((value) {
      if (value != null) {
        var end = value.end.add(const Duration(hours: 23, minutes: 59));
        dateTimeRange(DateTimeRange(start: value.start, end: end));
        getSalesByUser();
        getSalesByPlate();
      }
    });
  }
}
