import 'package:dynamic_form/app/shared/models/index.dart';
import 'package:dynamic_form/app/shared/utils/index.dart';
import 'package:mobx/mobx.dart';

part 'view_form_store.g.dart';

class ViewFormStore = _ViewFormStoreBase with _$ViewFormStore;

abstract class _ViewFormStoreBase with Store {
  FormWidgetBuilder? formWidgetBuilder;

  @observable
  bool isLoading = false;

  Future<FormModel> getForm(FormModel form) async {
    await Future.delayed(const Duration(seconds: 2));
    return form;
  }

  Future<void> sendForm(Map<String, dynamic> form) async {
    await Future.delayed(const Duration(seconds: 2));
  }
}
