import 'package:dynamic_form/app/modules/create_form/create_form_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class CreateFormPage extends StatefulWidget {
  final String title;
  const CreateFormPage({super.key, this.title = 'Create Form Page'});
  @override
  CreateFormPageState createState() => CreateFormPageState();
}

class CreateFormPageState extends State<CreateFormPage> {
  final CreateFormStore store = Modular.get();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: const Column(
        children: <Widget>[],
      ),
    );
  }
}
