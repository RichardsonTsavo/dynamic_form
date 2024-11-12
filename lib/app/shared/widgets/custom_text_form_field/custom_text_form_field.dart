import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class CustomTextFormField extends StatelessWidget {
  final String name;
  final Color? cursorColor;
  final Color? borderColor;
  final Color? errorBorderColor;
  final String? hintText;
  final String? labelText;
  final TextStyle? style;
  final TextStyle? labelStyle;
  final TextStyle? hintStyle;
  final TextStyle? errorStyle;
  final String? Function(String?)? validator;
  final List<TextInputFormatter>? inputFormatters;
  final String? initialValue;
  final int maxLines;
  final bool obscureText;
  final TextInputAction? textInputAction;
  final int? maxLength;
  final void Function(String?)? onChanged;
  final Widget? prefixIcon;
  final Widget? sufixIcon;
  const CustomTextFormField({
    super.key,
    required this.name,
    this.cursorColor,
    this.borderColor,
    this.errorBorderColor,
    this.hintText,
    this.style,
    this.labelText,
    this.labelStyle,
    this.errorStyle,
    this.hintStyle,
    this.validator,
    this.inputFormatters,
    this.initialValue,
    this.maxLines = 1,
    this.obscureText = false,
    this.textInputAction,
    this.maxLength,
    this.onChanged,
    this.sufixIcon,
    this.prefixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return FormBuilderTextField(
      name: name,
      cursorColor: cursorColor ?? Colors.white,
      style: style ??
          const TextStyle(
            color: Colors.white,
          ),
      validator: validator,
      inputFormatters: inputFormatters,
      initialValue: initialValue,
      maxLines: maxLines,
      minLines: 1,
      obscureText: obscureText,
      textInputAction: textInputAction,
      maxLength: maxLength,
      maxLengthEnforcement: MaxLengthEnforcement.none,
      onChanged: onChanged,
      decoration: InputDecoration(
        prefixIcon: prefixIcon,
        suffixIcon: sufixIcon,
        errorStyle: errorStyle ??
            const TextStyle(
              color: Colors.red,
            ),
        hintText: hintText,
        labelText: labelText,
        labelStyle: labelStyle ??
            const TextStyle(
              color: Colors.white70,
            ),
        hintStyle: hintStyle ??
            const TextStyle(
              color: Colors.white70,
            ),
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
