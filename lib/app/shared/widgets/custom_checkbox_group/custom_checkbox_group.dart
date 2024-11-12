import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class CustomCheckboxGroup extends StatelessWidget {
  final String name;
  final List<FormBuilderFieldOption<String>> options;
  final Color? activeColor;
  final Color? checkColor;
  final List<String>? initialValue;
  final String? Function(List<String>?)? validator;
  const CustomCheckboxGroup({
    super.key,
    required this.name,
    required this.options,
    this.activeColor,
    this.checkColor,
    this.initialValue,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return FormBuilderCheckboxGroup<String>(
      name: name,
      options: options,
      itemDecoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      activeColor: activeColor ?? Colors.black,
      checkColor: checkColor ?? Colors.white,
      validator: validator,
      initialValue: initialValue,
      wrapAlignment: WrapAlignment.spaceEvenly,
      wrapRunSpacing: 15,
      wrapSpacing: 5,
      decoration: const InputDecoration(
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
        isDense: true,
        isCollapsed: false,
      ),
      separator: const VerticalDivider(
        width: 10,
        thickness: 5,
        color: Colors.white,
      ),
    );
  }
}
