import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'package:segundo_muelle/app/ui/admin/pages/option_selection/option_selection_page.dart';
import 'package:segundo_muelle/app/ui/admin/pages/statistics/statistics_page.dart';
import 'package:segundo_muelle/app/ui/theme/app_theme.dart';

class AdminDashboardPage extends StatefulWidget {
  const AdminDashboardPage({Key? key}) : super(key: key);

  @override
  _AdminDashboardPageState createState() => _AdminDashboardPageState();
}

class _AdminDashboardPageState extends State<AdminDashboardPage> {
  var _currentIndex = 0;

  List<Widget> pages = [const OptionSelectionPage(), StatisticsPage()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[_currentIndex],
      extendBody: true,
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
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
                  icon: const Icon(Iconsax.add),
                  title: const Text("Administración"),
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
