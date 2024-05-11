import 'dart:convert';

class MetaModel {
  final String message;
  final String code;
  final dynamic data;

  MetaModel({required this.message, required this.data, required this.code});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      "message": message,
      "data": data,
    };
  }

  factory MetaModel.fromMap(Map<String, dynamic> map) {
    return MetaModel(
        message: map["message"], data: map["data"], code: map["code"]);
  }
  factory MetaModel.fromJson(Map<String, dynamic> json) {
    return MetaModel(
        message: json['responseMessage'],
        code: json['responseCode'],
        data: json['data']);
  }
  // String toJson() => json.encode(toMap());

  // factory MetaModel.fromJson(String source)=>MetaModel.fromMap(json.decode(source) as Map<String,dynamic>)
}
