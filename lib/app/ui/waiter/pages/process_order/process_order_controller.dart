import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:segundo_muelle/app/ui/waiter/pages/plate_selection/plate_selection_controller.dart';
import 'package:segundo_muelle/app/widgets/dialogs/confirmation_dialog.dart';

class ProcessOrderController extends GetxController {
  final PlateSelectionController _plateSelectionController = Get.find();
  TextEditingController amountController = TextEditingController();

  @override
  void onInit() {
    amountController.text =
        _plateSelectionController.tempOrder.value.tip.toString();
    super.onInit();
  }

  addTip() {
    var tip = double.parse(amountController.text);
    _plateSelectionController.addTip(tip);
  }

  onCloseTable() {
    showDialog(
      context: Get.overlayContext!,
      builder: (context) => ConfirmationDialog(
        title: 'Advertencia',
        denyButtonText: 'Cancelar',
        subtitle: '¿Estás seguro de cerrar la mesa?',
        acceptButtonText: 'Cerrar mesa',
        onDeny: () {
          Get.back();
        },
        onAccept: () {
          _plateSelectionController.closeOrder();
        },
      ),
    );
  }
}
