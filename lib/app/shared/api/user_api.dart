import 'dart:convert';

import 'package:dynamic_form/app/shared/models/user/index.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserApi {
  Future<List<UserModel>> getAllUsers() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? items = prefs.getStringList('users');
    if (items != null) {
      List<UserModel> listUsers = [];
      for (var element in items) {
        Map<String, dynamic> valueMap = json.decode(element);
        UserModel form = UserModel.fromMap(valueMap);
        listUsers.add(form);
      }
      return listUsers;
    } else {
      return [];
    }
  }

  Future createNewUser({required UserModel user}) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> items = prefs.getStringList('users') ?? [];
    items.add(user.toJson());
    await prefs.setStringList('users', items);
  }

  Future deleteUser({required int index}) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> items = prefs.getStringList('users') ?? [];
    items.removeAt(index);
    await prefs.setStringList('users', items);
  }
}
