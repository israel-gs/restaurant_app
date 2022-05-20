import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:segundo_muelle/app/data/models/order_plate_model.dart';
import 'package:segundo_muelle/app/ui/waiter/pages/plate_selection/plate_selection_controller.dart';
import 'package:segundo_muelle/app/ui/waiter/pages/process_order/process_order_page.dart';
import 'package:segundo_muelle/app/ui/waiter/pages/waiter_main_controller.dart';
import 'package:segundo_muelle/app/ui/waiter/widgets/quantity_button_widget.dart';

class TableOrderPage extends StatelessWidget {
  TableOrderPage({Key? key}) : super(key: key);

  final WaiterMainController _waiterMainController = Get.find();
  final PlateSelectionController _plateSelectionController = Get.find();

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
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Listado de pedidos para la '),
          Text(
            _waiterMainController.selectedTable.value.name,
            style: const TextStyle(fontWeight: FontWeight.bold),
          )
        ],
      ),
    );
  }

  Widget _buildFloatingActionButton() {
    return FloatingActionButton(
      onPressed: () {
        Get.to(() => ProcessOrderPage());
      },
      child: const Icon(Iconsax.calculator),
    );
  }

  Widget _buildOrderItem(OrderPlateModel orderPlate) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(6)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(orderPlate.plate.code,
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(width: 10),
                  Text(orderPlate.plate.name),
                  Row(
                    children: [
                      const Text('S/. ',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                              color: Colors.black)),
                      Text(
                        orderPlate.plate.price.toStringAsFixed(2),
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: Colors.black),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            QuantityButtonWidget(
              quantity: orderPlate.quantity,
              onChange: (quantity) {
                _plateSelectionController.changePlateQuantity(
                    orderPlate.plate, quantity);
              },
            )
          ],
        ),
      ),
    );
  }

  List<Widget> _buildOrderList() {
    return _plateSelectionController.tempOrder.value.orderPlates
        .map((orderPlate) => _buildOrderItem(orderPlate))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: const Color(0xFFEDF0F4),
      appBar: _buildAppBar(),
      floatingActionButton: _buildFloatingActionButton(),
      body: Column(
        children: [
          Expanded(
            child: Obx(() {
              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 20,
                          ),
                          ..._buildOrderList(),
                          const SizedBox(
                            height: 20,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}
