// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:dynamic_form/app/shared/models/index.dart';

class FormModel {
  String? id;
  String? formName;
  List<FormSectionModel>? sections;
  bool? isEditable;
  int? maxResponseCount;
  FormModel({
    this.id,
    this.formName,
    this.sections,
    this.isEditable,
    this.maxResponseCount,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'formName': formName,
      'sections': sections?.map((x) => x.toMap()).toList(),
      'isEditable': isEditable,
      'maxResponseCount': maxResponseCount,
    };
  }

  factory FormModel.fromMap(Map<String, dynamic> map) {
    return FormModel(
      id: map['id'] != null ? map['id'] as String : null,
      formName: map['formName'] != null ? map['formName'] as String : null,
      sections: map['sections'] != null
          ? List<FormSectionModel>.from(
              (map['sections'] as List<dynamic>).map<FormSectionModel?>(
                (x) => FormSectionModel.fromMap(x as Map<String, dynamic>),
              ),
            )
          : null,
      isEditable: map['isEditable'] != null ? map['isEditable'] as bool : null,
      maxResponseCount: map['maxResponseCount'] != null
          ? map['maxResponseCount'] as int
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory FormModel.fromJson(String source) =>
      FormModel.fromMap(json.decode(source) as Map<String, dynamic>);

  FormModel copyWith({
    String? id,
    String? formName,
    List<FormSectionModel>? sections,
    bool? isEditable,
    int? maxResponseCount,
  }) {
    return FormModel(
      id: id ?? this.id,
      formName: formName ?? this.formName,
      sections: sections ?? this.sections,
      isEditable: isEditable ?? this.isEditable,
      maxResponseCount: maxResponseCount ?? this.maxResponseCount,
    );
  }
}
