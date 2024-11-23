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
  final Color? selectedColor;
  final dynamic initialValue;
  final String? Function(dynamic)? validator;
  const CustomDropdown({
    super.key,
    required this.name,
    required this.title,
    required this.items,
    this.titleTextStyle,
    this.style,
    this.borderColor,
    this.selectedColor,
    this.errorBorderColor,
    this.initialValue,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return FormBuilderDropdown(
      name: name,
      initialValue: initialValue,
      validator: validator,
      iconEnabledColor: Theme.of(context).primaryColor,
      items: items,
      style: style ??
          const TextStyle(
            color: Colors.black,
          ),
      menuMaxHeight: MediaQuery.of(context).size.height / 2,
      selectedItemBuilder: (context) {
        return items.map((DropdownMenuItem item) {
          return Text(
            item.value.toString(),
            style: TextStyle(
              color: selectedColor ?? Theme.of(context).primaryColor,
            ),
          );
        }).toList();
      },
      decoration: InputDecoration(
        label: Text(
          '$title${validator != null ? ' *' : ''}',
          style: titleTextStyle ??
              TextStyle(
                color: Theme.of(context).primaryColor,
                fontSize: 15,
              ),
        ),
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
