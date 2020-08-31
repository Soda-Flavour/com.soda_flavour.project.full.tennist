// To parse this JSON data, do
//
//     final appErrorModel = appErrorModelFromJson(jsonString);

import 'dart:convert';

AppErrorModel appErrorModelFromJson(String str) =>
    AppErrorModel.fromJson(json.decode(str));

String appErrorModelToJson(AppErrorModel data) => json.encode(data.toJson());

class AppErrorModel {
  AppErrorModel({
    this.status,
    this.errorCode,
    this.message,
    this.stack,
  });

  int status;
  String errorCode;
  String message;
  String stack;

  factory AppErrorModel.fromJson(Map<String, dynamic> json) => AppErrorModel(
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
