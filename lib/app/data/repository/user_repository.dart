import 'package:segundo_muelle/app/data/models/user_model.dart';
import 'package:segundo_muelle/app/data/providers/user_provider.dart';

class UserRepository {
  final UserProvider _userProvider = UserProvider();

  List<UserModel> getUsers() {
    return _userProvider.getUsers();
  }

  Future<String> registerUser(UserModel user) async {
    return _userProvider.registerUser(user);
  }

  Future<void> updateUser(String key, UserModel user) async {
    _userProvider.updateUser(key, user);
  }

  void deleteUser(String key) async {
    _userProvider.deleteUser(key);
  }
}
