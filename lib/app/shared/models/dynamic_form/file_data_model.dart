// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'dart:typed_data';

class FileDataModel {
  Uint8List? bytes;
  String? name;
  int? size;
  String? extension;
  FileDataModel({
    this.bytes,
    this.name,
    this.size,
    this.extension,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'bytes': bytes,
      'name': name,
      'size': size,
      'extension': extension,
    };
  }

  factory FileDataModel.fromMap(Map<String, dynamic> map) {
    return FileDataModel(
      bytes: map['bytes'],
      name: map['name'] != null ? map['name'] as String : null,
      size: map['size'] != null ? map['size'] as int : null,
      extension: map['extension'] != null ? map['extension'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory FileDataModel.fromJson(String source) =>
      FileDataModel.fromMap(json.decode(source) as Map<String, dynamic>);

  FileDataModel copyWith({
    Uint8List? bytes,
    String? name,
    int? size,
    String? extension,
  }) {
    return FileDataModel(
      bytes: bytes ?? this.bytes,
      name: name ?? this.name,
      size: size ?? this.size,
      extension: extension ?? this.extension,
    );
  }
}
