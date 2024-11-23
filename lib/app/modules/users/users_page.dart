import 'package:dynamic_form/app/modules/users/users_store.dart';
import 'package:dynamic_form/app/shared/models/user/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../shared/persistent/persistent_data.dart';
import '../../shared/utils/utils.dart';
import '../../shared/widgets/index.dart';

class UsersPage extends StatefulWidget {
  final String title;
  const UsersPage({super.key, this.title = 'UsersPage'});
  @override
  UsersPageState createState() => UsersPageState();
}

class UsersPageState extends State<UsersPage> {
  final UsersStore store = Modular.get();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Usuários'),
          elevation: 5,
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: FutureBuilder<List<UserModel>>(
            future: store.getAllUsers(),
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
                    "Sem Usuários cadastrados",
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
                    searchName: snapshot.data![index].name!,
                    widget: Stack(
                      children: [
                        InkWell(
                          onTap: () {
                            PersistentData persistentData = Modular.get();
                            persistentData.login(snapshot.data![index]);
                          },
                          child: Card(
                            child: SizedBox(
                              width: constraints.maxWidth,
                              child: Column(
                                children: [
                                  Icon(
                                    Icons.person,
                                    size: constraints.maxWidth * 0.25,
                                  ),
                                  Text(
                                    snapshot.data![index].name!,
                                    maxLines: 1,
                                    textAlign: TextAlign.center,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: constraints.maxWidth * 0.06,
                                    ),
                                  ),
                                  Text(
                                    snapshot.data![index].role!,
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
                        Positioned(
                          top: 10,
                          left: 10,
                          child: CircleAvatar(
                            backgroundColor: Colors.red,
                            child: IconButton(
                              onPressed: () async {
                                await store.deleteUser(index);
                                setState(() {});
                              },
                              icon: const Icon(
                                Icons.delete,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            GlobalKey<FormBuilderState> formKey = GlobalKey<FormBuilderState>();
            Utils.showPopupDialog(
              context: context,
              child: AlertDialog(
                scrollable: true,
                actionsAlignment: MainAxisAlignment.spaceEvenly,
                title: const Text(
                  "Criar Usuário!",
                  textAlign: TextAlign.center,
                ),
                content: FormBuilder(
                  key: formKey,
                  child: Column(
                    children: [
                      CustomTextFormField(
                        name: "name",
                        labelText: 'Nome do usuário',
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
                        height: 15,
                      ),
                      CustomDropdown(
                        name: "role",
                        title: 'Tipo de Usuário',
                        borderColor: Theme.of(context).scaffoldBackgroundColor,
                        style: TextStyle(
                          color: Theme.of(context).scaffoldBackgroundColor,
                        ),
                        selectedColor:
                            Theme.of(context).scaffoldBackgroundColor,
                        titleTextStyle: TextStyle(
                          color: Theme.of(context).scaffoldBackgroundColor,
                        ),
                        items: const [
                          DropdownMenuItem(
                            value: "Cliente",
                            child: Text("Cliente"),
                          ),
                          DropdownMenuItem(
                            value: "Administrador",
                            child: Text("Administrador"),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                actions: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text("Fechar"),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      if (formKey.currentState!.saveAndValidate()) {
                        await store.createUsers(
                          UserModel(
                            id: DateTime.now()
                                .millisecondsSinceEpoch
                                .toString(),
                            name: formKey.currentState!.value['name'],
                            role: formKey.currentState!.value['role'],
                          ),
                        );
                        WidgetsBinding.instance.addPostFrameCallback(
                          (timeStamp) {
                            Navigator.of(context).pop();
                            setState(() {});
                          },
                        );
                      }
                    },
                    child: const Text("Criar"),
                  )
                ],
              ),
            );
          },
          child: const Icon(Icons.add),
        ),
      );
    });
  }
}
