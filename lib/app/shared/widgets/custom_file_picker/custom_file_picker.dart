import 'dart:typed_data';

import 'package:dynamic_form/app/shared/utils/index.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import '../../models/index.dart';

class CustomFilePicker extends StatefulWidget {
  final String name;
  final List<String>? allowedExtensions;
  final bool allowMultiple;
  final String? Function(List<FileDataModel>?)? validator;
  final List<FileDataModel>? initialValue;
  const CustomFilePicker({
    super.key,
    required this.name,
    this.allowMultiple = false,
    this.allowedExtensions,
    this.validator,
    this.initialValue,
  });

  @override
  State<CustomFilePicker> createState() => _CustomFilePickerState();
}

class _CustomFilePickerState extends State<CustomFilePicker> {
  @override
  Widget build(BuildContext context) {
    return FormBuilderField<List<FileDataModel>>(
      name: widget.name,
      validator: widget.validator,
      initialValue: widget.initialValue,
      builder: (field) {
        return GestureDetector(
          onTap: () async {
            List<FileDataModel> files = await getPicker();
            if (files.isNotEmpty) {
              field.didChange(files);
            }
          },
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: 250,
            decoration: BoxDecoration(
              border:
                  Border.all(color: Theme.of(context).primaryColor, width: 2),
            ),
            child: field.value == null || field.value!.isEmpty
                ? Center(
                    child: Text(
                      "Selecione um arquivo",
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontSize: 15,
                      ),
                    ),
                  )
                : GridView.builder(
                    itemCount: field.value!.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2),
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: Image.memory(
                            field.value![index].bytes!,
                            fit: BoxFit.cover,
                          ),
                        ),
                      );
                    },
                  ),
          ),
        );
      },
    );
  }

  Future<List<FileDataModel>> getPicker() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowMultiple: widget.allowMultiple,
      type: FileType.custom,
      allowedExtensions: widget.allowedExtensions ?? Utils.allowedExtensions(),
    );
    if (result != null) {
      List<FileDataModel> files = [];
      for (var element in result.files) {
        Uint8List bytes = await element.xFile.readAsBytes();
        files.add(
          FileDataModel(
            bytes: bytes,
            extension: element.extension,
            name: element.name,
            size: element.size,
          ),
        );
      }
      return files;
    } else {
      return [];
    }
  }
}
