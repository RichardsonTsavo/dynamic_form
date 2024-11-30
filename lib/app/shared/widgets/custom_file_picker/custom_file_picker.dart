import 'dart:typed_data';

import 'package:dynamic_form/app/shared/utils/index.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import '../../models/dynamic_form/index.dart';

class CustomFilePicker extends StatefulWidget {
  final String name;
  final List<String>? allowedExtensions;
  final bool allowMultiple;
  final String? Function(List<FileDataModel>?)? validator;
  final List<FileDataModel>? initialValue;
  final bool canRemoveImage;
  final bool readOnly;
  const CustomFilePicker({
    super.key,
    required this.name,
    this.canRemoveImage = false,
    this.allowMultiple = false,
    this.readOnly = false,
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
        return Column(
          children: [
            if (widget.readOnly == false) ...[
              ElevatedButton(
                onPressed: () async {
                  List<FileDataModel> files = await getPicker();
                  if (files.isNotEmpty) {
                    files.addAll(field.value ?? []);
                    field.didChange(files);
                  }
                },
                child: const Text("Adicionar imagem"),
              ),
              const SizedBox(
                height: 15,
              ),
            ],
            Container(
              width: MediaQuery.of(context).size.width,
              height: 250,
              decoration: BoxDecoration(
                border: Border.all(
                    color: field.errorText != null
                        ? Colors.red
                        : Theme.of(context).primaryColor,
                    width: 2),
              ),
              child: field.value == null || field.value!.isEmpty
                  ? Center(
                      child: Text(
                        "Selecione um arquivo '${widget.validator != null ? ' *' : ''}",
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
                          child: Stack(
                            children: [
                              GestureDetector(
                                onTap: widget.readOnly == true
                                    ? () {
                                        Utils.showPopupDialog(
                                          context: context,
                                          child: AlertDialog(
                                            scrollable: true,
                                            content: Image.memory(
                                              field.value![index].bytes!,
                                            ),
                                            actions: [
                                              ElevatedButton(
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                },
                                                child: const Text("Fechar"),
                                              )
                                            ],
                                          ),
                                        );
                                      }
                                    : null,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(15),
                                  child: Image.memory(
                                    field.value![index].bytes!,
                                    width: MediaQuery.of(context).size.width,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              if (widget.canRemoveImage)
                                Positioned(
                                  left: 5,
                                  top: 5,
                                  child: CircleAvatar(
                                    backgroundColor: Theme.of(context)
                                        .scaffoldBackgroundColor,
                                    child: IconButton(
                                      onPressed: () {
                                        List<FileDataModel> data = field.value!;
                                        data.removeAt(index);
                                        field.didChange(data);
                                      },
                                      icon: const Icon(
                                        Icons.delete,
                                        color: Colors.red,
                                      ),
                                    ),
                                  ),
                                )
                            ],
                          ),
                        );
                      },
                    ),
            ),
            if (field.errorText != null)
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.only(left: 15),
                  child: Text(
                    field.errorText!,
                    textAlign: TextAlign.start,
                    style: const TextStyle(
                      color: Colors.red,
                    ),
                  ),
                ),
              )
          ],
        );
      },
    );
  }

  Future<List<FileDataModel>> getPicker() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowMultiple: widget.allowMultiple,
      type: FileType.custom,
      allowedExtensions: widget.allowedExtensions!.isNotEmpty
          ? widget.allowedExtensions!
          : Utils.allowedExtensions(),
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
