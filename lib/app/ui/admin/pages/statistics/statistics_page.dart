import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:segundo_muelle/app/ui/admin/pages/statistics/statistics_controller.dart';
import 'package:share/share.dart';

class StatisticsPage extends StatelessWidget {
  StatisticsPage({Key? key}) : super(key: key);
  final StatisticsController _statisticsController =
      Get.put(StatisticsController());
  final GlobalKey _globalKey = GlobalKey();

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
            _captureImageFromWidget();
          },
          icon: const Icon(Iconsax.document_download),
        )
      ],
      title: Row(
        children: const [
          Text('Hola '),
          Text(
            'Israel',
            style: TextStyle(fontWeight: FontWeight.bold),
          )
        ],
      ),
    );
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

  Future<Uint8List?> _captureImageFromWidget() async {
    try {
      RenderRepaintBoundary boundary = _globalKey.currentContext!
          .findRenderObject() as RenderRepaintBoundary;
      ui.Image image = await boundary.toImage(pixelRatio: 3.0);
      ByteData? byteData =
          await (image.toByteData(format: ui.ImageByteFormat.png));
      if (byteData != null) {
        Uint8List pngBytes = byteData.buffer.asUint8List();
        final tempDir = await getTemporaryDirectory();
        String imagePath = '${tempDir.path}/constancia-1.png';
        final file = await File(imagePath).create();
        await file.writeAsBytes(pngBytes);
        await Share.shareFiles([imagePath]);
        return pngBytes;
      } else {
        return null;
      }
    } on Exception catch (_) {
      print(_);
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: const Color(0xFFEDF0F4),
      appBar: _buildAppBar(),
      body: SingleChildScrollView(
        child: Container(
          color: const Color(0xFFEDF0F4),
          child: Obx(() {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildDateInput(),
                const SizedBox(height: 40),
                RepaintBoundary(
                    key: _globalKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text('Atenciones por mesero'),
                        Center(
                          child: SizedBox(
                            height: MediaQuery.of(context).size.height * 0.4,
                            width: MediaQuery.of(context).size.width * 0.9,
                            child: charts.BarChart(
                              [
                                charts.Series<GraphModel, String>(
                                  id: 'Sales',
                                  colorFn: (_, __) =>
                                      charts.MaterialPalette.blue.shadeDefault,
                                  domainFn: (GraphModel sales, _) =>
                                      sales.name.toString(),
                                  measureFn: (GraphModel sales, _) =>
                                      sales.quantity,
                                  data: _statisticsController.userSales.value,
                                )
                              ],
                              animate: true,
                            ),
                          ),
                        ),
                        const SizedBox(height: 40),
                        const Text('Platos mas vendidos'),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.4,
                          child: charts.PieChart(
                            [
                              charts.Series<GraphModel, String>(
                                id: 'Sales2',
                                domainFn: (GraphModel sales, _) => sales.id,
                                measureFn: (GraphModel sales, _) =>
                                    sales.quantity,
                                data: _statisticsController.plateSales.value,
                                labelAccessorFn: (GraphModel row, _) =>
                                    '${row.name}:${row.quantity}',
                              )
                            ],
                            defaultRenderer: charts.ArcRendererConfig<Object>(
                              arcRendererDecorators: [
                                charts.ArcLabelDecorator(),
                              ],
                            ),
                            animate: true,
                          ),
                        ),
                      ],
                    )),
                const SizedBox(height: 100),
              ],
            );
          }),
        ),
      ),
    );
  }
}
