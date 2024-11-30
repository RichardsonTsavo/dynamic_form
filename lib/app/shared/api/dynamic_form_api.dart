import 'dart:convert';

import 'package:dynamic_form/app/shared/models/dynamic_form/index.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../persistent/persistent_data.dart';

class DynamicFormApi {
  Future<List<FormModel>> getAllForms() async {
    PersistentData persistentData = Modular.get();
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? items = prefs.getStringList('forms');
    if (items != null) {
      List<FormModel> listResponses = [];
      for (var element in items) {
        Map<String, dynamic> valueMap = json.decode(element);
        FormModel form = FormModel.fromMap(valueMap);
        listResponses.add(form);
      }
      if (persistentData.isAdmin) {
        listResponses.removeWhere(
          (element) => element.createdBy != persistentData.user.id,
        );
      }
      return listResponses;
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

  Future deleteForm({required String formID}) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> items = prefs.getStringList('forms') ?? [];
    items.removeWhere(
      (element) {
        Map<String, dynamic> valueMap = json.decode(element);
        FormModel form = FormModel.fromMap(valueMap);
        return form.id == formID;
      },
    );
    await prefs.setStringList('forms', items);
  }

  Future updateForms(FormModel form) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    List<FormModel> allForms = await getAllForms();
    for (var i = 0; i < allForms.length; i++) {
      if (allForms[i].id == form.id) {
        allForms[i] = form;
      }
    }
    await prefs.setStringList(
      'forms',
      allForms
          .map(
            (value) => value.toJson(),
          )
          .toList(),
    );
  }

  Future saveFormResponses(FormResponseModel response) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> items = prefs.getStringList('responses') ?? [];
    items.add(response.toJson());
    await prefs.setStringList('responses', items);
  }

  Future updateFormResponses(FormResponseModel model) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> items = prefs.getStringList('responses') ?? [];
    List<FormResponseModel> responses = List.generate(
      items.length,
      (index) => FormResponseModel.fromJson(items[index]),
    );
    for (int i = 0; i < responses.length; i++) {
      if (model.id == responses[i].id) {
        responses[i] = model;
      }
    }
    List<String> itemsEdited = List.generate(
      responses.length,
      (index) => responses[index].toJson(),
    );
    await prefs.setStringList('responses', itemsEdited);
  }

  Future<List<FormResponseModel>> getAllResponsesFromID(String formID) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? items = prefs.getStringList('responses');
    if (items != null) {
      List<FormResponseModel> listResponses = [];
      for (var element in items) {
        Map<String, dynamic> valueMap = json.decode(element);
        FormResponseModel form = FormResponseModel.fromMap(valueMap);
        listResponses.add(form);
      }
      listResponses.removeWhere(
        (element) => element.formID != formID,
      );
      return listResponses;
    } else {
      return [];
    }
  }

  Future deleteResponse({required String responseID}) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> items = prefs.getStringList('responses') ?? [];
    items.removeWhere(
      (element) {
        Map<String, dynamic> valueMap = json.decode(element);
        FormResponseModel response = FormResponseModel.fromMap(valueMap);
        return response.id == responseID;
      },
    );
    await prefs.setStringList('responses', items);
  }
}
