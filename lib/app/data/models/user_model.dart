import 'package:hive/hive.dart';

part 'user_model.g.dart';

@HiveType(typeId: 1)
class UserModel extends HiveObject {
  @HiveField(0)
  String name;

  @HiveField(1)
  String username;

  @HiveField(2)
  String password;

  @HiveField(3)
  bool isAdmin;

  @HiveField(4)
  bool isBlocked;

  @HiveField(5)
  int attemptsCount;

  UserModel({
    required this.name,
    required this.username,
    required this.password,
    required this.isAdmin,
    required this.isBlocked,
    required this.attemptsCount,
  });
}
