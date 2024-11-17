import 'package:mobx/mobx.dart';

import '../../shared/api/dynamic_form_api.dart';
import '../../shared/models/index.dart';

part 'home_store.g.dart';

class HomeStore = HomeStoreBase with _$HomeStore;

abstract class HomeStoreBase with Store {
  DynamicFormApi api = DynamicFormApi();

  Future<List<FormModel>> getAllForms() async {
    return api.getAllForms();
  }
}
