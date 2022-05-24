import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';
import 'package:segundo_muelle/app/ui/login/pages/login_page.dart';
import 'package:segundo_muelle/app/ui/waiter/pages/statistics/statistics_controller.dart';
import 'package:segundo_muelle/main_controller.dart';

class StatisticsPage extends StatelessWidget {
  StatisticsPage({Key? key}) : super(key: key);

  final StatisticsController _statisticsController =
      Get.put(StatisticsController());

  final MainController _mainController = Get.find();

  _buildAppBar() {
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.transparent,
      titleTextStyle: const TextStyle(
          color: Colors.black, fontFamily: 'Poppins', fontSize: 20),
      toolbarTextStyle: const TextStyle(
        color: Colors.black,
      ),
      actionsIconTheme: const IconThemeData(
        color: Colors.black,
      ),
      actions: [
        IconButton(
          onPressed: () {
            Get.offAll(() => const LoginPage());
          },
          icon: const Icon(Iconsax.logout),
        )
      ],
      title: Row(
        children: [
          const Text('Hola '),
          Text(
            _mainController.currentUser.value.name,
            style: const TextStyle(fontWeight: FontWeight.bold),
          )
        ],
      ),
    );
  }

  _buildTableRows() {
    var dateFormat = DateFormat('dd/MM/yyyy HH:mm');
    return _statisticsController.sales.value.map((order) {
      var amount = order.orderPlates
          .map((e) => e.quantity * e.plate.price)
          .reduce((a, b) => a + b)
          .toStringAsFixed(2);
      return DataRow(
        cells: [
          DataCell(
            Text(order.key.toString()),
          ),
          DataCell(
            Text(order.table.name),
          ),
          DataCell(Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: order.orderPlates.map((e) {
              return Text(
                e.plate.name + '    ' + e.quantity.toString(),
                style: const TextStyle(fontSize: 12),
              );
            }).toList(),
          )),
          DataCell(
            Text(dateFormat.format(order.date)),
          ),
          DataCell(Text(amount)),
        ],
      );
    }).toList();
  }

  _buildDateInput() {
    var format = DateFormat('dd/MM/yyyy');
    String startDate =
        format.format(_statisticsController.dateTimeRange.value.start);
    String endDate =
        format.format(_statisticsController.dateTimeRange.value.end);
    return Container(
      margin: const EdgeInsets.only(top: 20, left: 20, right: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            'Fecha',
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 16,
              color: Color(0xFF5F6C7E),
            ),
          ),
          GestureDetector(
            onTap: () {
              _statisticsController.showDateRangeModal();
            },
            child: Container(
              padding: const EdgeInsets.symmetric(
                vertical: 15,
                horizontal: 20,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(5),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    startDate + ' - ' + endDate,
                    style: const TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 16,
                      color: Color(0xFF5F6C7E),
                    ),
                  ),
                  const SizedBox(width: 10),
                  const Icon(
                    Iconsax.calendar,
                    color: Color(0xFF5F6C7E),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  _buildExportButton() {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
              child: ElevatedButton.icon(
                icon: _statisticsController.loadingExport.value
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 2,
                        ),
                      )
                    : const Icon(
                        Iconsax.document_download,
                        color: Colors.white,
                        size: 20,
                      ),
                style: ElevatedButton.styleFrom(
                  primary: const Color(0xFF1D6F42),
                  elevation: 0,
                  padding: const EdgeInsets.all(16),
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(6)),
                  ),
                ),
                onPressed: _statisticsController.exportToExcel,
                label: const Text(
                  'Exportar',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
              ),
            )
          ],
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      backgroundColor: const Color(0xFFEDF0F4),
      appBar: _buildAppBar(),
      body: Obx(() {
        return SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildDateInput(),
              const SizedBox(height: 20),
              _buildExportButton(),
              const SizedBox(height: 40),
              SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 120),
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    child: DataTable(
                      dataRowHeight: 80,
                      columns: const [
                        DataColumn(
                          label: Text('ID'),
                        ),
                        DataColumn(
                          label: Text('Mesa'),
                        ),
                        DataColumn(
                          label: Text('Platos'),
                        ),
                        DataColumn(label: Text('Fecha')),
                        DataColumn(label: Text('Total')),
                      ],
                      rows: _buildTableRows(),
                    ),
                  ),
                ),
              )
            ],
          ),
        );
      }),
    );
  }
}
