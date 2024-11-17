import 'package:flutter/material.dart';

class LoadingWidget extends StatelessWidget {
  final Color? loadingColor;
  const LoadingWidget({
    super.key,
    this.loadingColor,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation(
            loadingColor ?? Theme.of(context).primaryColor,
          ),
        ),
      ),
    );
  }
}
