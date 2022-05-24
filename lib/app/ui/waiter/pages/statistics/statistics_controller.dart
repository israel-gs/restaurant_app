import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:segundo_muelle/app/data/models/order_model.dart';
import 'package:segundo_muelle/main_controller.dart';
import 'package:share/share.dart';
import 'package:syncfusion_flutter_xlsio/xlsio.dart';

class StatisticsController extends GetxController {
  final MainController _mainController = Get.find();

  var sales = Rx<List<OrderModel>>([]);
  var loadingExport = Rx<bool>(false);

  var firstDate = DateTime.now().subtract(const Duration(days: 300));
  var lastDate = DateTime.now();
  var dateTimeRange = Rx<DateTimeRange>(
    DateTimeRange(
        start: DateTime.now().subtract(const Duration(days: 1)),
        end: DateTime.now()),
  );

  @override
  void onInit() {
    getSales();
    super.onInit();
  }

  getSales() {
    sales.value.clear();
    var orders = _mainController.orderBox.values
        .toList()
        .where((order) =>
            (order.user.username ==
                _mainController.currentUser.value.username) &&
            order.date.isAfter(dateTimeRange.value.start) &&
            order.date.isBefore(dateTimeRange.value.end) &&
            order.orderClosed)
        .toList();
    orders.sort((a, b) => b.date.compareTo(a.date));
    sales(orders);
  }

  showDateRangeModal() {
    showDateRangePicker(
      context: Get.overlayContext!,
      firstDate: firstDate,
      lastDate: lastDate,
      initialDateRange: dateTimeRange.value,
      locale: const Locale('es', 'ES'),
    ).then((value) {
      if (value != null) {
        var end = value.end.add(const Duration(hours: 23, minutes: 59));
        dateTimeRange(DateTimeRange(start: value.start, end: end));
        getSales();
      }
    });
  }

  exportToExcel() async {
    loadingExport(true);
    final Workbook workbook = Workbook();
    final Worksheet sheet = workbook.worksheets[0];
    sheet.getRangeByName('A1').setText('ID');
    sheet.getRangeByName('B1').setText('MESA');
    sheet.getRangeByName('C1').setText('PLATOS');
    sheet.getRangeByName('D1').setText('FECHA');
    sheet.getRangeByName('E1').setText('PROPINA');
    sheet.getRangeByName('F1').setText('TOTAL');
    for (var i = 0; i < sales.value.length; i++) {
      var order = sales.value[i];
      var amount = order.orderPlates
          .map((e) => e.quantity * e.plate.price)
          .reduce((a, b) => a + b);
      sheet.getRangeByName('A${i + 2}').setText(order.key.toString());
      sheet.getRangeByName('B${i + 2}').setText(order.table.name);
      sheet.getRangeByName('C${i + 2}').setText(
            order.orderPlates
                .map((e) => e.plate.name + '    ' + e.quantity.toString())
                .join('\n'),
          );
      sheet.getRangeByName('D${i + 2}').setDateTime(order.date);
      sheet.getRangeByName('E${i + 2}').setNumber(order.tip);
      sheet.getRangeByName('F${i + 2}').setNumber(amount);
    }
    final tempDir = await getTemporaryDirectory();
    String excelPath =
        '${tempDir.path}/VENTAS_${_mainController.currentUser.value.name.toUpperCase().replaceAll(' ', '_')}.xlsx';
    final List<int> bytes = workbook.saveAsStream();
    final file = await File(excelPath).writeAsBytes(bytes);
    await Share.shareFiles([file.path]);
    workbook.dispose();
    loadingExport(false);
  }
}
