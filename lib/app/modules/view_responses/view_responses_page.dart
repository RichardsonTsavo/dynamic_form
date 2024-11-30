import 'package:dynamic_form/app/modules/view_responses/view_responses_store.dart';
import 'package:dynamic_form/app/shared/models/dynamic_form/index.dart';
import 'package:dynamic_form/app/shared/utils/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../shared/widgets/index.dart';

class ViewResponsesPage extends StatefulWidget {
  final String title;
  final FormModel form;
  const ViewResponsesPage({
    super.key,
    this.title = 'Responstas',
    required this.form,
  });
  @override
  ViewResponsesPageState createState() => ViewResponsesPageState();
}

class ViewResponsesPageState extends State<ViewResponsesPage> {
  final ViewResponsesStore store = Modular.get();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: FutureBuilder(
          future: store.getAllResponses(widget.form.id!),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: LoadingWidget(),
              );
            }
            if (snapshot.hasError) {
              return ErrorWidgetState(errorMensage: snapshot.error.toString());
            }

            if (snapshot.data!.isEmpty) {
              return const Center(
                child: Text(
                  "Sem respostas cadastrados",
                ),
              );
            }
            return AnimatedListWidget(
              listType: ListType.LIST,
              childs: List.generate(
                snapshot.data!.length,
                (index) => AnimatedListModel(
                  searchName: snapshot.data![index].user!.name!,
                  widget: Card(
                      child: ListTile(
                    onTap: () {
                      Utils.showPopupDialog(
                        context: context,
                        child: AlertDialog(
                          scrollable: true,
                          actionsAlignment: MainAxisAlignment.spaceEvenly,
                          title: Text(
                            widget.form.formName!,
                            textAlign: TextAlign.center,
                          ),
                          content: Column(
                            children: [
                              for (var section in widget.form.sections!)
                                for (var field in section.fields!) ...[
                                  Text(
                                    "Campo: ${field.title}",
                                    style: TextStyle(
                                      color: Theme.of(context)
                                          .scaffoldBackgroundColor,
                                      fontWeight: FontWeight.bold,
                                      fontSize: constraints.maxWidth * 0.05,
                                    ),
                                  ),
                                  Text(
                                    "Resposta:",
                                    style: TextStyle(
                                      color: Theme.of(context)
                                          .scaffoldBackgroundColor,
                                      fontSize: constraints.maxWidth * 0.04,
                                    ),
                                  ),
                                  getResponse(
                                    constraints: constraints,
                                    field: field,
                                    response: snapshot
                                        .data![index].response![field.id],
                                  ),
                                  Divider(
                                    color: Theme.of(context)
                                        .scaffoldBackgroundColor,
                                  )
                                ]
                            ],
                          ),
                          actions: [
                            ElevatedButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: const Text("Sair"),
                            )
                          ],
                        ),
                      );
                    },
                    leading: const Icon(Icons.person),
                    title: Text(
                      snapshot.data![index].user!.name!,
                      overflow: TextOverflow.ellipsis,
                    ),
                    trailing: IconButton(
                        onPressed: () async {
                          await store.deleteResponse(snapshot.data![index].id!);
                          setState(() {});
                        },
                        icon: const Icon(
                          Icons.delete,
                          color: Colors.red,
                        )),
                  )),
                ),
              ),
            );
          },
        ),
      );
    });
  }

  Widget getResponse({
    required FormFieldModel field,
    required dynamic response,
    required BoxConstraints constraints,
  }) {
    switch (field.fieldType) {
      case "CHECKBOX" || "SWITCH":
        return Text(
          response != null
              ? (response == true ? "Sim" : "Não")
              : "Sem resposta",
          style: TextStyle(
            color: Theme.of(context).scaffoldBackgroundColor,
            fontSize: constraints.maxWidth * 0.04,
          ),
        );
      case "SLIDER":
        return Text(
          response != null
              ? (response as double).toStringAsFixed(2)
              : "Sem resposta",
          style: TextStyle(
            color: Theme.of(context).scaffoldBackgroundColor,
            fontSize: constraints.maxWidth * 0.04,
          ),
        );
      case "DATE":
        return Text(
          response != null
              ? Utils.dateTimeParseString(
                  date: DateTime.fromMillisecondsSinceEpoch(response),
                  setHours: true)
              : "Sem resposta",
          style: TextStyle(
            color: Theme.of(context).scaffoldBackgroundColor,
            fontSize: constraints.maxWidth * 0.04,
          ),
        );
      case "FILE":
        return CustomFilePicker(
          canRemoveImage: false,
          name: field.id!,
          readOnly: true,
          initialValue: getInitialFileValue(response),
        );
      default:
        return Text(
          "${response ?? "Sem resposta"}",
          style: TextStyle(
            color: Theme.of(context).scaffoldBackgroundColor,
            fontSize: constraints.maxWidth * 0.04,
          ),
        );
    }
  }

  List<FileDataModel>? getInitialFileValue(dynamic info) {
    if (info.runtimeType == List<dynamic>) {
      List<FileDataModel> data = [];
      for (var element in (info as List<dynamic>)) {
        data.add(FileDataModel.fromMap(element));
      }
      return data;
    } else {
      return info;
    }
  }
}
