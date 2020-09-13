// To parse this JSON data, do
//
//     final uploadThumbModel = uploadThumbModelFromJson(jsonString);

import 'dart:convert';

UploadThumbModel uploadThumbModelFromJson(String str) =>
    UploadThumbModel.fromJson(json.decode(str));

String uploadThumbModelToJson(UploadThumbModel data) =>
    json.encode(data.toJson());

class UploadThumbModel {
  UploadThumbModel({
    this.result,
  });

  Result result;

  factory UploadThumbModel.fromJson(Map<String, dynamic> json) =>
      UploadThumbModel(
        result: Result.fromJson(json["result"]),
      );

  Map<String, dynamic> toJson() => {
        "result": result.toJson(),
      };
}

class Result {
  Result({
    this.status,
    this.message,
    this.data,
  });

  int status;
  String message;
  Data data;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        status: json["status"],
        message: json["message"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data.toJson(),
      };
}

class Data {
  Data({
    this.thumb,
  });

  String thumb;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        thumb: json["thumb"],
      );

  Map<String, dynamic> toJson() => {
        "thumb": thumb,
      };
}
