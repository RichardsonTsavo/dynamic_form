import 'package:dynamic_form/app/modules/create_form/create_form_page.dart';
import 'package:dynamic_form/app/modules/create_form/create_form_store.dart';
import 'package:flutter_modular/flutter_modular.dart';

class CreateFormModule extends Module {
  @override
  void binds(Injector i) {
    i.addLazySingleton<CreateFormStore>(CreateFormStore.new);
  }

  @override
  void routes(r) {
    r.child(
      '/',
      child: (context) => CreateFormPage(
        formModel: r.args.data,
      ),
    );
  }
}
