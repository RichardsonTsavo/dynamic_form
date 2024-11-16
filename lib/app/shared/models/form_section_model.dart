// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:dynamic_form/app/shared/models/index.dart';

class FormSectionModel {
  String? id;
  String? title;
  String? description;
  List<FormFieldModel>? fields;
  FormSectionModel({
    this.id,
    this.title,
    this.description,
    this.fields,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'description': description,
      'fields': fields?.map((x) => x.toMap()).toList(),
    };
  }

  factory FormSectionModel.fromMap(Map<String, dynamic> map) {
    return FormSectionModel(
      id: map['id'] != null ? map['id'] as String : null,
      title: map['title'] != null ? map['title'] as String : null,
      description:
          map['description'] != null ? map['description'] as String : null,
      fields: map['fields'] != null
          ? List<FormFieldModel>.from(
              (map['fields'] as List<int>).map<FormFieldModel?>(
                (x) => FormFieldModel.fromMap(x as Map<String, dynamic>),
              ),
            )
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory FormSectionModel.fromJson(String source) =>
      FormSectionModel.fromMap(json.decode(source) as Map<String, dynamic>);

  FormSectionModel copyWith({
    String? id,
    String? title,
    String? description,
    List<FormFieldModel>? fields,
  }) {
    return FormSectionModel(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      fields: fields ?? this.fields,
    );
  }
}
