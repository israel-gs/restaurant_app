import 'package:hive/hive.dart';
import '../enums/category_enum.dart';

part 'plate_model.g.dart';

@HiveType(typeId: 2)
class PlateModel extends HiveObject {
  @HiveField(0)
  String name;

  @HiveField(1)
  double price;

  @HiveField(2)
  String description;

  @HiveField(3)
  String code;

  @HiveField(4)
  CategoryEnum category;

  PlateModel(
      {required this.name,
      required this.price,
      required this.description,
      required this.code,
      required this.category});
}
