import 'package:dynamic_form/app/shared/api/user_api.dart';
import 'package:dynamic_form/app/shared/models/user/index.dart';
import 'package:mobx/mobx.dart';

part 'users_store.g.dart';

// ignore: library_private_types_in_public_api
class UsersStore = _UsersStoreBase with _$UsersStore;

abstract class _UsersStoreBase with Store {
  UserApi api = UserApi();

  Future<void> createUsers(UserModel user) async {
    return api.createNewUser(user: user);
  }

  Future<List<UserModel>> getAllUsers() async {
    return api.getAllUsers();
  }

  Future<void> deleteUser(int index) async {
    return await api.deleteUser(index: index);
  }
}
