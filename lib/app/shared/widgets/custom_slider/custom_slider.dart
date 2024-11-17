import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class CustomSlider extends StatelessWidget {
  final String name;
  final String? Function(double?)? validator;
  final double min;
  final double max;
  final double initialValue;
  final int? divisions;
  const CustomSlider({
    super.key,
    required this.name,
    this.validator,
    required this.min,
    required this.max,
    required this.initialValue,
    this.divisions,
  });

  @override
  Widget build(BuildContext context) {
    return FormBuilderSlider(
      name: name,
      validator: validator,
      min: min,
      max: max,
      initialValue: initialValue,
      divisions: divisions,
      activeColor: Theme.of(context).primaryColor,
      inactiveColor: Colors.blueGrey,
      minValueWidget: (min) {
        return Text(
          min,
          style: TextStyle(
            color: Theme.of(context).primaryColor,
          ),
        );
      },
      maxValueWidget: (max) {
        return Text(
          max,
          style: TextStyle(
            color: Theme.of(context).primaryColor,
          ),
        );
      },
      valueWidget: (value) {
        return Text(
          value,
          style: TextStyle(
            color: Theme.of(context).primaryColor,
          ),
        );
      },
      decoration: InputDecoration(
        prefixStyle: TextStyle(
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
