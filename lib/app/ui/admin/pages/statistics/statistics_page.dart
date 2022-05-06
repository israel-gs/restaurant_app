import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:segundo_muelle/app/ui/login/pages/login_page.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:share/share.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:ui' as ui;

class OrderTemp {
  final int id;
  final String name;
  final int quantity;

  OrderTemp({required this.id, required this.name, required this.quantity});
}

class StatisticsPage extends StatelessWidget {
  StatisticsPage({Key? key}) : super(key: key);

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

  Future<Uint8List?> _captureImageFromWidget() async {
    print('ga');
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
    List<OrderTemp> data = [
      OrderTemp(id: 0, name: 'Israel Gutierrez', quantity: 50),
      OrderTemp(id: 1, name: 'Fernando Zapata.', quantity: 44),
      OrderTemp(id: 2, name: 'Cesar Vazsquez', quantity: 15),
    ];

    List<OrderTemp> data2 = [
      OrderTemp(id: 0, name: 'Ceviche', quantity: 40),
      OrderTemp(id: 1, name: 'Chicha 1L.', quantity: 38),
      OrderTemp(id: 2, name: 'Limonada 1L.', quantity: 22),
    ];

    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: const Color(0xFFEDF0F4),
      appBar: _buildAppBar(),
      body: SingleChildScrollView(
        child: RepaintBoundary(
          key: _globalKey,
          child: Container(
            color: const Color(0xFFEDF0F4),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 40),
                const Text('Atenciones por mesero'),
                Center(
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height * 0.4,
                    width: MediaQuery.of(context).size.width * 0.9,
                    child: charts.BarChart(
                      [
                        charts.Series<OrderTemp, String>(
                          id: 'Sales',
                          colorFn: (_, __) =>
                              charts.MaterialPalette.blue.shadeDefault,
                          domainFn: (OrderTemp sales, _) => sales.name.toString(),
                          measureFn: (OrderTemp sales, _) => sales.quantity,
                          data: data,
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
                      charts.Series<OrderTemp, int>(
                        id: 'Sales2',
                        domainFn: (OrderTemp sales, _) => sales.id,
                        measureFn: (OrderTemp sales, _) => sales.quantity,
                        data: data2,
                        labelAccessorFn: (OrderTemp row, _) =>
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
                const SizedBox(height: 60),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
