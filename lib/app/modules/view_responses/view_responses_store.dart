import 'package:mobx/mobx.dart';

import '../../shared/api/dynamic_form_api.dart';
import '../../shared/models/dynamic_form/index.dart';

part 'view_responses_store.g.dart';

class ViewResponsesStore = _ViewResponsesStoreBase with _$ViewResponsesStore;

abstract class _ViewResponsesStoreBase with Store {
  DynamicFormApi api = DynamicFormApi();
  Future<List<FormResponseModel>> getAllResponses(String id) async {
    return api.getAllResponsesFromID(id);
  }

  Future deleteResponse(String responseID) async {
    await api.deleteResponse(responseID: responseID);
  }
}
