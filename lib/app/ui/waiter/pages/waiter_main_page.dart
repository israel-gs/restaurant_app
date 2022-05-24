import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'package:segundo_muelle/app/ui/theme/app_theme.dart';
import 'package:segundo_muelle/app/ui/waiter/pages/statistics/statistics_page.dart';
import 'package:segundo_muelle/app/ui/waiter/pages/table_selection/table_selection_page.dart';
import 'package:segundo_muelle/app/ui/waiter/pages/waiter_main_controller.dart';
import 'package:segundo_muelle/main_controller.dart';

class WaiterMainPage extends StatefulWidget {
  const WaiterMainPage({Key? key}) : super(key: key);

  @override
  _WaiterMainPageState createState() => _WaiterMainPageState();
}

class _WaiterMainPageState extends State<WaiterMainPage> {
  final WaiterMainController _waiterMainController =
      Get.put(WaiterMainController());
  final MainController _mainController = Get.find();
  var _currentIndex = 0;

  List<Widget> pages = [const TableSelectionPage(), StatisticsPage()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[_currentIndex],
      extendBody: true,
      backgroundColor: const Color(0xFFEDF0F4),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20)),
            boxShadow: [
              BoxShadow(
                color: Colors.black54.withOpacity(0.09),
                blurRadius: 13,
                spreadRadius: .8,
                offset: const Offset(
                  0,
                  0,
                ),
              )
            ]),
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 8),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black54.withOpacity(0.09),
                    blurRadius: 13,
                    spreadRadius: .8,
                    offset: const Offset(
                      0,
                      0,
                    ),
                  )
                ]),
            child: SalomonBottomBar(
              unselectedItemColor: Colors.black54,
              selectedColorOpacity: 0.3,
              currentIndex: _currentIndex,
              onTap: (i) => setState(() => _currentIndex = i),
              items: [
                SalomonBottomBarItem(
                  icon: const Icon(Iconsax.reserve),
                  title: const Text("Mesas"),
                  selectedColor: appThemeData.primaryColor,
                ),
                SalomonBottomBarItem(
                  icon: const Icon(Iconsax.graph),
                  title: const Text("Estadísticas"),
                  selectedColor: appThemeData.primaryColor,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
