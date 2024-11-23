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
  final TextInputType? keyboardType;
  final int? maxLength;
  final void Function(String?)? onChanged;
  final Widget? prefixIcon;
  final Widget? sufixIcon;
  const CustomTextFormField(
      {super.key,
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
      this.keyboardType});

  @override
  Widget build(BuildContext context) {
    return FormBuilderTextField(
      name: name,
      cursorColor: cursorColor ?? Theme.of(context).primaryColor,
      style: style ??
          TextStyle(
            color: Theme.of(context).primaryColor,
          ),
      validator: validator,
      inputFormatters: inputFormatters,
      initialValue: initialValue,
      maxLines: maxLines,
      minLines: maxLines,
      obscureText: obscureText,
      textInputAction: textInputAction,
      keyboardType: keyboardType,
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
        hintText:
            hintText != null && validator != null ? '${hintText!} *' : hintText,
        labelText: labelText != null && validator != null
            ? '${labelText!} *'
            : labelText,
        labelStyle: labelStyle ??
            TextStyle(
              color: Theme.of(context).primaryColor.withAlpha(178),
            ),
        hintStyle: hintStyle ??
            TextStyle(
              color: Theme.of(context).primaryColor.withAlpha(178),
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
