import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class CustomCheckbox extends StatelessWidget {
  final String name;
  final String title;
  final TextStyle? titleStyle;
  final Color? activeColor;
  final Color? checkColor;
  final bool? initialValue;
  final String? Function(bool?)? validator;
  const CustomCheckbox({
    super.key,
    required this.name,
    required this.title,
    this.titleStyle,
    this.activeColor,
    this.checkColor,
    this.initialValue,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return FormBuilderCheckbox(
      name: name,
      title: Text(
        title,
        style: titleStyle ?? const TextStyle(color: Colors.white, fontSize: 15),
      ),
      activeColor: activeColor ?? Colors.white,
      initialValue: initialValue,
      side: const BorderSide(color: Colors.white),
      validator: validator,
      visualDensity: VisualDensity.compact,
      shape: const BeveledRectangleBorder(
        side: BorderSide(
          color: Colors.white,
        ),
      ),
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
      checkColor: checkColor ?? Colors.black,
    );
  }
}
