import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:segundo_muelle/app/data/enums/category_enum.dart';
import 'package:segundo_muelle/app/data/models/plate_model.dart';
import 'package:segundo_muelle/app/ui/waiter/pages/plate_selection/plate_selection_controller.dart';
import 'package:segundo_muelle/app/ui/theme/color_theme.dart';
import 'package:segundo_muelle/app/ui/waiter/pages/table_order/table_order_page.dart';
import 'package:segundo_muelle/app/ui/waiter/pages/waiter_main_controller.dart';
import 'package:segundo_muelle/core/utils/category_utils.dart';

class PlateSelectionPage extends StatefulWidget {
  const PlateSelectionPage({Key? key}) : super(key: key);

  @override
  _PlateSelectionPageState createState() => _PlateSelectionPageState();
}

class _PlateSelectionPageState extends State<PlateSelectionPage> {
  final PlateSelectionController _plateSelectionController =
  Get.put(PlateSelectionController());
  final WaiterMainController _waiterMainController = Get.find();

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
          const Text('Selecciona el pedido para la '),
          Text(
            _waiterMainController.selectedTable.value.name,
            style: const TextStyle(fontWeight: FontWeight.bold),
          )
        ],
      ),
    );
  }

  Widget _buildFloatingActionButton() {
    return Obx(() {
      int count = 0;
      for (var element in _plateSelectionController.tempOrder.value.orderPlates) {
        count += element.quantity;
      }
      return count > 0 ? Badge(
        showBadge: count > 0,
        position: BadgePosition.bottomStart(),
        badgeContent:
        Text(count.toString(), style: const TextStyle(color: Colors.white)),
        child: FloatingActionButton(
          onPressed: () {
            Get.to(() => TableOrderPage());
          },
          child: const Icon(Iconsax.bag),
        ),
      ): Container();
    });
  }

  Widget _buildPlateItem(PlateModel plate) {
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
              flex: 2,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(plate.code,
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(width: 10),
                  Text(plate.name),
                  Row(
                    children: [
                      const Text('S/. ',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                              color: Colors.black)),
                      Text(
                        plate.price.toStringAsFixed(2),
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
            Expanded(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                  ),
                  onPressed: () {
                    _plateSelectionController.addPlateToOrder(plate);
                  },
                  child: const Icon(
                    Iconsax.shop_add4,
                    color: Colors.white,
                  ),
                ))
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryItem(CategoryEnum category) {
    bool isSelected =
        category == _plateSelectionController.selectedCategory.value;
    return Padding(
      padding: const EdgeInsets.only(right: 20),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(6),
        child: Material(
          child: InkWell(
            onTap: () {
              setState(() {
                _plateSelectionController.selectedCategory(category);
              });
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 150),
              color: isSelected ? ColorTheme.primary : Colors.white,
              width: 95,
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
              child: Column(
                children: [
                  Image.asset(CategoryUtils.getCategoryImagePath(category),
                      height: 40),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    CategoryUtils.getCategoryTypeString(category),
                    style: TextStyle(
                        fontSize: 10,
                        fontWeight:
                        (isSelected) ? FontWeight.bold : FontWeight.normal,
                        color: (isSelected) ? Colors.white : Colors.black),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPlatesList() {
    return SingleChildScrollView(
      child: Wrap(
        children: _plateSelectionController.plates
            .where(filterPlates)
            .map(
              (plate) => _buildPlateItem(plate),
        )
            .toList(),
      ),
    );
  }

  Widget _buildCategoriesList() {
    return SizedBox(
      height: 100,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: CategoryEnum.values
            .map((category) => _buildCategoryItem(category))
            .toList(),
      ),
    );
  }

  bool filterPlates(PlateModel plate) {
    return (_plateSelectionController.selectedCategory.value == plate.category);
  }

  @override
  void initState() {
    super.initState();
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
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      children: [
                        _buildCategoriesList(),
                        const SizedBox(
                          height: 40,
                        ),
                        TextFormField(
                          decoration: const InputDecoration(
                              labelText: 'Buscar Plato',
                              prefixIcon: Icon(Iconsax.search_normal)),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 20,
                        ),
                        _buildPlatesList()
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
