import 'package:dynamic_form/app/shared/models/index.dart';
import 'package:dynamic_form/app/shared/widgets/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../modules/create_form/create_form_store.dart';
import 'index.dart';

class FormWidgetBuilderAdmin {
  final BoxConstraints constraints;
  final BuildContext context;
  const FormWidgetBuilderAdmin(
      {required this.constraints, required this.context});

  List<Widget> buildForm({
    required GlobalKey<FormBuilderState> formKey,
    required FormSectionModel formSection,
  }) {
    List<Widget> widgets = [
      const SizedBox(
        height: 8,
      ),
      CustomTextFormField(
        name: '${formSection.id}title',
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Campo obrigatório';
          }
          return null;
        },
        borderColor: Theme.of(context).scaffoldBackgroundColor,
        labelText: 'Titulo da sessão',
        cursorColor: Theme.of(context).scaffoldBackgroundColor,
        labelStyle: TextStyle(
          color: Theme.of(context).scaffoldBackgroundColor,
        ),
        style: TextStyle(
          color: Theme.of(context).scaffoldBackgroundColor,
        ),
      ),
      const SizedBox(
        height: 8,
      ),
      CustomTextFormField(
        name: '${formSection.id}description',
        borderColor: Theme.of(context).scaffoldBackgroundColor,
        labelText: 'Descrição da sessão',
        cursorColor: Theme.of(context).scaffoldBackgroundColor,
        labelStyle: TextStyle(
          color: Theme.of(context).scaffoldBackgroundColor,
        ),
        style: TextStyle(
          color: Theme.of(context).scaffoldBackgroundColor,
        ),
      ),
      const SizedBox(
        height: 8,
      ),
    ];
    for (int x = 0; x < formSection.fields!.length; x++) {
      FormFieldModel element = formSection.fields![x];
      switch (element.fieldType) {
        case 'TEXT':
          widgets.add(
            buildField(
              sectionID: formSection.id!,
              index: x,
              titleType: "Tipo: Texto Simples",
              field: element,
              widgets: [],
            ),
          );
          break;
        case 'LONGTEXT':
          widgets.add(
            buildField(
                sectionID: formSection.id!,
                index: x,
                titleType: "Tipo: Texto Longo",
                field: element,
                widgets: []),
          );
          break;
        case 'CPF':
          widgets.add(
            buildField(
              sectionID: formSection.id!,
              index: x,
              titleType: "Tipo: CPF",
              field: element,
              widgets: [],
            ),
          );
          break;
        case 'CNPJ':
          widgets.add(
            buildField(
              sectionID: formSection.id!,
              index: x,
              titleType: "Tipo: CNPJ",
              field: element,
              widgets: [],
            ),
          );
          break;
        case 'CEP':
          widgets.add(
            buildField(
                sectionID: formSection.id!,
                index: x,
                titleType: "Tipo: Cep",
                field: element,
                widgets: []),
          );
          break;
        case 'PHONE':
          widgets.add(
            buildField(
                sectionID: formSection.id!,
                index: x,
                titleType: "Tipo: Telefone",
                field: element,
                widgets: []),
          );
          break;
        case 'CURRENCY':
          widgets.add(
            buildField(
                sectionID: formSection.id!,
                index: x,
                titleType: "Tipo: Moeda",
                field: element,
                widgets: []),
          );
          break;
        case 'CARPLATE':
          widgets.add(
            buildField(
                sectionID: formSection.id!,
                index: x,
                titleType: "Tipo: Placa de carro",
                field: element,
                widgets: []),
          );
          break;
        case 'BANKCARD':
          widgets.add(
            buildField(
                sectionID: formSection.id!,
                index: x,
                titleType: "Tipo: Cartão de Banco",
                field: element,
                widgets: []),
          );
          break;
        case 'CHECKBOX':
          widgets.add(
            buildField(
                sectionID: formSection.id!,
                index: x,
                titleType: "Tipo: CheckBox",
                field: element,
                widgets: []),
          );
          break;
        case 'DROPDOWN':
          widgets.add(
            buildField(
                sectionID: formSection.id!,
                index: x,
                titleType: "Tipo: DropDown",
                field: element,
                widgets: [
                  AddOptionsWidget(
                    fieldId: '${formSection.id!}/$x/options',
                    firstRequired: true,
                  )
                ]),
          );
          break;
        case 'SWITCH':
          widgets.add(
            buildField(
                sectionID: formSection.id!,
                index: x,
                titleType: "Tipo: Switch",
                field: element,
                widgets: []),
          );
          break;
        case 'CHECKBOXGROUP':
          widgets.add(
            buildField(
                sectionID: formSection.id!,
                index: x,
                titleType: "Tipo: Grupo de Checkbox",
                field: element,
                widgets: [
                  const SizedBox(
                    height: 8,
                  ),
                  AddOptionsWidget(
                    fieldId: "${formSection.id!}/$x/options",
                    firstRequired: true,
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  CustomDropdown(
                    name: "${formSection.id!}/$x/min",
                    initialValue: element.value ?? 1,
                    items: List.generate(
                      1000,
                      (index) => DropdownMenuItem(
                        value: index,
                        child: Text("$index"),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || (value.toString()).isEmpty) {
                        return "Campo obrigatório";
                      }
                      return null;
                    },
                    title: "Minimo",
                    titleTextStyle: TextStyle(
                      color: Theme.of(context).scaffoldBackgroundColor,
                    ),
                    borderColor: Theme.of(context).scaffoldBackgroundColor,
                    selectedColor: Theme.of(context).scaffoldBackgroundColor,
                    style: TextStyle(
                      color: Theme.of(context).scaffoldBackgroundColor,
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  CustomDropdown(
                    name: "${formSection.id!}/$x/max",
                    initialValue: element.value,
                    validator: (value) {
                      if (value == null || (value.toString()).isEmpty) {
                        return "Campo obrigatório";
                      }
                      return null;
                    },
                    items: List.generate(
                      1000,
                      (index) => DropdownMenuItem(
                        value: index,
                        child: Text("$index"),
                      ),
                    ),
                    title: "Máximo",
                    selectedColor: Theme.of(context).scaffoldBackgroundColor,
                    titleTextStyle: TextStyle(
                      color: Theme.of(context).scaffoldBackgroundColor,
                    ),
                    borderColor: Theme.of(context).scaffoldBackgroundColor,
                    style: TextStyle(
                      color: Theme.of(context).scaffoldBackgroundColor,
                    ),
                  )
                ]),
          );
          break;
        case 'SLIDER':
          widgets.add(
            buildField(
                sectionID: formSection.id!,
                index: x,
                titleType: "Tipo: Slider",
                field: element,
                widgets: [
                  const SizedBox(
                    height: 8,
                  ),
                  CustomDropdown(
                    name: "${formSection.id!}/$x/min",
                    initialValue: element.value,
                    items: List.generate(
                      1000,
                      (index) => DropdownMenuItem(
                        value: index,
                        child: Text("$index"),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || (value.toString()).isEmpty) {
                        return "Campo obrigatório";
                      }
                      return null;
                    },
                    title: "Minimo",
                    selectedColor: Theme.of(context).scaffoldBackgroundColor,
                    borderColor: Theme.of(context).scaffoldBackgroundColor,
                    titleTextStyle: TextStyle(
                      color: Theme.of(context).scaffoldBackgroundColor,
                    ),
                    style: TextStyle(
                      color: Theme.of(context).scaffoldBackgroundColor,
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  CustomDropdown(
                    name: "${formSection.id!}/$x/max",
                    initialValue: element.value,
                    selectedColor: Theme.of(context).scaffoldBackgroundColor,
                    validator: (value) {
                      if (value == null || (value.toString()).isEmpty) {
                        return "Campo obrigatório";
                      }
                      return null;
                    },
                    items: List.generate(
                      1000,
                      (index) => DropdownMenuItem(
                        value: index,
                        child: Text("$index"),
                      ),
                    ),
                    title: "Máximo",
                    titleTextStyle: TextStyle(
                      color: Theme.of(context).scaffoldBackgroundColor,
                    ),
                    borderColor: Theme.of(context).scaffoldBackgroundColor,
                    style: TextStyle(
                      color: Theme.of(context).scaffoldBackgroundColor,
                    ),
                  )
                ]),
          );
          break;
        case 'DATE':
          widgets.add(
            buildField(
                sectionID: formSection.id!,
                index: x,
                titleType: "Tipo: Data",
                field: element,
                widgets: []),
          );
          break;
        case 'FILE':
          widgets.add(
            buildField(
                sectionID: formSection.id!,
                index: x,
                titleType: "Tipo: Arquivos",
                field: element,
                widgets: [
                  AddOptionsWidget(
                    fieldId: '${formSection.id!}/$x/fileTypes',
                    firstRequired: false,
                    titleButton: "Adicionar um formato especifico",
                  ),
                ]),
          );
          break;
        default:
      }
    }
    return widgets;
  }

  Widget buildField({
    required String sectionID,
    required FormFieldModel field,
    required List<Widget> widgets,
    required String titleType,
    required int index,
  }) {
    return Container(
      padding: const EdgeInsets.only(top: 15),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                titleType,
                style: TextStyle(
                  color: Theme.of(context).scaffoldBackgroundColor,
                ),
              ),
              IconButton(
                onPressed: () {
                  Utils.showPopupDialog(
                    context: context,
                    child: AlertDialog(
                      actionsAlignment: MainAxisAlignment.spaceEvenly,
                      title: Text(
                        "Deseja deletar Campo $titleType?",
                        textAlign: TextAlign.center,
                      ),
                      actions: [
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red,
                          ),
                          onPressed: () {
                            Navigator.of(context).pop();
                            CreateFormStore store = Modular.get();
                            store.deleteFieldInSection(
                              sectionId: sectionID,
                              index: index,
                            );
                          },
                          child: Text(
                            "Deletar",
                            style: TextStyle(
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                Theme.of(context).scaffoldBackgroundColor,
                          ),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text(
                            "Fechar",
                            style: TextStyle(
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
                icon: const Icon(
                  Icons.delete,
                  color: Colors.red,
                ),
              )
            ],
          ),
          const SizedBox(
            height: 8,
          ),
          CustomTextFormField(
            name: '$sectionID/$index/title',
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Campo obrigatório';
              }
              return null;
            },
            borderColor: Theme.of(context).scaffoldBackgroundColor,
            labelText: 'Titulo do campo',
            cursorColor: Theme.of(context).scaffoldBackgroundColor,
            labelStyle: TextStyle(
              color: Theme.of(context).scaffoldBackgroundColor,
            ),
            style: TextStyle(
              color: Theme.of(context).scaffoldBackgroundColor,
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          CustomTextFormField(
            name: '$sectionID/$index/description',
            borderColor: Theme.of(context).scaffoldBackgroundColor,
            labelText: 'Descrição do campo',
            cursorColor: Theme.of(context).scaffoldBackgroundColor,
            labelStyle: TextStyle(
              color: Theme.of(context).scaffoldBackgroundColor,
            ),
            style: TextStyle(
              color: Theme.of(context).scaffoldBackgroundColor,
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          CustomSwitch(
            name: '$sectionID/$index/isRequired',
            title: "Campo será obrigatório?",
            borderColor: Theme.of(context).scaffoldBackgroundColor,
            titleTextStyle: TextStyle(
              color: Theme.of(context).scaffoldBackgroundColor,
              fontSize: 15,
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          CustomTextFormField(
            name: "$sectionID/$index/label",
            initialValue: field.value,
            labelText: "Digite uma label",
            borderColor: Theme.of(context).scaffoldBackgroundColor,
            cursorColor: Theme.of(context).scaffoldBackgroundColor,
            labelStyle: TextStyle(
              color: Theme.of(context).scaffoldBackgroundColor,
            ),
            style: TextStyle(
              color: Theme.of(context).scaffoldBackgroundColor,
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          ...widgets,
          Divider(
            color: Theme.of(context).scaffoldBackgroundColor,
          )
        ],
      ),
    );
  }
}
