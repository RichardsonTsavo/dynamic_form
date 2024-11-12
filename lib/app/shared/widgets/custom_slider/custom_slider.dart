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
      activeColor: Colors.white,
      inactiveColor: Colors.blueGrey,
      minValueWidget: (min) {
        return Text(
          min,
          style: const TextStyle(
            color: Colors.white,
          ),
        );
      },
      maxValueWidget: (max) {
        return Text(
          max,
          style: const TextStyle(
            color: Colors.white,
          ),
        );
      },
      valueWidget: (value) {
        return Text(
          value,
          style: const TextStyle(
            color: Colors.white,
          ),
        );
      },
      decoration: const InputDecoration(
        prefixStyle: TextStyle(
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
