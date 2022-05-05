import 'package:hive/hive.dart';
import 'package:segundo_muelle/app/data/models/order_plate_model.dart';
import 'package:segundo_muelle/app/data/models/table_model.dart';
import 'package:segundo_muelle/app/data/models/user_model.dart';

part 'order_model.g.dart';

@HiveType(typeId: 4)
class OrderModel {
  @HiveField(0)
  UserModel user;

  @HiveField(1)
  TableModel table;

  @HiveField(2)
  DateTime date;

  @HiveField(3)
  double tip;

  @HiveField(4)
  List<OrderPlateModel> orderPlates;

  OrderModel({
    required this.user,
    required this.table,
    required this.date,
    required this.tip,
    required this.orderPlates,
  });
}
