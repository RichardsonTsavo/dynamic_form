import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
// ignore: depend_on_referenced_packages
import 'package:intl/intl.dart';

class CustomDateTimePicker extends StatelessWidget {
  final String name;
  final TextStyle? style;
  final String? Function(DateTime?)? validator;
  final DateTime? initialValue;
  final String? label;
  const CustomDateTimePicker({
    super.key,
    required this.name,
    this.style,
    this.validator,
    this.initialValue,
    this.label,
  });

  @override
  Widget build(BuildContext context) {
    return FormBuilderDateTimePicker(
      name: name,
      style: style ??
          TextStyle(
            color: Theme.of(context).primaryColor,
          ),
      initialEntryMode: DatePickerEntryMode.calendar,
      initialValue: initialValue,
      validator: validator,
      format: DateFormat('dd/MM/yyyy \'às\' hh:mm'),
      inputType: InputType.both,
      decoration: InputDecoration(
        label: label != null
            ? Text("$label ${validator != null ? ' *' : ''}")
            : Text(
                "Informe uma data ${validator != null ? ' *' : ''}",
                style: style ??
                    TextStyle(
                      color: Theme.of(context).primaryColor.withAlpha(100),
                    ),
              ),
        prefixIcon: Icon(
          Icons.date_range,
          color: Theme.of(context).primaryColor,
        ),
        enabledBorder: OutlineInputBorder(
          borderSide:
              BorderSide(color: Theme.of(context).primaryColor, width: 2),
        ),
        border: OutlineInputBorder(
          borderSide:
              BorderSide(color: Theme.of(context).primaryColor, width: 2),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide:
              BorderSide(color: Theme.of(context).primaryColor, width: 2),
        ),
        errorBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red, width: 2),
        ),
      ),
    );
  }
}
