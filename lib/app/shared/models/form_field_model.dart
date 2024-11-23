import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class FormFieldModel {
  String? id;
  String? title;
  String? description;
  String? label;
  String? fieldType;
  bool? isRequired;
  List<String>? fileTypes;
  List<String>? fieldOptions;
  double? min;
  double? max;
  dynamic value;
  FormFieldModel({
    this.id,
    this.title,
    this.description,
    this.label,
    this.fieldType,
    this.isRequired,
    this.fileTypes,
    this.fieldOptions,
    this.min,
    this.max,
    this.value,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'description': description,
      'label': label,
      'fieldType': fieldType,
      'isRequired': isRequired,
      'fileTypes': fileTypes,
      'fieldOptions': fieldOptions,
      'min': min,
      'max': max,
      'value': value,
    };
  }

  factory FormFieldModel.fromMap(Map<String, dynamic> map) {
    return FormFieldModel(
      id: map['id'] != null ? map['id'] as String : null,
      title: map['title'] != null ? map['title'] as String : null,
      description:
          map['description'] != null ? map['description'] as String : null,
      label: map['label'] != null ? map['label'] as String : null,
      fieldType: map['fieldType'] != null ? map['fieldType'] as String : null,
      isRequired: map['isRequired'] != null ? map['isRequired'] as bool : null,
      fileTypes: map['fileTypes'] != null
          ? List<String>.from((map['fileTypes'] as List<dynamic>))
          : null,
      fieldOptions: map['fieldOptions'] != null
          ? List<String>.from((map['fieldOptions'] as List<dynamic>))
          : null,
      min: map['min'] != null ? map['min'] as double : null,
      max: map['max'] != null ? map['max'] as double : null,
      value: map['value'] as dynamic,
    );
  }

  String toJson() => json.encode(toMap());

  factory FormFieldModel.fromJson(String source) =>
      FormFieldModel.fromMap(json.decode(source) as Map<String, dynamic>);

  FormFieldModel copyWith({
    String? id,
    String? title,
    String? description,
    String? label,
    String? fieldType,
    bool? isRequired,
    List<String>? fileTypes,
    List<String>? fieldOptions,
    double? min,
    double? max,
    dynamic value,
  }) {
    return FormFieldModel(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      label: label ?? this.label,
      fieldType: fieldType ?? this.fieldType,
      isRequired: isRequired ?? this.isRequired,
      fileTypes: fileTypes ?? this.fileTypes,
      fieldOptions: fieldOptions ?? this.fieldOptions,
      min: min ?? this.min,
      max: max ?? this.max,
      value: value ?? this.value,
    );
  }
}
