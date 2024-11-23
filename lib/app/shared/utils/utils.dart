import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';

class Utils {
  static String dateTimeParseString(
      {required DateTime? date, required bool setHours}) {
    if (date == null) {
      return "Data não informada";
    }
    String day = date.day.toString();
    String month = date.month.toString();
    String year = date.year.toString();
    String hour = date.hour.toString();
    String minutes = date.minute.toString();
    if (setHours) {
      return "${day.padLeft(2, "0")}/${month.padLeft(2, "0")}/$year às ${hour.padLeft(2, "0")}:${minutes.padLeft(2, "0")}";
    } else {
      return "${day.padLeft(2, "0")}/${month.padLeft(2, "0")}/$year";
    }
  }

  static String doubleToRealString(double value, {bool addSymbol = true}) {
    return UtilBrasilFields.obterReal(value, moeda: addSymbol);
  }

  static double realToDouble(
    String? value,
  ) {
    if (value == null || value.isEmpty) {
      return 0;
    }
    return UtilBrasilFields.converterMoedaParaDouble(value);
  }

  static List<String> allowedExtensions() =>
      ["pdf", "PDF", "jpg", "JPG", "png", "PNG", "jpeg", "JPEG", "gif", "GIF"];

  static String contentType(String extension) {
    switch (extension) {
      case "pdf":
        return "application/pdf";
      case "PDF":
        return "application/pdf";
      case "jpg":
        return "image/jpg";
      case "JPG":
        return "image/jpg";
      case "png":
        return "image/png";
      case "PNG":
        return "image/png";
      case "jpeg":
        return "image/jpeg";
      case "JPEG":
        return "image/jpeg";
      case "gif":
        return "image/gif";
      case "GIF":
        return "image/gif";
      default:
        return "";
    }
  }

  static Future showPopupDialog(
      {required BuildContext context,
      required Widget child,
      bool barrierDismissible = true}) async {
    return await showDialog(
      barrierDismissible: barrierDismissible,
      context: context,
      builder: (BuildContext context) {
        return child;
      },
    );
  }

  static Future showGeneralDialog(
      {required BuildContext context, required Widget child}) async {
    return await showGeneralDialog(
      context: context,
      child: child,
    );
  }

  static void showSnackBar(
      {required BuildContext context, required String mensage}) {
    final snackBar = SnackBar(
      content: Text(mensage),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  static void showMaterialBanner(
      {required BuildContext context, required String mensage, Color? color}) {
    final materialBanner = MaterialBanner(
      content: Text(
        mensage,
        style: const TextStyle(color: Colors.white),
      ),
      backgroundColor: color ?? Colors.black,
      leading: const Icon(Icons.info, color: Colors.white),
      actions: [
        TextButton(
          onPressed: () {
            ScaffoldMessenger.of(context).hideCurrentMaterialBanner();
          },
          child: const Icon(
            Icons.close,
            color: Colors.white,
          ),
        ),
      ],
    );
    ScaffoldMessenger.of(context).showMaterialBanner(materialBanner);
    Future.delayed(const Duration(seconds: 5)).then((value) {
      WidgetsBinding.instance.addPostFrameCallback(
        (timeStamp) {
          ScaffoldMessenger.of(context).hideCurrentMaterialBanner();
        },
      );
    });
  }
}
