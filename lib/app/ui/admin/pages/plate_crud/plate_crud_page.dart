import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:segundo_muelle/app/data/enums/category_enum.dart';
import 'package:segundo_muelle/app/data/models/plate_model.dart';
import 'package:segundo_muelle/app/ui/admin/pages/plate_crud/plate_crud_controller.dart';
import 'package:segundo_muelle/app/ui/theme/color_theme.dart';
import 'package:segundo_muelle/app/widgets/dialogs/confirmation_dialog.dart';
import 'package:segundo_muelle/app/widgets/slidable_item.dart';
import 'package:segundo_muelle/core/utils/category_utils.dart';

class PlateCrudPage extends StatelessWidget {
  final PlateCrudController _plateCrudController =
      Get.put(PlateCrudController());

  PlateCrudPage({Key? key}) : super(key: key);

  Widget _buildPlateItem({required PlateModel plate, required int index}) {
    var textStyle = const TextStyle(
      fontSize: 15,
      color: Colors.black54,
    );
    var labelStyle = const TextStyle(
      fontSize: 13,
      fontWeight: FontWeight.bold,
      color: Colors.black54,
    );
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Slidable(
        key: ValueKey(plate.code + DateTime.now().toString()),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(6),
          child: Material(
            color: Colors.white,
            child: InkWell(
              onTap: () {},
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      plate.key.toString(),
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.grey,
                      ),
                    ),
                    Row(
                      children: [
                        Text(
                          'Nombre: ',
                          style: labelStyle,
                        ),
                        const SizedBox(width: 10),
                        Text(plate.name, style: textStyle)
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          'Código: ',
                          style: labelStyle,
                        ),
                        const SizedBox(width: 10),
                        Text(plate.code, style: textStyle)
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          'Categoria: ',
                          style: labelStyle,
                        ),
                        const SizedBox(width: 10),
                        Text(
                          CategoryUtils.getCategoryTypeString(plate.category),
                          style: textStyle,
                        )
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          'Precio: ',
                          style: labelStyle,
                        ),
                        const SizedBox(width: 10),
                        Text(
                          'S/ ${plate.price.toStringAsFixed(2)}',
                          style: textStyle,
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        startActionPane: ActionPane(
          motion: const ScrollMotion(),
          dismissible: DismissiblePane(onDismissed: () {
            onDeletePlatePress(plate.key);
          }),
          children: [
            SlidableItem(
                backgroundColor: Colors.redAccent,
                onTap: () {
                  onDeletePlatePress(plate.key);
                },
                icon: const Icon(
                  Iconsax.trash,
                  color: Colors.white,
                )),
            SlidableItem(
                backgroundColor: Colors.blueAccent,
                onTap: () {
                  onEditPlatePress(index, plate);
                },
                icon: const Icon(
                  Iconsax.edit,
                  color: Colors.white,
                )),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchInput() {
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        Expanded(
          child: TextFormField(
            decoration: const InputDecoration(
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: ColorTheme.inputBorderGrey),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(6),
                      bottomLeft: Radius.circular(6))),
              disabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: ColorTheme.inputBorderGrey),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(6),
                      bottomLeft: Radius.circular(6))),
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: ColorTheme.primary),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(6),
                      bottomLeft: Radius.circular(6))),
              focusedErrorBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.red),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(6),
                      bottomLeft: Radius.circular(6))),
              errorBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.red),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(6),
                      bottomLeft: Radius.circular(6))),
              labelText: 'Buscar plato',
              prefixIcon: Icon(Iconsax.search_normal),
            ),
            onChanged: (value) {
              _plateCrudController.filterText(value);
            },
          ),
        ),
        ElevatedButton(
            style: ElevatedButton.styleFrom(
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(6),
                  bottomRight: Radius.circular(6),
                ),
              ),
              padding: const EdgeInsets.symmetric(vertical: 14),
              elevation: 0,
            ),
            onPressed: () {
              onFilterButtonPress();
            },
            child: const Icon(Iconsax.setting_4)),
      ],
    );
  }

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
          onPressed: () async {
            onAddPlatePress();
          },
          icon: const Icon(Iconsax.add),
          tooltip: 'Añadir Plato',
        )
      ],
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text('Editar Platos'),
        ],
      ),
    );
  }

  void onFilterButtonPress() async {
    Get.bottomSheet(Container(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10),
            topRight: Radius.circular(10),
          ),
        ),
        child: Obx(() {
          return SingleChildScrollView(
              child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Selecciona algúna categoría',
                  style: TextStyle(
                      color: ColorTheme.primary,
                      fontSize: 16,
                      fontWeight: FontWeight.bold)),
              const SizedBox(height: 10),
              ...CategoryEnum.values
                  .map((category) => CheckboxListTile(
                        contentPadding: const EdgeInsets.symmetric(vertical: 0),
                        title:
                            Text(CategoryUtils.getCategoryTypeString(category)),
                        value: _plateCrudController.selectedCategories
                            .contains(category),
                        onChanged: (selected) {
                          if (selected!) {
                            _plateCrudController.selectedCategories
                                .add(category);
                          } else {
                            _plateCrudController.selectedCategories
                                .remove(category);
                          }
                        },
                      ))
                  .toList()
            ],
          ));
        })));
  }

  void onDeletePlatePress(String key) {
    showDialog(
      context: Get.overlayContext!,
      builder: (context) => ConfirmationDialog(
        title: 'Eliminar',
        denyButtonText: 'Cancelar',
        subtitle: '¿Estás seguro de eliminar el plato?',
        acceptButtonText: 'Eliminar',
        onDeny: () {
          _plateCrudController.onCancelDelete();
        },
        onAccept: () {
          _plateCrudController.onAcceptDelete(key);
        },
      ),
    );
  }

  void onEditPlatePress(int index, PlateModel plate) {
    _plateCrudController.editNameTextController.text = plate.name;
    _plateCrudController.editCodeTextController.text = plate.code;
    _plateCrudController.editPriceTextController.text =
        plate.price.toStringAsFixed(2);
    _plateCrudController.selectedCategory(plate.category);
    Get.bottomSheet(
        Container(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
              ),
            ),
            child: SingleChildScrollView(
                child: Form(
              key: _plateCrudController.formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Editar Plato',
                      style: TextStyle(
                          color: ColorTheme.primary,
                          fontSize: 16,
                          fontWeight: FontWeight.bold)),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: _plateCrudController.editCodeTextController,
                    decoration: const InputDecoration(labelText: 'Código'),
                    // validator: _validateTewTableNameTextController,
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: _plateCrudController.editNameTextController,
                    decoration:
                        const InputDecoration(labelText: 'Nombre del Plato'),
                    // validator: _validateTewTableNameTextController,
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: _plateCrudController.editPriceTextController,
                    decoration: const InputDecoration(labelText: 'Precio'),
                    // validator: _validateTewTableNameTextController,
                  ),
                  const SizedBox(height: 20),
                  DropdownButtonFormField<CategoryEnum>(
                    decoration: const InputDecoration(labelText: 'Categoría'),
                    isExpanded: true,
                    value: _plateCrudController.selectedCategory.value,
                    items: _plateCrudController.categoryDropdownMenuItems,
                    onChanged: (CategoryEnum? value) {
                      _plateCrudController.selectedCategory(value);
                    },
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                        child: TextButton(
                            style: TextButton.styleFrom(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 20),
                              shape: const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(6)),
                              ),
                            ),
                            onPressed: () {
                              Get.back();
                            },
                            child: const Text(
                              'Cancelar',
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  color: ColorTheme.primary),
                            )),
                      ),
                      const SizedBox(width: 20),
                      Expanded(
                          child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          elevation: 0,
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 20),
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(6)),
                          ),
                        ),
                        onPressed: () {
                          _plateCrudController.onAcceptEditPlate(plate.key);
                        },
                        child: const Text(
                          'Editar',
                          style: TextStyle(fontWeight: FontWeight.w500),
                        ),
                      ))
                    ],
                  )
                ],
              ),
            ))),
        enableDrag: true);
  }

  void onAddPlatePress() {
    Get.bottomSheet(
        Container(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
              ),
            ),
            child: SingleChildScrollView(
                child: Form(
              key: _plateCrudController.formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Añadir Plato',
                      style: TextStyle(
                          color: ColorTheme.primary,
                          fontSize: 16,
                          fontWeight: FontWeight.bold)),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: _plateCrudController.addCodeTextController,
                    decoration: const InputDecoration(labelText: 'Código'),
                    // validator: _validateTewTableNameTextController,
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: _plateCrudController.addNameTextController,
                    decoration:
                        const InputDecoration(labelText: 'Nombre del Plato'),
                    // validator: _validateTewTableNameTextController,
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: _plateCrudController.addPriceTextController,
                    decoration: const InputDecoration(labelText: 'Precio'),
                    // validator: _validateTewTableNameTextController,
                  ),
                  const SizedBox(height: 20),
                  DropdownButtonFormField<CategoryEnum>(
                    decoration: const InputDecoration(labelText: 'Categoría'),
                    isExpanded: true,
                    value: _plateCrudController.selectedCategory.value,
                    items: _plateCrudController.categoryDropdownMenuItems,
                    onChanged: (CategoryEnum? value) {
                      _plateCrudController.selectedCategory(value);
                    },
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                        child: TextButton(
                            style: TextButton.styleFrom(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 20),
                              shape: const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(6)),
                              ),
                            ),
                            onPressed: () {
                              Get.back();
                            },
                            child: const Text(
                              'Cancelar',
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  color: ColorTheme.primary),
                            )),
                      ),
                      const SizedBox(width: 20),
                      Expanded(
                          child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          elevation: 0,
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 20),
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(6)),
                          ),
                        ),
                        onPressed: () {
                          _plateCrudController.onAcceptAddPlate();
                        },
                        child: const Text(
                          'Añadir',
                          style: TextStyle(fontWeight: FontWeight.w500),
                        ),
                      ))
                    ],
                  )
                ],
              ),
            ))),
        enableDrag: true);
  }

  bool filterPlates(PlateModel plate) {
    bool selectedCategoriesEmpty =
        _plateCrudController.selectedCategories.isEmpty;
    bool filterTextEmpty = _plateCrudController.filterText.value.isEmpty;
    bool selectedCategoriesContain =
        _plateCrudController.selectedCategories.contains(plate.category);
    bool filterTextContain = plate.name
        .toLowerCase()
        .contains(_plateCrudController.filterText.value.toLowerCase());
    return (selectedCategoriesEmpty && filterTextEmpty) ||
        (selectedCategoriesContain && filterTextContain);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: const Color(0xFFEDF0F4),
      appBar: _buildAppBar(),
      body: Obx(() {
        if (_plateCrudController.plates.isEmpty) {
          return Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: const [
                Icon(Iconsax.note_remove, size: 60, color: Colors.grey),
                SizedBox(height: 15),
                Text(
                  'Añade un nuevo plato',
                  style: TextStyle(color: Colors.grey, fontSize: 15),
                )
              ],
            ),
          );
        }
        return Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 20, right: 20, top: 20, bottom: 90),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildSearchInput(),
                      const SizedBox(
                        height: 20,
                      ),
                      ..._plateCrudController.plates
                          .where(filterPlates)
                          .toList()
                          .asMap()
                          .map((index, element) {
                            return MapEntry(index,
                                _buildPlateItem(plate: element, index: index));
                          })
                          .values
                          .toList(),
                    ],
                  ),
                ),
              ),
            ),
          ],
        );
      }),
    );
  }
}
