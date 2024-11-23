import 'package:dynamic_form/app/shared/models/dynamic_form/index.dart';
import 'package:dynamic_form/app/shared/utils/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

import '../../shared/api/dynamic_form_api.dart';
import '../../shared/persistent/persistent_data.dart';

part 'view_form_store.g.dart';

// ignore: library_private_types_in_public_api
class ViewFormStore = _ViewFormStoreBase with _$ViewFormStore;

abstract class _ViewFormStoreBase with Store {
  FormWidgetBuilder? formWidgetBuilder;
  PersistentData persistentData = Modular.get();
  DynamicFormApi dynamicFormApi = DynamicFormApi();

  @observable
  bool isLoading = false;

  Future<FormModel> getForm(FormModel form) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return form;
  }

  Future<void> sendForm({
    required FormResponseModel response,
    required BuildContext context,
  }) async {
    isLoading = true;
    await dynamicFormApi.saveFormResponses(response);
    isLoading = false;
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        Utils.showPopupDialog(
          context: context,
          child: AlertDialog(
            actionsAlignment: MainAxisAlignment.spaceEvenly,
            title: const Text(
              "Resposta enviada com sucesso!",
              textAlign: TextAlign.center,
            ),
            actions: [
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  Modular.to.navigate('/home/');
                },
                child: const Text("Fechar"),
              )
            ],
          ),
        );
      },
    );
  }
}
