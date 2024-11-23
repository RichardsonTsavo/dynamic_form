// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_form_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$CreateFormStore on _CreateFormStoreBase, Store {
  late final _$isLoadingAtom =
      Atom(name: '_CreateFormStoreBase.isLoading', context: context);

  @override
  bool get isLoading {
    _$isLoadingAtom.reportRead();
    return super.isLoading;
  }

  @override
  set isLoading(bool value) {
    _$isLoadingAtom.reportWrite(value, super.isLoading, () {
      super.isLoading = value;
    });
  }

  late final _$saveFormAsyncAction =
      AsyncAction('_CreateFormStoreBase.saveForm', context: context);

  @override
  Future<dynamic> saveForm(
      {required Map<String, dynamic> form,
      required BuildContext context,
      FormModel? formModel}) {
    return _$saveFormAsyncAction.run(() =>
        super.saveForm(form: form, context: context, formModel: formModel));
  }

  late final _$_CreateFormStoreBaseActionController =
      ActionController(name: '_CreateFormStoreBase', context: context);

  @override
  void addSection() {
    final _$actionInfo = _$_CreateFormStoreBaseActionController.startAction(
        name: '_CreateFormStoreBase.addSection');
    try {
      return super.addSection();
    } finally {
      _$_CreateFormStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void updateSection({required FormSectionModel value, required int index}) {
    final _$actionInfo = _$_CreateFormStoreBaseActionController.startAction(
        name: '_CreateFormStoreBase.updateSection');
    try {
      return super.updateSection(value: value, index: index);
    } finally {
      _$_CreateFormStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void addFieldInSection({required String fieldType, required int index}) {
    final _$actionInfo = _$_CreateFormStoreBaseActionController.startAction(
        name: '_CreateFormStoreBase.addFieldInSection');
    try {
      return super.addFieldInSection(fieldType: fieldType, index: index);
    } finally {
      _$_CreateFormStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void deleteFieldInSection({required String sectionId, required int index}) {
    final _$actionInfo = _$_CreateFormStoreBaseActionController.startAction(
        name: '_CreateFormStoreBase.deleteFieldInSection');
    try {
      return super.deleteFieldInSection(sectionId: sectionId, index: index);
    } finally {
      _$_CreateFormStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void deleteSection({required int index}) {
    final _$actionInfo = _$_CreateFormStoreBaseActionController.startAction(
        name: '_CreateFormStoreBase.deleteSection');
    try {
      return super.deleteSection(index: index);
    } finally {
      _$_CreateFormStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
isLoading: ${isLoading}
    ''';
  }
}
