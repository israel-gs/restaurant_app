import 'package:get/get.dart';
import 'package:segundo_muelle/app/data/enums/category_enum.dart';
import 'package:segundo_muelle/app/data/models/plate_model.dart';
import 'package:segundo_muelle/main_controller.dart';

class PlateSelectionController extends GetxController {
  final MainController _mainController = Get.find();
  var selectedCategory = CategoryEnum.starterDish.obs;
  List<PlateModel> plates = <PlateModel>[].obs;

  @override
  void onInit() {
    plates.addAll(_mainController.plateBox.values.toList());
    update();
    super.onInit();
  }
}
