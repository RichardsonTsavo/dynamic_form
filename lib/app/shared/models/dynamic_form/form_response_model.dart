import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class FormResponseModel {
  String? userID;
  String? formID;
  Map<String, dynamic>? response;
  FormResponseModel({
    this.userID,
    this.formID,
    this.response,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'userID': userID,
      'formID': formID,
      'response': response,
    };
  }

  factory FormResponseModel.fromMap(Map<String, dynamic> map) {
    return FormResponseModel(
      userID: map['userID'] != null ? map['userID'] as String : null,
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
    String? userID,
    String? formID,
    Map<String, dynamic>? response,
  }) {
    return FormResponseModel(
      userID: userID ?? this.userID,
      formID: formID ?? this.formID,
      response: response ?? this.response,
    );
  }
}
