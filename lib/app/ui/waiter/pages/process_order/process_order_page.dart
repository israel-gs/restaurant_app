import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:segundo_muelle/app/ui/theme/color_theme.dart';
import 'package:segundo_muelle/app/ui/waiter/pages/plate_selection/plate_selection_controller.dart';
import 'package:segundo_muelle/app/ui/waiter/pages/process_order/process_order_controller.dart';
import 'package:segundo_muelle/app/ui/waiter/pages/waiter_main_controller.dart';

const String CURRENCY_REGEX = '^\$|^(0|([1-9][0-9]{0,}))(\\.[0-9]{0,2})?\$';

class ProcessOrderPage extends StatelessWidget {
  ProcessOrderPage({Key? key}) : super(key: key);

  final WaiterMainController _waiterMainController = Get.find();
  final PlateSelectionController _plateSelectionController = Get.find();
  final ProcessOrderController _processOrderController =
      Get.put(ProcessOrderController());

  AppBar _buildAppBar() {
    return AppBar(
      leading: IconButton(
        icon: const Icon(
          Iconsax.arrow_left_2,
          color: Colors.black,
        ),
        iconSize: 16,
        tooltip: 'Retroceder',
        onPressed: () => Navigator.of(Get.context!).maybePop(),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      titleTextStyle:
          const TextStyle(color: Colors.black, fontFamily: 'Poppins'),
      toolbarTextStyle: const TextStyle(
        color: Colors.black,
      ),
      actionsIconTheme: const IconThemeData(
        color: Colors.black,
      ),
      actions: [
        IconButton(
          onPressed: () {},
          icon: const Icon(Iconsax.menu),
        )
      ],
      title: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Total para la '),
          Text(
            _waiterMainController.selectedTable.value.name,
            style: const TextStyle(fontWeight: FontWeight.bold),
          )
        ],
      ),
    );
  }

  Widget _buildAmountText() {
    var amount = _plateSelectionController.tempOrder.value.orderPlates
        .map((e) => e.quantity * e.plate.price)
        .reduce((a, b) => a + b);
    amount = amount + _plateSelectionController.tempOrder.value.tip;
    return Text(
      'S/ ${amount.toStringAsFixed(2)}',
      style: const TextStyle(
        fontSize: 32,
        fontWeight: FontWeight.bold,
        color: Color(0xFF1E1E1E),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: const Color(0xFFEDF0F4),
      appBar: _buildAppBar(),
      body: Obx(
        () => SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 50),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  'Total a pagar:',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.normal,
                  ),
                ),
                _buildAmountText(),
                const SizedBox(height: 90),
                TextField(
                  controller: _processOrderController.amountController,
                  decoration: const InputDecoration(
                    hintText: 'Ingrese su propina',
                    labelText: 'Propina',
                  ),
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(CURRENCY_REGEX)),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          elevation: 0,
                          padding: const EdgeInsets.all(16),
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(6)),
                          ),
                        ),
                        onPressed: () {
                          _processOrderController.addTip();
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Text(
                              'Recalcular',
                              style: TextStyle(fontWeight: FontWeight.w500),
                            ),
                            SizedBox(width: 8),
                            Icon(Iconsax.refresh),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: TextButton(
                        style: TextButton.styleFrom(
                          padding: const EdgeInsets.all(16),
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(6)),
                          ),
                        ),
                        onPressed: _processOrderController.onCloseTable,
                        child: const Text(
                          'Cerrar mesa',
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: ColorTheme.primary),
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
