import 'package:dynamic_form/app/modules/create_form/create_form_module.dart';
import 'package:dynamic_form/app/modules/users/users_module.dart';
import 'package:dynamic_form/app/modules/view_form/view_form_module.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'modules/home/home_module.dart';
import 'shared/persistent/persistent_data.dart';

class AppModule extends Module {
  @override
  void binds(Injector i) {
    i.addLazySingleton<PersistentData>(PersistentData.new);
  }

  @override
  void routes(RouteManager r) {
    r.module('/', module: UsersModule(), transition: TransitionType.fadeIn);
    r.module('/home', module: HomeModule(), transition: TransitionType.fadeIn);
    r.module('/create-form',
        module: CreateFormModule(), transition: TransitionType.fadeIn);
    r.module('/view-form',
        module: ViewFormModule(), transition: TransitionType.fadeIn);
  }
}
