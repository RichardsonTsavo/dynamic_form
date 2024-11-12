import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class CustomDropdown extends StatelessWidget {
  final String name;
  final String title;
  final TextStyle? titleTextStyle;
  final TextStyle? style;
  final List<DropdownMenuItem> items;
  final Color? borderColor;
  final Color? errorBorderColor;
  final dynamic initialValue;
  const CustomDropdown({
    super.key,
    required this.name,
    required this.title,
    required this.items,
    this.titleTextStyle,
    this.style,
    this.borderColor,
    this.errorBorderColor,
    this.initialValue,
  });

  @override
  Widget build(BuildContext context) {
    return FormBuilderDropdown(
      name: name,
      initialValue: initialValue,
      hint: Text(
        title,
        style: titleTextStyle ??
            const TextStyle(
              color: Colors.white,
              fontSize: 15,
            ),
      ),
      iconEnabledColor: Colors.white,
      items: items,
      style: style ??
          const TextStyle(
            color: Colors.white,
          ),
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderSide: BorderSide(
            color: borderColor ?? Colors.white,
            style: BorderStyle.solid,
            width: 2,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: borderColor ?? Colors.white,
            style: BorderStyle.solid,
            width: 2,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: errorBorderColor ?? Colors.red,
            style: BorderStyle.solid,
            width: 2,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: borderColor ?? Colors.white,
            style: BorderStyle.solid,
            width: 2,
          ),
        ),
      ),
    );
  }
}
