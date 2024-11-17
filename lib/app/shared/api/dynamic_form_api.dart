import 'dart:convert';

import 'package:dynamic_form/app/shared/models/index.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DynamicFormApi {
  Future<List<FormModel>> getAllForms() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? items = prefs.getStringList('forms');
    if (items != null) {
      List<FormModel> listForms = [];
      for (var element in items) {
        Map<String, dynamic> valueMap = json.decode(element);
        FormModel form = FormModel.fromMap(valueMap);
        listForms.add(form);
      }
      return listForms;
    } else {
      return [];
    }
  }

  Future createNewForm({required FormModel form}) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> items = prefs.getStringList('forms') ?? [];
    items.add(form.toJson());
    await prefs.setStringList('forms', items);
  }

  Future deleteForm({required int index}) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> items = prefs.getStringList('forms') ?? [];
    items.removeAt(index);
    await prefs.setStringList('forms', items);
  }

  Future updateForms(List<FormModel> forms) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(
      'forms',
      forms
          .map(
            (value) => value.toJson(),
          )
          .toList(),
    );
  }
}
