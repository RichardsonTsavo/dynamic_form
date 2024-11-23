import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import '../custom_text_form_field/custom_text_form_field.dart';

class AddOptionsWidget extends StatefulWidget {
  final String fieldId;
  final bool firstRequired;
  final String? titleButton;
  final List<String>? initialvalue;
  const AddOptionsWidget({
    super.key,
    this.titleButton,
    this.initialvalue,
    required this.fieldId,
    required this.firstRequired,
  });

  @override
  State<AddOptionsWidget> createState() => _AddOptionsWidgetState();
}

class _AddOptionsWidgetState extends State<AddOptionsWidget> {
  List<String> options = [];
  @override
  void initState() {
    if (widget.initialvalue != null) {
      options = widget.initialvalue!;
    } else {
      if (widget.firstRequired) {
        options.add('');
      }
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton(
          onPressed: () {
            setState(() {
              options.add('');
            });
          },
          child: Text(
            widget.titleButton ?? "Adicionar Opção",
          ),
        ),
        FormBuilderField<List<String>>(
          name: widget.fieldId,
          initialValue: options,
          builder: (field) {
            return Column(
              children: [
                for (int i = 0; i < options.length; i++) ...[
                  const SizedBox(
                    height: 8,
                  ),
                  CustomTextFormField(
                    name: widget.fieldId + i.toString(),
                    labelText: "Digite a opção",
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Opção obrigatória";
                      }
                      return null;
                    },
                    borderColor: Theme.of(context).scaffoldBackgroundColor,
                    cursorColor: Theme.of(context).scaffoldBackgroundColor,
                    labelStyle: TextStyle(
                      color: Theme.of(context).scaffoldBackgroundColor,
                    ),
                    style: TextStyle(
                      color: Theme.of(context).scaffoldBackgroundColor,
                    ),
                    initialValue: options[i],
                    onChanged: (value) {
                      options[i] = value ?? '';
                      field.didChange(options);
                    },
                    sufixIcon: i == 0 && widget.firstRequired
                        ? null
                        : IconButton(
                            onPressed: () {
                              setState(() {
                                options.removeAt(i);
                              });
                            },
                            icon: const Icon(
                              Icons.delete,
                              color: Colors.red,
                            ),
                          ),
                  )
                ]
              ],
            );
          },
        )
      ],
    );
  }
}
