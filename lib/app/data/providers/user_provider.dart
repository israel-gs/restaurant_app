import 'package:get/get.dart';
import 'package:segundo_muelle/app/data/models/user_model.dart';
import 'package:segundo_muelle/main_controller.dart';
import 'package:uuid/uuid.dart';

class UserProvider {
  final MainController _mainController = Get.find();

  List<UserModel> getUsers() {
    return _mainController.userBox.values.toList();
  }

  Future<String> registerUser(UserModel user) async {
    var uuid = const Uuid();
    var key = uuid.v4();
    await _mainController.userBox.put(key, user);
    return key;
  }

  Future<void> updateUser(String key, UserModel user) async {
    await _mainController.userBox.put(key, user);
  }

  void deleteUser(String key) async {
    await _mainController.userBox.delete(key);
  }
}
