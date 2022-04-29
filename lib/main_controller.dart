import 'package:get/get.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:segundo_muelle/app/data/models/plate_model.dart';
import 'package:segundo_muelle/app/data/models/table_model.dart';
import 'package:segundo_muelle/app/data/models/user_model.dart';

class MainController extends GetxController {
  late Box<TableModel> tableBox;
  late Box<UserModel> userBox;
  late Box<PlateModel> plateBox;

  @override
  onInit() async {
    super.onInit();
    Hive.registerAdapter(TableModelAdapter());
    Hive.registerAdapter(UserModelAdapter());
    Hive.registerAdapter(PlateModelAdapter());

    tableBox = await Hive.openBox<TableModel>('tableBox');
    plateBox = await Hive.openBox<PlateModel>('plateBox');
    userBox = await Hive.openBox<UserModel>('userBox');
  }
}
