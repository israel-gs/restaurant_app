import 'package:hive/hive.dart';

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
  String image;
  @HiveField(4)
  String category;

  PlateModel(
      {required this.name,
      required this.price,
      required this.description,
      required this.image,
      required this.category});
}
