// To parse this JSON data, do
//
//     final errorModel = errorModelFromJson(jsonString);

import 'dart:convert';

ErrorModel errorModelFromJson(String str) =>
    ErrorModel.fromJson(json.decode(str));

String errorModelToJson(ErrorModel data) => json.encode(data.toJson());

class ErrorModel {
  ErrorModel({
    this.result,
  });

  Result result;

  factory ErrorModel.fromJson(Map<String, dynamic> json) => ErrorModel(
        result: json["result"] == null ? null : Result.fromJson(json["result"]),
      );

  Map<String, dynamic> toJson() => {
        "result": result == null ? null : result.toJson(),
      };
}

class Result {
  Result({
    this.status,
    this.errorCode,
    this.message,
    this.stack,
  });

  int status;
  String errorCode;
  String message;
  String stack;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        status: json["status"] == null ? null : json["status"],
        errorCode: json["errorCode"] == null ? null : json["errorCode"],
        message: json["message"] == null ? null : json["message"],
        stack: json["stack"] == null ? null : json["stack"],
      );

  Map<String, dynamic> toJson() => {
        "status": status == null ? null : status,
        "errorCode": errorCode == null ? null : errorCode,
        "message": message == null ? null : message,
        "stack": stack == null ? null : stack,
      };
}
