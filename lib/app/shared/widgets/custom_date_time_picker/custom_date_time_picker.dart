import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
// ignore: depend_on_referenced_packages
import 'package:intl/intl.dart';

class CustomDateTimePicker extends StatelessWidget {
  final String name;
  final TextStyle? style;
  final String? Function(DateTime?)? validator;
  final DateTime? initialValue;
  const CustomDateTimePicker({
    super.key,
    required this.name,
    this.style,
    this.validator,
    this.initialValue,
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
      initialDate: DateTime.now(),
      initialTime: TimeOfDay.now(),
      initialValue: initialValue ?? DateTime.now(),
      validator: validator,
      format: DateFormat('dd-MM-yyyy \'às\' mm:ss'),
      inputType: InputType.both,
      decoration: InputDecoration(
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
