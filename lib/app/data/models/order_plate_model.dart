import 'package:hive/hive.dart';
import 'package:segundo_muelle/app/data/models/plate_model.dart';

part 'order_plate_model.g.dart';

@HiveType(typeId: 5)
class OrderPlateModel {
  @HiveField(0)
  PlateModel plate;

  @HiveField(1)
  int quantity;

  OrderPlateModel({required this.plate, required this.quantity});
}
