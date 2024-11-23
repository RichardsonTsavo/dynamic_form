import 'package:mobx/mobx.dart';

part 'view_responses_store.g.dart';

class ViewResponsesStore = _ViewResponsesStoreBase with _$ViewResponsesStore;

abstract class _ViewResponsesStoreBase with Store {
  @observable
  int value = 0;

  @action
  void increment() {
    value++;
  }
}
