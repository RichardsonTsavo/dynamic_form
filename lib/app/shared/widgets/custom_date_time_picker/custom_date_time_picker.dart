import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
// ignore: depend_on_referenced_packages
import 'package:intl/intl.dart';

class CustomDateTimePicker extends StatelessWidget {
  final String name;
  final TextStyle? style;
  final TimeOfDay? timeOfDay;
  final String? Function(DateTime?)? validator;
  final DateTime? initialValue;
  const CustomDateTimePicker({
    super.key,
    required this.name,
    this.style,
    this.timeOfDay,
    this.validator,
    this.initialValue,
  });

  @override
  Widget build(BuildContext context) {
    return FormBuilderDateTimePicker(
      name: name,
      style: style ??
          const TextStyle(
            color: Colors.white,
          ),
      initialEntryMode: DatePickerEntryMode.calendar,
      initialDate: DateTime.now(),
      initialTime: timeOfDay ?? TimeOfDay.now(),
      initialValue: initialValue,
      validator: validator,
      format: DateFormat('dd-MM-yyyy / mm:ss'),
      inputType: InputType.both,
      decoration: const InputDecoration(
        prefixIcon: Icon(
          Icons.date_range,
          color: Colors.white,
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white, width: 2),
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white, width: 2),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red, width: 2),
        ),
      ),
    );
  }
}
