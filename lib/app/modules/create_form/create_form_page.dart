import 'package:dynamic_form/app/modules/create_form/create_form_store.dart';
import 'package:dynamic_form/app/shared/utils/index.dart';
import 'package:dynamic_form/app/shared/widgets/index.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

class CreateFormPage extends StatefulWidget {
  final String title;
  const CreateFormPage({super.key, this.title = 'Criar novo formulário'});
  @override
  CreateFormPageState createState() => CreateFormPageState();
}

class CreateFormPageState extends State<CreateFormPage> {
  final CreateFormStore store = Modular.get();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      store.formWidgetBuilderAdmin ??= FormWidgetBuilderAdmin(
        constraints: constraints,
        context: context,
      );
      return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          child: const Icon(Icons.add),
        ),
        appBar: AppBar(
          title: Text(widget.title),
          leading: IconButton(
            onPressed: () {
              Modular.to.navigate('/');
            },
            icon: const Icon(Icons.arrow_back_ios_new),
          ),
        ),
        body: FormBuilder(
          key: store.formKey,
          child: SingleChildScrollView(
            child: Observer(builder: (context) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: <Widget>[
                    CustomTextFormField(
                      name: "title",
                      labelText: "Titulo do formulário",
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "O titulo é obrigatório";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    const CustomSwitch(
                      name: 'isEditable',
                      title: "Formulário editavel depois de enviado?",
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    CustomDropdown(
                      name: "maxResponseCount",
                      title: "Quantas vezes o usuário pode responder?",
                      items: List.generate(
                        100,
                        (index) => DropdownMenuItem(
                          value: (index + 1).toString(),
                          child: Text("${index + 1}"),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "O titulo é obrigatório";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    for (int i = 0; i < store.sections.length; i++)
                      Card(
                        child: Container(
                          width: constraints.maxHeight,
                          constraints: BoxConstraints(
                            minHeight: constraints.maxHeight * 0.2,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.red,
                                      ),
                                      onPressed: () {
                                        Utils.showPopupDialog(
                                          context: context,
                                          child: AlertDialog(
                                            actionsAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            title: const Text(
                                              "Deseja deletar sessão?",
                                              textAlign: TextAlign.center,
                                            ),
                                            actions: [
                                              ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                  backgroundColor: Colors.red,
                                                ),
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                  store.deleteSection(index: i);
                                                },
                                                child: Text(
                                                  "Deletar",
                                                  style: TextStyle(
                                                    color: Theme.of(context)
                                                        .primaryColor,
                                                  ),
                                                ),
                                              ),
                                              ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                  backgroundColor: Theme.of(
                                                          context)
                                                      .scaffoldBackgroundColor,
                                                ),
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                },
                                                child: Text(
                                                  "Fechar",
                                                  style: TextStyle(
                                                    color: Theme.of(context)
                                                        .primaryColor,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        );
                                      },
                                      child: Text(
                                        "Remover Sessão",
                                        style: TextStyle(
                                          color: Theme.of(context).primaryColor,
                                        ),
                                      ),
                                    ),
                                    ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Theme.of(context)
                                            .scaffoldBackgroundColor,
                                      ),
                                      onPressed: () {
                                        Utils.showPopupDialog(
                                          context: context,
                                          child: AlertDialog(
                                            scrollable: true,
                                            actionsAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            title: const Text(
                                              "Qual tipo de campo você quer adicionar?",
                                              textAlign: TextAlign.center,
                                            ),
                                            content: Wrap(
                                              alignment:
                                                  WrapAlignment.spaceEvenly,
                                              spacing: 15,
                                              runSpacing: 15,
                                              children: [
                                                fieldSelectWidget(
                                                  index: i,
                                                  constraints: constraints,
                                                  title: "Texto simples",
                                                  icon:
                                                      Icons.text_fields_rounded,
                                                  fieldID: 'TEXT',
                                                ),
                                                fieldSelectWidget(
                                                  index: i,
                                                  constraints: constraints,
                                                  title: "Texto Longo",
                                                  icon:
                                                      Icons.text_fields_rounded,
                                                  fieldID: 'LONGTEXT',
                                                ),
                                                fieldSelectWidget(
                                                  index: i,
                                                  constraints: constraints,
                                                  title: "CPF",
                                                  icon:
                                                      Icons.text_fields_rounded,
                                                  fieldID: 'CPF',
                                                ),
                                                fieldSelectWidget(
                                                  index: i,
                                                  constraints: constraints,
                                                  title: "CNPJ",
                                                  icon:
                                                      Icons.text_fields_rounded,
                                                  fieldID: 'CNPJ',
                                                ),
                                                fieldSelectWidget(
                                                  index: i,
                                                  constraints: constraints,
                                                  title: "CEP",
                                                  icon:
                                                      Icons.text_fields_rounded,
                                                  fieldID: 'CEP',
                                                ),
                                                fieldSelectWidget(
                                                  index: i,
                                                  constraints: constraints,
                                                  title: "Telefone",
                                                  icon: Icons.phone,
                                                  fieldID: 'PHONE',
                                                ),
                                                fieldSelectWidget(
                                                  index: i,
                                                  constraints: constraints,
                                                  title: "Moeda",
                                                  icon: Icons
                                                      .monetization_on_outlined,
                                                  fieldID: 'CURRENCY',
                                                ),
                                                fieldSelectWidget(
                                                  index: i,
                                                  constraints: constraints,
                                                  title: "Placa de Carro",
                                                  icon: CupertinoIcons
                                                      .car_detailed,
                                                  fieldID: 'CARPLATE',
                                                ),
                                                fieldSelectWidget(
                                                  index: i,
                                                  constraints: constraints,
                                                  title: "Cartão de Banco",
                                                  icon: Icons.credit_card,
                                                  fieldID: 'BANKCARD',
                                                ),
                                                fieldSelectWidget(
                                                  index: i,
                                                  constraints: constraints,
                                                  title: "CheckBox",
                                                  icon:
                                                      Icons.check_box_outlined,
                                                  fieldID: 'CHECKBOX',
                                                ),
                                                fieldSelectWidget(
                                                  index: i,
                                                  constraints: constraints,
                                                  title: "DropDown",
                                                  icon: Icons.list,
                                                  fieldID: 'DROPDOWN',
                                                ),
                                                fieldSelectWidget(
                                                  index: i,
                                                  constraints: constraints,
                                                  title: "Switch",
                                                  icon: CupertinoIcons
                                                      .arrow_right_arrow_left_square,
                                                  fieldID: 'SWITCH',
                                                ),
                                                fieldSelectWidget(
                                                  index: i,
                                                  constraints: constraints,
                                                  title: "Grupo de CheckBox",
                                                  icon:
                                                      Icons.group_work_outlined,
                                                  fieldID: 'CHECKBOXGROUP',
                                                ),
                                                fieldSelectWidget(
                                                  index: i,
                                                  constraints: constraints,
                                                  title: "Slider",
                                                  icon: CupertinoIcons
                                                      .slider_horizontal_3,
                                                  fieldID: 'SLIDER',
                                                ),
                                                fieldSelectWidget(
                                                  index: i,
                                                  constraints: constraints,
                                                  title: "Data",
                                                  icon: Icons.date_range,
                                                  fieldID: 'DATE',
                                                ),
                                                fieldSelectWidget(
                                                  index: i,
                                                  constraints: constraints,
                                                  title: "Arquivo",
                                                  icon: Icons.file_present,
                                                  fieldID: 'FILE',
                                                ),
                                              ],
                                            ),
                                            actions: [
                                              ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                  backgroundColor: Theme.of(
                                                          context)
                                                      .scaffoldBackgroundColor,
                                                ),
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                },
                                                child: Text(
                                                  "Fechar",
                                                  style: TextStyle(
                                                    color: Theme.of(context)
                                                        .primaryColor,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        );
                                      },
                                      child: Text(
                                        "Adicionar Campo",
                                        style: TextStyle(
                                          color: Theme.of(context).primaryColor,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                ...store.formWidgetBuilderAdmin!.buildForm(
                                  formKey: store.formKey,
                                  formSection: store.sections[i],
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              store.addSection();
                            },
                            child: const Text(
                              "Adicionar Sessão",
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              if (store.formKey.currentState!
                                  .saveAndValidate()) {
                                store.saveForm(
                                  form: store.formKey.currentState!.value,
                                  context: context,
                                );
                              }
                            },
                            child: const Text(
                              "Salvar",
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }),
          ),
        ),
      );
    });
  }

  Widget fieldSelectWidget({
    required int index,
    required BoxConstraints constraints,
    required IconData icon,
    required String title,
    required String fieldID,
  }) {
    return InkWell(
      onTap: () {
        Navigator.of(context).pop();
        store.addFieldInSection(fieldType: fieldID, index: index);
      },
      child: Container(
        width: constraints.maxWidth * 0.25,
        height: constraints.maxHeight * 0.1,
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Icon(
                icon,
                color: Colors.white,
              ),
              Text(
                title,
                textAlign: TextAlign.center,
              )
            ],
          ),
        ),
      ),
    );
  }
}
