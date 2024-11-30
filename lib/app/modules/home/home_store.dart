import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

import '../../shared/api/dynamic_form_api.dart';
import '../../shared/models/dynamic_form/index.dart';
import '../../shared/persistent/persistent_data.dart';

part 'home_store.g.dart';

class HomeStore = HomeStoreBase with _$HomeStore;

abstract class HomeStoreBase with Store {
  DynamicFormApi api = DynamicFormApi();
  PersistentData persistentData = Modular.get();

  Future<List<FormResponseModel>> getAllResponses(String id) async {
    return api.getAllResponsesFromID(id);
  }

  Future<List<FormModel>> getAllForms() async {
    return api.getAllForms();
  }

  Future<void> deleteForms(String formID) async {
    return await api.deleteForm(formID: formID);
  }
}
