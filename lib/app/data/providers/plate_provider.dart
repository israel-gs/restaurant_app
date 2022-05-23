import 'package:get/get.dart';
import 'package:segundo_muelle/app/data/models/plate_model.dart';
import 'package:segundo_muelle/main_controller.dart';

class PlateProvider {
  final MainController _mainController = Get.find();

  List<PlateModel> getPlates() {
    return _mainController.plateBox.values.toList();
  }
}
