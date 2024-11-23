import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

import '../../shared/api/dynamic_form_api.dart';
import '../../shared/models/index.dart';
import '../../shared/utils/index.dart';

part 'create_form_store.g.dart';

// ignore: library_private_types_in_public_api
class CreateFormStore = _CreateFormStoreBase with _$CreateFormStore;

abstract class _CreateFormStoreBase with Store {
  FormWidgetBuilderAdmin? formWidgetBuilderAdmin;
  DynamicFormApi api = DynamicFormApi();
  GlobalKey<FormBuilderState> formKey = GlobalKey<FormBuilderState>();
  ObservableList<FormSectionModel> sections = ObservableList();
  @observable
  bool isLoading = false;

  @action
  void addSection() {
    sections.add(
      FormSectionModel(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        fields: [],
      ),
    );
  }

  @action
  void updateSection({required FormSectionModel value, required int index}) {
    sections.removeAt(index);
    sections.insert(index, value);
  }

  @action
  void addFieldInSection({required String fieldType, required int index}) {
    FormSectionModel section = sections[index];
    section.fields!.add(FormFieldModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      fieldType: fieldType,
    ));

    updateSection(value: section, index: index);
  }

  @action
  void deleteFieldInSection({required String sectionId, required int index}) {
    int sectionIndex = 0;
    late FormSectionModel section;
    for (var i = 0; i < sections.length; i++) {
      if (sections[i].id == sectionId) {
        section = sections[i];
        sectionIndex = i;
      }
    }
    section.fields!.removeAt(index);
    updateSection(value: section, index: sectionIndex);
  }

  @action
  void deleteSection({required int index}) {
    sections.removeAt(index);
  }

  @action
  Future saveForm({
    required Map<String, dynamic> form,
    required BuildContext context,
  }) async {
    if (isLoading == true) {
      return;
    }
    isLoading = true;

    for (var i = 0; i < sections.length; i++) {
      final sectionId = sections[i].id;
      final sectionPrefix = '$sectionId/$i';

      sections[i] = sections[i].copyWith(
        title: form['$sectionPrefix/title'],
        description: form['$sectionPrefix/description'],
      );

      for (int x = 0; x < (sections[i].fields?.length ?? 0); x++) {
        final fieldPrefix = '$sectionId/$x';

        sections[i].fields![x] = sections[i].fields![x].copyWith(
              label: form['$fieldPrefix/label'],
              description: form['$fieldPrefix/description'],
              isRequired: form['$fieldPrefix/isRequired'],
              title: form['$fieldPrefix/title'],
              fieldOptions: form['$fieldPrefix/options'],
              min: _parseDouble(form['$fieldPrefix/min']),
              max: _parseDouble(form['$fieldPrefix/max']),
              fileTypes: form['$fieldPrefix/fileTypes'],
            );
      }
    }

    FormModel formModel = FormModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      formName: form['title'],
      isEditable: form['isEditable'],
      maxResponseCount: int.parse(
        form['maxResponseCount'].toString(),
      ),
      sections: sections,
    );

    await api.createNewForm(form: formModel);
    isLoading = false;
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        Utils.showPopupDialog(
          context: context,
          child: AlertDialog(
            title: const Text("Formulário criado com sucesso!"),
            actions: [
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  Modular.to.navigate('/');
                },
                child: const Text("Fechar"),
              )
            ],
          ),
        );
      },
    );
  }

  double? _parseDouble(dynamic value) {
    return value != null ? double.tryParse(value.toString()) : null;
  }
}
