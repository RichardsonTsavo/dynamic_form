import 'package:dynamic_form/app/modules/create_form/create_form_store.dart';
import 'package:dynamic_form/app/shared/utils/index.dart';
import 'package:dynamic_form/app/shared/widgets/index.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
      return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          child: const Icon(Icons.add),
        ),
        appBar: AppBar(
          title: Text(widget.title),
          leading: IconButton(
            onPressed: () {
              Modular.to.pop();
            },
            icon: const Icon(Icons.arrow_back_ios_new),
          ),
        ),
        body: SingleChildScrollView(
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
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                                              backgroundColor: Theme.of(context)
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
                                          alignment: WrapAlignment.spaceEvenly,
                                          spacing: 15,
                                          runSpacing: 15,
                                          children: [
                                            Container(
                                              width:
                                                  constraints.maxWidth * 0.25,
                                              height:
                                                  constraints.maxHeight * 0.1,
                                              decoration: BoxDecoration(
                                                color: Theme.of(context)
                                                    .scaffoldBackgroundColor,
                                                borderRadius:
                                                    BorderRadius.circular(15),
                                              ),
                                              child: const Padding(
                                                padding: EdgeInsets.all(8.0),
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceEvenly,
                                                  children: [
                                                    Icon(
                                                      Icons.text_fields_rounded,
                                                      color: Colors.white,
                                                    ),
                                                    Text(
                                                      "Texto simples",
                                                      textAlign:
                                                          TextAlign.center,
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                            Container(
                                              width:
                                                  constraints.maxWidth * 0.25,
                                              height:
                                                  constraints.maxHeight * 0.1,
                                              decoration: BoxDecoration(
                                                color: Theme.of(context)
                                                    .scaffoldBackgroundColor,
                                                borderRadius:
                                                    BorderRadius.circular(15),
                                              ),
                                              child: const Padding(
                                                padding: EdgeInsets.all(8.0),
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceEvenly,
                                                  children: [
                                                    Icon(
                                                      Icons.text_fields_rounded,
                                                      color: Colors.white,
                                                    ),
                                                    Text(
                                                      "Texto Longo",
                                                      textAlign:
                                                          TextAlign.center,
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                            Container(
                                              width:
                                                  constraints.maxWidth * 0.25,
                                              height:
                                                  constraints.maxHeight * 0.1,
                                              decoration: BoxDecoration(
                                                color: Theme.of(context)
                                                    .scaffoldBackgroundColor,
                                                borderRadius:
                                                    BorderRadius.circular(15),
                                              ),
                                              child: const Padding(
                                                padding: EdgeInsets.all(8.0),
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceEvenly,
                                                  children: [
                                                    Icon(
                                                      Icons.text_fields_rounded,
                                                      color: Colors.white,
                                                    ),
                                                    Text(
                                                      "CPF",
                                                      textAlign:
                                                          TextAlign.center,
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                            Container(
                                              width:
                                                  constraints.maxWidth * 0.25,
                                              height:
                                                  constraints.maxHeight * 0.1,
                                              decoration: BoxDecoration(
                                                color: Theme.of(context)
                                                    .scaffoldBackgroundColor,
                                                borderRadius:
                                                    BorderRadius.circular(15),
                                              ),
                                              child: const Padding(
                                                padding: EdgeInsets.all(8.0),
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceEvenly,
                                                  children: [
                                                    Icon(
                                                      Icons.text_fields_rounded,
                                                      color: Colors.white,
                                                    ),
                                                    Text(
                                                      "CNPJ",
                                                      textAlign:
                                                          TextAlign.center,
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                            Container(
                                              width:
                                                  constraints.maxWidth * 0.25,
                                              height:
                                                  constraints.maxHeight * 0.1,
                                              decoration: BoxDecoration(
                                                color: Theme.of(context)
                                                    .scaffoldBackgroundColor,
                                                borderRadius:
                                                    BorderRadius.circular(15),
                                              ),
                                              child: const Padding(
                                                padding: EdgeInsets.all(8.0),
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceEvenly,
                                                  children: [
                                                    Icon(
                                                      Icons.text_fields_rounded,
                                                      color: Colors.white,
                                                    ),
                                                    Text(
                                                      "CEP",
                                                      textAlign:
                                                          TextAlign.center,
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                            Container(
                                              width:
                                                  constraints.maxWidth * 0.25,
                                              height:
                                                  constraints.maxHeight * 0.1,
                                              decoration: BoxDecoration(
                                                color: Theme.of(context)
                                                    .scaffoldBackgroundColor,
                                                borderRadius:
                                                    BorderRadius.circular(15),
                                              ),
                                              child: const Padding(
                                                padding: EdgeInsets.all(8.0),
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceEvenly,
                                                  children: [
                                                    Icon(
                                                      Icons.phone,
                                                      color: Colors.white,
                                                    ),
                                                    Text(
                                                      "TELEFONE",
                                                      textAlign:
                                                          TextAlign.center,
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                            Container(
                                              width:
                                                  constraints.maxWidth * 0.25,
                                              height:
                                                  constraints.maxHeight * 0.1,
                                              decoration: BoxDecoration(
                                                color: Theme.of(context)
                                                    .scaffoldBackgroundColor,
                                                borderRadius:
                                                    BorderRadius.circular(15),
                                              ),
                                              child: const Padding(
                                                padding: EdgeInsets.all(8.0),
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceEvenly,
                                                  children: [
                                                    Icon(
                                                      Icons
                                                          .monetization_on_outlined,
                                                      color: Colors.white,
                                                    ),
                                                    Text(
                                                      "Moeda",
                                                      textAlign:
                                                          TextAlign.center,
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                            Container(
                                              width:
                                                  constraints.maxWidth * 0.25,
                                              height:
                                                  constraints.maxHeight * 0.1,
                                              decoration: BoxDecoration(
                                                color: Theme.of(context)
                                                    .scaffoldBackgroundColor,
                                                borderRadius:
                                                    BorderRadius.circular(15),
                                              ),
                                              child: const Padding(
                                                padding: EdgeInsets.all(8.0),
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceEvenly,
                                                  children: [
                                                    Icon(
                                                      CupertinoIcons
                                                          .car_detailed,
                                                      color: Colors.white,
                                                    ),
                                                    Text(
                                                      "Placa de Carro",
                                                      textAlign:
                                                          TextAlign.center,
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                            Container(
                                              width:
                                                  constraints.maxWidth * 0.25,
                                              height:
                                                  constraints.maxHeight * 0.1,
                                              decoration: BoxDecoration(
                                                color: Theme.of(context)
                                                    .scaffoldBackgroundColor,
                                                borderRadius:
                                                    BorderRadius.circular(15),
                                              ),
                                              child: const Padding(
                                                padding: EdgeInsets.all(8.0),
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceEvenly,
                                                  children: [
                                                    Icon(
                                                      Icons.credit_card,
                                                      color: Colors.white,
                                                    ),
                                                    Text(
                                                      "Cartão de Banco",
                                                      textAlign:
                                                          TextAlign.center,
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                            Container(
                                              width:
                                                  constraints.maxWidth * 0.25,
                                              height:
                                                  constraints.maxHeight * 0.1,
                                              decoration: BoxDecoration(
                                                color: Theme.of(context)
                                                    .scaffoldBackgroundColor,
                                                borderRadius:
                                                    BorderRadius.circular(15),
                                              ),
                                              child: const Padding(
                                                padding: EdgeInsets.all(8.0),
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceEvenly,
                                                  children: [
                                                    Icon(
                                                      Icons.check_box_outlined,
                                                      color: Colors.white,
                                                    ),
                                                    Text(
                                                      "CheckBox",
                                                      textAlign:
                                                          TextAlign.center,
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                            Container(
                                              width:
                                                  constraints.maxWidth * 0.25,
                                              height:
                                                  constraints.maxHeight * 0.1,
                                              decoration: BoxDecoration(
                                                color: Theme.of(context)
                                                    .scaffoldBackgroundColor,
                                                borderRadius:
                                                    BorderRadius.circular(15),
                                              ),
                                              child: const Padding(
                                                padding: EdgeInsets.all(8.0),
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceEvenly,
                                                  children: [
                                                    Icon(
                                                      Icons.list,
                                                      color: Colors.white,
                                                    ),
                                                    Text(
                                                      "DropDown",
                                                      textAlign:
                                                          TextAlign.center,
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                            Container(
                                              width:
                                                  constraints.maxWidth * 0.25,
                                              height:
                                                  constraints.maxHeight * 0.1,
                                              decoration: BoxDecoration(
                                                color: Theme.of(context)
                                                    .scaffoldBackgroundColor,
                                                borderRadius:
                                                    BorderRadius.circular(15),
                                              ),
                                              child: const Padding(
                                                padding: EdgeInsets.all(8.0),
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceEvenly,
                                                  children: [
                                                    Icon(
                                                      CupertinoIcons
                                                          .arrow_right_arrow_left_square,
                                                      color: Colors.white,
                                                    ),
                                                    Text(
                                                      "Switch",
                                                      textAlign:
                                                          TextAlign.center,
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                            Container(
                                              width:
                                                  constraints.maxWidth * 0.25,
                                              height:
                                                  constraints.maxHeight * 0.1,
                                              decoration: BoxDecoration(
                                                color: Theme.of(context)
                                                    .scaffoldBackgroundColor,
                                                borderRadius:
                                                    BorderRadius.circular(15),
                                              ),
                                              child: const Padding(
                                                padding: EdgeInsets.all(8.0),
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceEvenly,
                                                  children: [
                                                    Icon(
                                                      Icons.group_work_outlined,
                                                      color: Colors.white,
                                                    ),
                                                    Text(
                                                      "Grupo de checkBox",
                                                      textAlign:
                                                          TextAlign.center,
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                            Container(
                                              width:
                                                  constraints.maxWidth * 0.25,
                                              height:
                                                  constraints.maxHeight * 0.1,
                                              decoration: BoxDecoration(
                                                color: Theme.of(context)
                                                    .scaffoldBackgroundColor,
                                                borderRadius:
                                                    BorderRadius.circular(15),
                                              ),
                                              child: const Padding(
                                                padding: EdgeInsets.all(8.0),
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceEvenly,
                                                  children: [
                                                    Icon(
                                                      CupertinoIcons
                                                          .slider_horizontal_3,
                                                      color: Colors.white,
                                                    ),
                                                    Text(
                                                      "Slider",
                                                      textAlign:
                                                          TextAlign.center,
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                            Container(
                                              width:
                                                  constraints.maxWidth * 0.25,
                                              height:
                                                  constraints.maxHeight * 0.1,
                                              decoration: BoxDecoration(
                                                color: Theme.of(context)
                                                    .scaffoldBackgroundColor,
                                                borderRadius:
                                                    BorderRadius.circular(15),
                                              ),
                                              child: const Padding(
                                                padding: EdgeInsets.all(8.0),
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceEvenly,
                                                  children: [
                                                    Icon(
                                                      Icons.date_range,
                                                      color: Colors.white,
                                                    ),
                                                    Text(
                                                      "Data",
                                                      textAlign:
                                                          TextAlign.center,
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                            Container(
                                              width:
                                                  constraints.maxWidth * 0.25,
                                              height:
                                                  constraints.maxHeight * 0.1,
                                              decoration: BoxDecoration(
                                                color: Theme.of(context)
                                                    .scaffoldBackgroundColor,
                                                borderRadius:
                                                    BorderRadius.circular(15),
                                              ),
                                              child: const Padding(
                                                padding: EdgeInsets.all(8.0),
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceEvenly,
                                                  children: [
                                                    Icon(
                                                      Icons.file_present,
                                                      color: Colors.white,
                                                    ),
                                                    Text(
                                                      "Arquivo",
                                                      textAlign:
                                                          TextAlign.center,
                                                    )
                                                  ],
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                        actions: [
                                          ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor: Theme.of(context)
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
                            )
                          ],
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
                          onPressed: () {},
                          child: const Text(
                            "Salvar",
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            );
          }),
        ),
      );
    });
  }
}
