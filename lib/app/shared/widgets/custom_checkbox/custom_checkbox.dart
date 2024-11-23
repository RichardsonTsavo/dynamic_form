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
  final String? label;
  const CustomCheckbox({
    super.key,
    required this.name,
    required this.title,
    this.titleStyle,
    this.activeColor,
    this.checkColor,
    this.initialValue,
    this.validator,
    this.label,
  });

  @override
  Widget build(BuildContext context) {
    return FormBuilderCheckbox(
      name: name,
      title: Text(
        title,
        style: titleStyle ??
            TextStyle(color: Theme.of(context).primaryColor, fontSize: 15),
      ),
      activeColor: activeColor ?? Theme.of(context).primaryColor,
      initialValue: initialValue,
      side: BorderSide(color: Theme.of(context).primaryColor),
      validator: validator,
      visualDensity: VisualDensity.compact,
      shape: BeveledRectangleBorder(
        side: BorderSide(
          color: Theme.of(context).primaryColor,
        ),
      ),
      decoration: InputDecoration(
        label: label != null
            ? Text("$label ${validator != null ? ' *' : ''}")
            : null,
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
        isDense: true,
        isCollapsed: false,
      ),
      checkColor: checkColor ?? Colors.black,
    );
  }
}
