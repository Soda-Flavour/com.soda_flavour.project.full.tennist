// To parse this JSON data, do
//
//     final selectRacketModelModel = selectRacketModelModelFromJson(jsonString);

import 'dart:convert';

SelectRacketModelModel selectRacketModelModelFromJson(String str) =>
    SelectRacketModelModel.fromJson(json.decode(str));

String selectRacketModelModelToJson(SelectRacketModelModel data) =>
    json.encode(data.toJson());

class SelectRacketModelModel {
  SelectRacketModelModel({
    this.result,
  });

  Result result;

  factory SelectRacketModelModel.fromJson(Map<String, dynamic> json) =>
      SelectRacketModelModel(
        result: json["result"] == null ? null : Result.fromJson(json["result"]),
      );

  Map<String, dynamic> toJson() => {
        "result": result == null ? null : result.toJson(),
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
        status: json["status"] == null ? null : json["status"],
        message: json["message"] == null ? null : json["message"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status == null ? null : status,
        "message": message == null ? null : message,
        "data": data == null ? null : data.toJson(),
      };
}

class Data {
  Data({
    this.list,
  });

  List<ListElement> list;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        list: json["list"] == null
            ? null
            : List<ListElement>.from(
                json["list"].map((x) => ListElement.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "list": list == null
            ? null
            : List<dynamic>.from(list.map((x) => x.toJson())),
      };
}

class ListElement {
  ListElement({
    this.id,
    this.model,
  });

  int id;
  String model;

  factory ListElement.fromJson(Map<String, dynamic> json) => ListElement(
        id: json["id"] == null ? null : json["id"],
        model: json["model"] == null ? null : json["model"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "model": model == null ? null : model,
      };
}
