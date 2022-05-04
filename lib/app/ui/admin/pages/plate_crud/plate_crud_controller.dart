import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:segundo_muelle/app/data/enums/category_enum.dart';
import 'package:segundo_muelle/app/data/models/plate_model.dart';
import 'package:segundo_muelle/app/widgets/dialogs/confirmation_dialog.dart';
import 'package:segundo_muelle/core/utils/alert_utils.dart';
import 'package:segundo_muelle/core/utils/category_utils.dart';
import 'package:segundo_muelle/main_controller.dart';

class PlateCrudController extends GetxController {
  final MainController _mainController = Get.find();
  List<PlateModel> plates = <PlateModel>[].obs;
  final formKey = GlobalKey<FormState>();

  // add and edit fields
  final selectedCategory = CategoryEnum.starterDish.obs;
  late List<DropdownMenuItem<CategoryEnum>> categoryDropdownMenuItems;

  // add form fields
  final TextEditingController addNameTextController = TextEditingController();
  final TextEditingController addPriceTextController = TextEditingController();
  final TextEditingController addDescriptionTextController =
      TextEditingController();
  final TextEditingController addCodeTextController = TextEditingController();
  final TextEditingController addCategoryTextController =
      TextEditingController();

  // edit form fields
  final TextEditingController editNameTextController = TextEditingController();
  final TextEditingController editPriceTextController = TextEditingController();
  final TextEditingController editDescriptionTextController =
      TextEditingController();
  final TextEditingController editCodeTextController = TextEditingController();
  final TextEditingController editCategoryTextController =
      TextEditingController();

  // filter
  List<CategoryEnum> selectedCategories = <CategoryEnum>[].obs;
  var filterText = ''.obs;

  @override
  void onInit() {
    plates.addAll(_mainController.plateBox.values.toList());
    addCategoryItems();
    selectAllCategories();
    update();
    super.onInit();
  }

  selectAllCategories() {
    selectedCategories.clear();
    selectedCategories.addAll(CategoryEnum.values);
  }

  addCategoryItems() {
    categoryDropdownMenuItems = <DropdownMenuItem<CategoryEnum>>[];
    for (var category in CategoryEnum.values) {
      categoryDropdownMenuItems.add(DropdownMenuItem(
          value: category,
          child: Text(CategoryUtils.getCategoryTypeString(category))));
    }
  }

  onAcceptAddPlate() {
    if (formKey.currentState!.validate()) {
      _mainController.plateBox.add(PlateModel(
          name: addNameTextController.text,
          price: double.parse(addPriceTextController.text),
          description: '',
          code: addCodeTextController.text,
          category: selectedCategory.value));
      formKey.currentState?.reset();
      plates.clear();
      plates.addAll(_mainController.plateBox.values.toList());
      selectAllCategories();
      update();
      Get.back();
      AlertUtils.showSuccess('Plato agregado correctamente');
    }
  }

  onAcceptDelete(int index) async {
    _mainController.plateBox.deleteAt(index);
    plates.clear();
    plates.addAll(_mainController.plateBox.values.toList());
    update();
    Get.back();
    AlertUtils.showSuccess('El plato fue eliminado correctamente');
  }

  onCancelDelete() {
    plates.clear();
    plates.addAll(_mainController.plateBox.values.toList());
    update();
    Get.back();
  }

  onAcceptEditPlate(int index) {
    _mainController.plateBox.putAt(
        index,
        PlateModel(
            name: editNameTextController.text,
            price: double.parse(editPriceTextController.text),
            description: '',
            code: editCodeTextController.text,
            category: selectedCategory.value));
    formKey.currentState?.reset();
    plates.clear();
    plates.addAll(_mainController.plateBox.values.toList());
    update();
    Get.back();
    AlertUtils.showSuccess('El plato se editó correctamente');
  }
}
