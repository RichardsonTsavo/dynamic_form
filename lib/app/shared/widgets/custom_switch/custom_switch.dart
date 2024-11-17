import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class CustomSwitch extends StatelessWidget {
  final String name;
  final String title;
  final TextStyle? titleTextStyle;
  final Color? borderColor;
  final Color? errorBorderColor;
  final Color? activeColor;
  final bool? initialValue;
  final String? Function(dynamic)? validator;
  const CustomSwitch({
    super.key,
    required this.name,
    required this.title,
    this.initialValue,
    this.titleTextStyle,
    this.borderColor,
    this.errorBorderColor,
    this.activeColor,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return FormBuilderSwitch(
      name: name,
      initialValue: initialValue ?? false,
      validator: validator,
      title: Text(
        title,
        style: titleTextStyle ??
            TextStyle(
              color: Theme.of(context).primaryColor,
              fontSize: 15,
            ),
      ),
      activeColor: activeColor ?? Theme.of(context).primaryColor,
      activeTrackColor: Colors.black,
      decoration: InputDecoration(
        isDense: true,
        border: OutlineInputBorder(
          borderSide: BorderSide(
            color: borderColor ?? Theme.of(context).primaryColor,
            style: BorderStyle.solid,
            width: 2,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: borderColor ?? Theme.of(context).primaryColor,
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
            color: borderColor ?? Theme.of(context).primaryColor,
            style: BorderStyle.solid,
            width: 2,
          ),
        ),
      ),
    );
  }
}
