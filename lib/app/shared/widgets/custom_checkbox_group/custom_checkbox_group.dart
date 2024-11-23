import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class CustomCheckboxGroup extends StatelessWidget {
  final String name;
  final List<FormBuilderFieldOption<String>> options;
  final Color? activeColor;
  final Color? checkColor;
  final List<String>? initialValue;
  final String? Function(List<String>?)? validator;
  final String? label;
  const CustomCheckboxGroup({
    super.key,
    required this.name,
    required this.options,
    this.activeColor,
    this.checkColor,
    this.initialValue,
    this.validator,
    this.label,
  });

  @override
  Widget build(BuildContext context) {
    return FormBuilderCheckboxGroup<String>(
      name: name,
      options: options,
      itemDecoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: BorderRadius.circular(15),
      ),
      activeColor: activeColor ?? Theme.of(context).primaryColor,
      checkColor: checkColor ?? Theme.of(context).scaffoldBackgroundColor,
      validator: validator,
      initialValue: initialValue,
      wrapAlignment: WrapAlignment.spaceEvenly,
      wrapRunSpacing: 15,
      wrapSpacing: 5,
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
      separator: VerticalDivider(
        width: 10,
        thickness: 5,
        color: Theme.of(context).primaryColor,
      ),
    );
  }
}
