import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:segundo_muelle/app/data/repository/order_repository.dart';
import 'package:segundo_muelle/app/data/repository/plate_repository.dart';
import 'package:segundo_muelle/app/data/repository/table_repository.dart';
import 'package:segundo_muelle/app/data/repository/user_repository.dart';
import 'package:segundo_muelle/app/ui/login/pages/login_page.dart';
import 'package:segundo_muelle/app/ui/theme/app_theme.dart';
import 'package:segundo_muelle/main_controller.dart';

void main() async {
  await Hive.initFlutter();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(MainController());
    Get.put(TableRepository());
    Get.put(PlateRepository());
    Get.put(OrderRepository());
    Get.put(UserRepository());

    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Segundo Muelle',
      theme: appThemeData,
      home: const LoginPage(),
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate
      ],
      supportedLocales: const [Locale('es')],
    );
  }
}
