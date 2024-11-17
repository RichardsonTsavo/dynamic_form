import 'package:mobx/mobx.dart';

import '../../shared/models/form_section_model.dart';

part 'create_form_store.g.dart';

// ignore: library_private_types_in_public_api
class CreateFormStore = _CreateFormStoreBase with _$CreateFormStore;

abstract class _CreateFormStoreBase with Store {
  ObservableList<FormSectionModel> sections = ObservableList();

  @action
  void addSection() {
    sections.add(
      FormSectionModel(id: DateTime.now().millisecondsSinceEpoch.toString()),
    );
  }

  @action
  void updateSection({required FormSectionModel value, required int index}) {
    sections[index] = value;
  }

  @action
  void deleteSection({required int index}) {
    sections.removeAt(index);
  }
}
