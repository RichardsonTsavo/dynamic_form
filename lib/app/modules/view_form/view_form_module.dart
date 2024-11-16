import 'package:dynamic_form/app/modules/view_form/view_form_page.dart';
import 'package:dynamic_form/app/modules/view_form/view_form_store.dart';
import 'package:flutter_modular/flutter_modular.dart';

class ViewFormModule extends Module {
  @override
  void binds(Injector i) {
    i.add<ViewFormStore>(ViewFormStore.new);
  }

  @override
  void routes(r) {
    r.child(
      '/',
      child: (context) => ViewFormPage(
        form: r.args.data,
      ),
    );
  }
}
