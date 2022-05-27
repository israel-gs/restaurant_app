import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:segundo_muelle/app/ui/admin/pages/plate_crud/plate_crud_page.dart';
import 'package:segundo_muelle/app/ui/admin/pages/table_crud/table_crud_page.dart';
import 'package:segundo_muelle/app/ui/admin/pages/user_crud/user_crud_page.dart';
import 'package:segundo_muelle/app/ui/login/pages/login_page.dart';
import 'package:segundo_muelle/main_controller.dart';

class OptionSelectionPage extends StatefulWidget {
  const OptionSelectionPage({Key? key}) : super(key: key);

  @override
  _OptionSelectionPageState createState() => _OptionSelectionPageState();
}

class _OptionSelectionPageState extends State<OptionSelectionPage> {
  final MainController _mainController = Get.find();

  _buildAppBar() {
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.transparent,
      titleTextStyle: const TextStyle(
          color: Colors.black, fontFamily: 'Poppins', fontSize: 20),
      toolbarTextStyle: const TextStyle(
        color: Colors.black,
      ),
      actionsIconTheme: const IconThemeData(
        color: Colors.black,
      ),
      actions: [
        IconButton(
          onPressed: () {
            Get.offAll(() => const LoginPage());
          },
          icon: const Icon(Iconsax.logout),
        )
      ],
      title: Row(
        children: [
          const Text('Hola '),
          Text(
            _mainController.currentUser.value.name,
            style: const TextStyle(fontWeight: FontWeight.bold),
          )
        ],
      ),
    );
  }

  _buildItem(
      {required IconData iconData,
      required String title,
      required Function onTap}) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(6),
      child: Material(
        child: InkWell(
          onTap: () => onTap(),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Row(
              children: [
                Icon(
                  iconData,
                  color: Colors.black54,
                ),
                const SizedBox(width: 10),
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.black87,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(),
                const Icon(
                  Iconsax.arrow_right_3,
                  color: Colors.black54,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: const Color(0xFFEDF0F4),
      appBar: _buildAppBar(),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 20, right: 20, top: 20, bottom: 90),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('¿Que quieres hacer hoy?'),
                    const SizedBox(height: 20),
                    _buildItem(
                      iconData: Iconsax.reserve,
                      title: 'Editar mesas',
                      onTap: () => Get.to(() => const TableCrudPage()),
                    ),
                    const SizedBox(height: 20),
                    _buildItem(
                      iconData: Iconsax.cd,
                      title: 'Editar platos',
                      onTap: () => Get.to(() => PlateCrudPage()),
                    ),
                    const SizedBox(height: 20),
                    _buildItem(
                      iconData: Iconsax.user,
                      title: 'Editar usuarios',
                      onTap: () => Get.to(() => const UserCrudPage()),
                    ),
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
