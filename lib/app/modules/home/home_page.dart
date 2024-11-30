import 'package:dynamic_form/app/shared/widgets/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../shared/models/dynamic_form/index.dart';
import '../../shared/utils/utils.dart';
import 'home_store.dart';

class HomePage extends StatefulWidget {
  final String title;
  const HomePage({super.key, this.title = 'Home'});

  @override
  // ignore: library_private_types_in_public_api
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final HomeStore store;

  @override
  void initState() {
    super.initState();
    store = Modular.get<HomeStore>();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Formulário Dinâmico'),
          elevation: 5,
          actions: [
            PopupMenuButton<int>(
              onSelected: (value) {
                switch (value) {
                  case 1:
                    store.persistentData.logout();
                    break;
                }
              },
              itemBuilder: (BuildContext context) => [
                const PopupMenuItem(
                  value: 1,
                  child: Text('Logout'),
                ),
              ],
              icon: const Icon(Icons.menu),
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: FutureBuilder<List<FormModel>>(
            future: store.getAllForms(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const LoadingWidget();
              }
              if (snapshot.hasError) {
                return ErrorWidgetState(
                  errorMensage: snapshot.error.toString(),
                );
              }
              if (snapshot.data!.isEmpty) {
                return const Center(
                  child: Text(
                    "Sem formulários cadastrados",
                  ),
                );
              }
              return AnimatedListWidget(
                listType: ListType.GRID,
                withSearch: true,
                crossAxisCount: 2,
                childs: List.generate(
                  snapshot.data!.length,
                  (index) => AnimatedListModel(
                    searchName: snapshot.data![index].formName!,
                    widget: Stack(
                      children: [
                        InkWell(
                          onTap: () async {
                            if (store.persistentData.isAdmin) {
                              Modular.to.pushNamed(
                                '/view-response/',
                                arguments: snapshot.data![index],
                              );
                            } else {
                              List<FormResponseModel> responses = await store
                                  .getAllResponses(snapshot.data![index].id!);
                              List<FormResponseModel> myResponses = [];
                              for (var element in responses) {
                                if (element.user!.id ==
                                    store.persistentData.user.id) {
                                  myResponses.add(element);
                                }
                              }
                              WidgetsBinding.instance.addPostFrameCallback(
                                (timeStamp) {
                                  Utils.showPopupDialog(
                                    context: context,
                                    child: AlertDialog(
                                      scrollable: true,
                                      actionsAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      title: Text(
                                        snapshot.data![index].formName!,
                                        textAlign: TextAlign.center,
                                      ),
                                      content: Column(
                                        children: [
                                          if (myResponses.isNotEmpty)
                                            const Text(
                                              "Minhas Resposas",
                                              style: TextStyle(
                                                color: Colors.black,
                                              ),
                                            ),
                                          for (int i = 0;
                                              i < myResponses.length;
                                              i++)
                                            Card(
                                              color: Theme.of(context)
                                                  .scaffoldBackgroundColor,
                                              child: ListTile(
                                                onTap: () {
                                                  Navigator.of(context).pop();
                                                  if (snapshot.data![index]
                                                          .isEditable ==
                                                      true) {
                                                    Modular.to.navigate(
                                                      '/view-form/',
                                                      arguments: {
                                                        'form': snapshot
                                                            .data![index],
                                                        'response':
                                                            myResponses[i],
                                                      },
                                                    );
                                                  } else {
                                                    Utils.showMaterialBanner(
                                                        context: context,
                                                        mensage:
                                                            "Formulário não permite edição de resposta.");
                                                  }
                                                },
                                                leading: const Icon(
                                                  Icons.person,
                                                  color: Colors.white,
                                                ),
                                                title: Text(
                                                  "Resposta ${i + 1}",
                                                  style: const TextStyle(
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ),
                                            )
                                        ],
                                      ),
                                      actions: [
                                        ElevatedButton(
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                            child: const Text("Sair")),
                                        ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: Theme.of(context)
                                                .scaffoldBackgroundColor,
                                          ),
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                            if (myResponses.length <
                                                snapshot.data![index]
                                                    .maxResponseCount!) {
                                              Modular.to.navigate(
                                                '/view-form/',
                                                arguments: {
                                                  'form': snapshot.data![index],
                                                },
                                              );
                                            } else {
                                              Utils.showMaterialBanner(
                                                context: context,
                                                mensage:
                                                    'O usuário: ${store.persistentData.user.name} atingiu o limite de respostas do formulário.',
                                              );
                                            }
                                          },
                                          child: const Text(
                                            "Responder",
                                            style: TextStyle(
                                              color: Colors.white,
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  );
                                },
                              );
                            }
                          },
                          child: Card(
                            child: SizedBox(
                              width: constraints.maxWidth,
                              child: Column(
                                children: [
                                  Icon(
                                    Icons.list_alt_rounded,
                                    size: constraints.maxWidth * 0.25,
                                  ),
                                  Text(
                                    snapshot.data![index].formName!,
                                    maxLines: 2,
                                    textAlign: TextAlign.center,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: constraints.maxWidth * 0.06,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                        if (store.persistentData.isAdmin) ...[
                          Positioned(
                            top: 10,
                            left: 10,
                            child: CircleAvatar(
                              backgroundColor: Colors.red,
                              child: IconButton(
                                onPressed: () {
                                  Utils.showPopupDialog(
                                    context: context,
                                    child: AlertDialog(
                                      actionsAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      title: const Text(
                                        "Deseja deletar o Formulário?",
                                        textAlign: TextAlign.center,
                                      ),
                                      actions: [
                                        ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: Colors.red,
                                          ),
                                          onPressed: () async {
                                            Navigator.of(context).pop();
                                            await store.deleteForms(
                                              snapshot.data![index].id!,
                                            );
                                            setState(() {});
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
                                icon: const Icon(
                                  Icons.delete,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            top: 10,
                            right: 10,
                            child: CircleAvatar(
                              backgroundColor: Colors.black,
                              child: IconButton(
                                onPressed: () {
                                  Modular.to.navigate(
                                    '/create-form/',
                                    arguments: snapshot.data![index],
                                  );
                                },
                                icon: const Icon(
                                  Icons.edit,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          )
                        ]
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        floatingActionButton: store.persistentData.isAdmin
            ? FloatingActionButton(
                onPressed: () {
                  Modular.to.navigate('/create-form/');
                },
                child: const Icon(Icons.add),
              )
            : null,
      );
    });
  }
}
