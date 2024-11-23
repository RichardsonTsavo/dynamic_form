import 'package:dynamic_form/app/modules/users/users_page.dart';
import 'package:dynamic_form/app/modules/users/users_store.dart';
import 'package:flutter_modular/flutter_modular.dart';

class UsersModule extends Module {
  @override
  void binds(Injector i) {
    i.add<UsersStore>(UsersStore.new);
  }

  @override
  void routes(r) {
    r.child(
      '/',
      child: (context) => const UsersPage(),
    );
  }
}
