import 'package:hive/hive.dart';
part 'category_enum.g.dart';

@HiveType(typeId: 3)
enum CategoryEnum {
  @HiveField(0)
  starterDish,
  @HiveField(1)
  fish,
  @HiveField(2)
  soups,
  @HiveField(3)
  drinks,
  @HiveField(4)
  desserts
}
