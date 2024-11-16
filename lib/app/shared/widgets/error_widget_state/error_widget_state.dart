import 'package:flutter/material.dart';

class ErrorWidgetState extends StatelessWidget {
  final String errorMensage;
  const ErrorWidgetState({super.key, required this.errorMensage});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(child: Text(errorMensage)),
    );
  }
}
