import 'dart:convert';

import 'package:dynamic_form/app/shared/models/user/index.dart';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class FormResponseModel {
  String? id;
  UserModel? user;
  String? formID;
  Map<String, dynamic>? response;
  FormResponseModel({
    this.id,
    this.user,
    this.formID,
    this.response,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'user': user?.toMap(),
      'formID': formID,
      'response': response,
    };
  }

  factory FormResponseModel.fromMap(Map<String, dynamic> map) {
    return FormResponseModel(
      id: map['id'] != null ? map['id'] as String : null,
      user: map['user'] != null
          ? UserModel.fromMap(map['user'] as Map<String, dynamic>)
          : null,
      formID: map['formID'] != null ? map['formID'] as String : null,
      response: map['response'] != null
          ? Map<String, dynamic>.from((map['response'] as Map<String, dynamic>))
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory FormResponseModel.fromJson(String source) =>
      FormResponseModel.fromMap(json.decode(source) as Map<String, dynamic>);

  FormResponseModel copyWith({
    String? id,
    UserModel? user,
    String? formID,
    Map<String, dynamic>? response,
  }) {
    return FormResponseModel(
      id: id ?? this.id,
      user: user ?? this.user,
      formID: formID ?? this.formID,
      response: response ?? this.response,
    );
  }
}
