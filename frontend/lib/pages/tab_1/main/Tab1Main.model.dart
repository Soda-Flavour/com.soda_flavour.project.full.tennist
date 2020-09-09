// To parse this JSON data, do
//
//     final tab1MainModel = tab1MainModelFromJson(jsonString);

import 'dart:convert';

Tab1MainModel tab1MainModelFromJson(String str) =>
    Tab1MainModel.fromJson(json.decode(str));

String tab1MainModelToJson(Tab1MainModel data) => json.encode(data.toJson());

class Tab1MainModel {
  Tab1MainModel({
    this.result,
  });

  Result result;

  factory Tab1MainModel.fromJson(Map<String, dynamic> json) => Tab1MainModel(
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
    this.list,
  });

  List<ListElement> list;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        list: List<ListElement>.from(
            json["list"].map((x) => ListElement.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "list": List<dynamic>.from(list.map((x) => x.toJson())),
      };
}

class ListElement {
  ListElement({
    this.userId,
    this.userNick,
    this.userThumb,
    this.racketModel,
    this.racketVersion,
    this.racketCnt,
  });

  int userId;
  String userNick;
  String userThumb;
  String racketModel;
  String racketVersion;
  int racketCnt;

  factory ListElement.fromJson(Map<String, dynamic> json) => ListElement(
        userId: json["user_id"],
        userNick: json["user_nick"],
        userThumb: json["user_thumb"] == null ? null : json["user_thumb"],
        racketModel: json["racket_model"],
        racketVersion: json["racket_version"],
        racketCnt: json["racket_cnt"],
      );

  Map<String, dynamic> toJson() => {
        "user_id": userId,
        "user_nick": userNick,
        "user_thumb": userThumb == null ? null : userThumb,
        "racket_model": racketModel,
        "racket_version": racketVersion,
        "racket_cnt": racketCnt,
      };
}
