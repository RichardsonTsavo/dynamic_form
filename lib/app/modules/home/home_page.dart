import 'package:dynamic_form/app/shared/widgets/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../shared/models/index.dart';
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
                    widget: Card(
                      child: Column(
                        children: [
                          const Icon(Icons.list_alt_rounded),
                          Text(snapshot.data![index].formName!)
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Modular.to.pushNamed('/create-form');
          },
          child: const Icon(Icons.add),
        ),
      );
    });
  }
}
