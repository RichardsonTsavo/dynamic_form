import 'package:dynamic_form/app/shared/models/user/index.dart';
import 'package:flutter_modular/flutter_modular.dart';

class PersistentData {
  UserModel? _user;

  bool get isAdmin {
    return _user?.role == "Administrador";
  }

  UserModel get user {
    return _user!;
  }

  void login(UserModel userModel) {
    _user = userModel;
    Modular.to.navigate('/home/');
  }

  void logout() {
    _user = null;
    Modular.to.navigate('/');
  }
}
