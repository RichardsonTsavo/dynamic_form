import 'package:mobx/mobx.dart';

part 'create_form_store.g.dart';

// ignore: library_private_types_in_public_api
class CreateFormStore = _CreateFormStoreBase with _$CreateFormStore;

abstract class _CreateFormStoreBase with Store {
  @observable
  int value = 0;

  @action
  void increment() {
    value++;
  }
}
