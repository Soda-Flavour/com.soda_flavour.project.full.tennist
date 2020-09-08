// To parse this JSON data, do
//
//     final userRacketListModel = userRacketListModelFromJson(jsonString);

import 'dart:convert';

UserRacketListModel userRacketListModelFromJson(String str) =>
    UserRacketListModel.fromJson(json.decode(str));

String userRacketListModelToJson(UserRacketListModel data) =>
    json.encode(data.toJson());

class UserRacketListModel {
  UserRacketListModel({
    this.result,
  });

  Result result;

  factory UserRacketListModel.fromJson(Map<String, dynamic> json) =>
      UserRacketListModel(
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
    this.racketNickname,
    this.seq,
    this.model,
    this.nameKor,
  });

  int id;
  String racketNickname;
  int seq;
  String model;
  String nameKor;

  factory ListElement.fromJson(Map<String, dynamic> json) => ListElement(
        id: json["id"] == null ? null : json["id"],
        racketNickname:
            json["racket_nickname"] == null ? null : json["racket_nickname"],
        seq: json["seq"] == null ? null : json["seq"],
        model: json["model"] == null ? null : json["model"],
        nameKor: json["name_kor"] == null ? null : json["name_kor"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "racket_nickname": racketNickname == null ? null : racketNickname,
        "seq": seq == null ? null : seq,
        "model": model == null ? null : model,
        "name_kor": nameKor == null ? null : nameKor,
      };
}
