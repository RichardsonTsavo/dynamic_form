import 'package:dynamic_form/app/modules/view_responses/view_responses_page.dart';
import 'package:dynamic_form/app/modules/view_responses/view_responses_store.dart';
import 'package:flutter_modular/flutter_modular.dart';

class ViewResponsesModule extends Module {
  @override
  void binds(Injector i) {
    i.add<ViewResponsesStore>(ViewResponsesStore.new);
  }

  @override
  void routes(r) {
    r.child(
      '/',
      child: (context) => ViewResponsesPage(
        form: r.args.data,
      ),
    );
  }
}
