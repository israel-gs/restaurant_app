import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:segundo_muelle/app/ui/home/pages/main_page.dart';
import 'package:segundo_muelle/app/ui/theme/app_theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Segundo Muelle',
      theme: appThemeData,
      home: const MainPage(),
    );
  }
}
