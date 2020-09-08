// To parse this JSON data, do
//
//     final addUserRacketHistoryModel = addUserRacketHistoryModelFromJson(jsonString);

import 'dart:convert';

AddUserRacketHistoryModel addUserRacketHistoryModelFromJson(String str) =>
    AddUserRacketHistoryModel.fromJson(json.decode(str));

String addUserRacketHistoryModelToJson(AddUserRacketHistoryModel data) =>
    json.encode(data.toJson());

class AddUserRacketHistoryModel {
  AddUserRacketHistoryModel({
    this.result,
  });

  Result result;

  factory AddUserRacketHistoryModel.fromJson(Map<String, dynamic> json) =>
      AddUserRacketHistoryModel(
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
    this.gutName,
    this.comapanyName,
  });

  int id;
  String gutName;
  String comapanyName;

  factory ListElement.fromJson(Map<String, dynamic> json) => ListElement(
        id: json["id"] == null ? null : json["id"],
        gutName: json["gut_name"] == null ? null : json["gut_name"],
        comapanyName:
            json["comapany_name"] == null ? null : json["comapany_name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "gut_name": gutName == null ? null : gutName,
        "comapany_name": comapanyName == null ? null : comapanyName,
      };
}
