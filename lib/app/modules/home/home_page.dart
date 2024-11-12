import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../shared/widgets/index.dart';
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
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        title: const Text('Dynamic Form'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              const CustomTextFormField(
                name: 'normalTextfield',
                labelText: "Texto Normal",
              ),
              const SizedBox(
                height: 8,
              ),
              const CustomCheckbox(
                name: 'checkbox',
                title: "Checkbox",
              ),
              const SizedBox(
                height: 8,
              ),
              CustomDropdown(
                name: 'dropdown',
                title: 'Dropdown',
                items: List.generate(
                  5,
                  (index) => DropdownMenuItem(
                    value: index + 1,
                    child: Text('Opção ${index + 1}'),
                  ),
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              const CustomSwitch(
                name: 'switch',
                title: "Switch",
              ),
              const SizedBox(
                height: 8,
              ),
              const CustomCheckboxGroup(
                name: 'CheckboxGroup',
                options: [
                  FormBuilderFieldOption(value: 'Dart'),
                  FormBuilderFieldOption(value: 'Kotlin'),
                  FormBuilderFieldOption(value: 'Java'),
                  FormBuilderFieldOption(value: 'Swift'),
                  FormBuilderFieldOption(value: 'Objective-C'),
                ],
              ),
              const SizedBox(
                height: 8,
              ),
              const CustomSlider(
                min: 0,
                max: 10,
                divisions: 10,
                initialValue: 5,
                name: 'slider',
              ),
              const SizedBox(
                height: 8,
              ),
              const CustomDateTimePicker(
                name: 'date',
              ),
              const SizedBox(
                height: 8,
              ),
              const CustomFilePicker(
                name: 'file',
              ),
              const SizedBox(
                height: 15,
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
    );
  }
}
