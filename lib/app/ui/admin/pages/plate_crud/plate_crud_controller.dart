import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:segundo_muelle/app/data/enums/category_enum.dart';
import 'package:segundo_muelle/app/data/models/plate_model.dart';
import 'package:segundo_muelle/app/data/repository/plate_repository.dart';
import 'package:segundo_muelle/core/utils/alert_utils.dart';
import 'package:segundo_muelle/core/utils/category_utils.dart';

class PlateCrudController extends GetxController {
  final PlateRepository _plateRepository = Get.find();
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
    setPlates();
    addCategoryItems();
    selectAllCategories();
    update();
    super.onInit();
  }

  selectAllCategories() {
    selectedCategories.clear();
    selectedCategories.addAll(CategoryEnum.values);
    update();
  }

  addCategoryItems() {
    categoryDropdownMenuItems = <DropdownMenuItem<CategoryEnum>>[];
    for (var category in CategoryEnum.values) {
      categoryDropdownMenuItems.add(
        DropdownMenuItem(
          value: category,
          child: Text(
            CategoryUtils.getCategoryTypeString(category),
          ),
        ),
      );
    }
  }

  onAcceptAddPlate() {
    if (formKey.currentState!.validate()) {
      _plateRepository.registerPlate(PlateModel(
          name: addNameTextController.text,
          price: double.parse(addPriceTextController.text),
          description: '',
          code: addCodeTextController.text,
          category: selectedCategory.value));
      formKey.currentState?.reset();
      setPlates();
      selectAllCategories();
      Get.back();
      AlertUtils.showSuccess('Plato agregado correctamente');
    }
  }

  onAcceptDelete(String key) async {
    _plateRepository.deletePlate(key);
    setPlates();
    Get.back();
    AlertUtils.showSuccess('El plato fue eliminado correctamente');
  }

  onCancelDelete() {
    setPlates();
    Get.back();
  }

  onAcceptEditPlate(String key) {
    _plateRepository.updatePlate(
      key,
      PlateModel(
          name: editNameTextController.text,
          price: double.parse(editPriceTextController.text),
          description: '',
          code: editCodeTextController.text,
          category: selectedCategory.value),
    );
    formKey.currentState?.reset();
    setPlates();
    Get.back();
    AlertUtils.showSuccess('El plato se editó correctamente');
  }

  setPlates() {
    plates.clear();
    plates.addAll(_plateRepository.getPlates());
    plates.sort((a, b) => a.code.compareTo(b.code));
    update();
  }
}
