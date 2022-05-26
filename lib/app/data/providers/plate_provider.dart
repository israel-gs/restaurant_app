import 'package:get/get.dart';
import 'package:segundo_muelle/app/data/models/plate_model.dart';
import 'package:segundo_muelle/main_controller.dart';
import 'package:uuid/uuid.dart';

class PlateProvider {
  final MainController _mainController = Get.find();

  Future<String> registerPlate(PlateModel plate) async {
    var uuid = const Uuid();
    var key = uuid.v4();
    await _mainController.plateBox.put(key, plate);
    return key;
  }

  Future<void> updatePlate(String key, PlateModel plate) async {
    await _mainController.plateBox.put(key, plate);
  }

  void deletePlate(String key) async {
    await _mainController.plateBox.delete(key);
  }

  List<PlateModel> getPlates() {
    return _mainController.plateBox.values.toList();
  }
}
