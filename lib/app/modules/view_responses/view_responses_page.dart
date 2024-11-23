import 'package:dynamic_form/app/modules/view_responses/view_responses_store.dart';
import 'package:dynamic_form/app/shared/models/dynamic_form/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class ViewResponsesPage extends StatefulWidget {
  final String title;
  final FormModel form;
  const ViewResponsesPage({
    super.key,
    this.title = 'ViewResponsesPage',
    required this.form,
  });
  @override
  ViewResponsesPageState createState() => ViewResponsesPageState();
}

class ViewResponsesPageState extends State<ViewResponsesPage> {
  final ViewResponsesStore store = Modular.get();

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
