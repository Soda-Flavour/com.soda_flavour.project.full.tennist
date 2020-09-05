// To parse this JSON data, do
//
//     final gutListModel = gutListModelFromJson(jsonString);

import 'dart:convert';

GutListModel gutListModelFromJson(String str) =>
    GutListModel.fromJson(json.decode(str));

String gutListModelToJson(GutListModel data) => json.encode(data.toJson());

class GutListModel {
  GutListModel({
    this.result,
  });

  Result result;

  factory GutListModel.fromJson(Map<String, dynamic> json) => GutListModel(
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
    this.name,
    this.nameKor,
  });

  int id;
  String name;
  String nameKor;

  factory ListElement.fromJson(Map<String, dynamic> json) => ListElement(
        id: json["id"] == null ? null : json["id"],
        name: json["name"] == null ? null : json["name"],
        nameKor: json["name_kor"] == null ? null : json["name_kor"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "name": name == null ? null : name,
        "name_kor": nameKor == null ? null : nameKor,
      };
}
