import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:segundo_muelle/app/ui/theme/color_theme.dart';

class PlateModel {
  String name;
  String imagePath;
  double price;

  PlateModel(
      {required this.name, required this.imagePath, required this.price});
}

class CategoryModel {
  String name;
  String imagePath;
  List<PlateModel> plates;

  CategoryModel(
      {required this.name, required this.imagePath, required this.plates});
}

class PlateSelectionPage extends StatefulWidget {
  const PlateSelectionPage({Key? key}) : super(key: key);

  @override
  _PlateSelectionPageState createState() => _PlateSelectionPageState();
}

class _PlateSelectionPageState extends State<PlateSelectionPage> {
  final List<CategoryModel> _categories = [
    CategoryModel(
        name: 'Entradas',
        imagePath: 'lib/app/assets/entrada.png',
        plates: [
          PlateModel(name: 'Plato 1', imagePath: '', price: 25.00),
          PlateModel(name: 'Plato 1', imagePath: '', price: 25.00),
          PlateModel(name: 'Plato 1', imagePath: '', price: 25.00),
          PlateModel(name: 'Plato 1', imagePath: '', price: 25.00),
          PlateModel(name: 'Plato 1', imagePath: '', price: 25.00),
          PlateModel(name: 'Plato 1', imagePath: '', price: 25.00),
          PlateModel(name: 'Plato 1', imagePath: '', price: 25.00),
          PlateModel(name: 'Plato 1', imagePath: '', price: 25.00),
          PlateModel(name: 'Plato 1', imagePath: '', price: 25.00),
          PlateModel(name: 'Plato 1', imagePath: '', price: 25.00),
          PlateModel(name: 'Plato 1', imagePath: '', price: 25.00),
          PlateModel(name: 'Plato 1', imagePath: '', price: 25.00),
          PlateModel(name: 'Plato 1', imagePath: '', price: 25.00),
          PlateModel(name: 'Plato 1', imagePath: '', price: 25.00),
          PlateModel(name: 'Plato 1', imagePath: '', price: 25.00),
          PlateModel(name: 'Plato 1', imagePath: '', price: 25.00),
          PlateModel(name: 'Plato 1', imagePath: '', price: 25.00),
          PlateModel(name: 'Plato 1', imagePath: '', price: 25.00),
          PlateModel(name: 'Plato 1', imagePath: '', price: 25.00),
          PlateModel(name: 'Plato 1', imagePath: '', price: 25.00),
          PlateModel(name: 'Plato 1', imagePath: '', price: 25.00),
          PlateModel(name: 'Plato 1', imagePath: '', price: 25.00),
          PlateModel(name: 'Plato 1', imagePath: '', price: 25.00),
        ]),
    CategoryModel(
        name: 'Pescados', imagePath: 'lib/app/assets/pescados.png', plates: []),
    CategoryModel(
        name: 'Sopas', imagePath: 'lib/app/assets/sopas.png', plates: []),
    CategoryModel(
        name: 'Bebidas', imagePath: 'lib/app/assets/bebidas.png', plates: []),
    CategoryModel(
        name: 'Postres', imagePath: 'lib/app/assets/postres.png', plates: []),
  ];

  late CategoryModel selectedCategory;

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
        children: const [
          Text('Selecciona el pedido para la '),
          Text(
            'Mesa 2',
            style: TextStyle(fontWeight: FontWeight.bold),
          )
        ],
      ),
    );
  }

  Widget _buildPlateItem(PlateModel plate) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 13),
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(6)),
        width: ((Get.width / 2) - 40),
        child: Column(
          children: [
            const FlutterLogo(
              size: 60,
            ),
            const SizedBox(
              height: 10,
            ),
            Text(plate.name),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryItem(CategoryModel category) {
    return Padding(
      padding: const EdgeInsets.only(right: 20),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(6),
        child: Material(
          child: InkWell(
            onTap: () {
              setState(() {
                selectedCategory = category;
              });
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 150),
              color: category == selectedCategory
                  ? ColorTheme.primary
                  : Colors.white,
              width: 95,
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
              child: Column(
                children: [
                  Image.asset(category.imagePath, height: 40),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    category.name,
                    style: TextStyle(
                        fontSize: 10,
                        fontWeight: (category == selectedCategory)
                            ? FontWeight.bold
                            : FontWeight.normal,
                        color: (category == selectedCategory)
                            ? Colors.white
                            : Colors.black),
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
        children: selectedCategory.plates
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
        children: _categories
            .map((category) => _buildCategoryItem(category))
            .toList(),
      ),
    );
  }

  @override
  void initState() {
    setState(() {
      selectedCategory = _categories[0];
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: const Color(0xFFEDF0F4),
      appBar: _buildAppBar(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Iconsax.bag),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    _buildCategoriesList(),
                    const SizedBox(
                      height: 40,
                    ),
                    _buildPlatesList()
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
