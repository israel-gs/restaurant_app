import 'package:hive/hive.dart';

part 'table_model.g.dart';

@HiveType(typeId: 0)
class TableModel extends HiveObject {
  @HiveField(0)
  String name;

  @HiveField(1)
  bool isTaken;

  TableModel({required this.name, required this.isTaken});
}
