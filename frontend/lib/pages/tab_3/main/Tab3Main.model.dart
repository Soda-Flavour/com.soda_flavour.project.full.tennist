// To parse this JSON data, do
//
//     final tab3MainModel = tab3MainModelFromJson(jsonString);

import 'dart:convert';

Tab3MainModel tab3MainModelFromJson(String str) =>
    Tab3MainModel.fromJson(json.decode(str));

String tab3MainModelToJson(Tab3MainModel data) => json.encode(data.toJson());

class Tab3MainModel {
  Tab3MainModel({
    this.result,
  });

  Result result;

  factory Tab3MainModel.fromJson(Map<String, dynamic> json) => Tab3MainModel(
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
    this.nick,
    this.ntrp,
    this.playStyle,
  });

  String nick;
  double ntrp;
  String playStyle;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        nick: json["nick"] == null ? null : json["nick"],
        ntrp: json["ntrp"] == null ? null : json["ntrp"].toDouble(),
        playStyle: json["play_style"] == null ? null : json["play_style"],
      );

  Map<String, dynamic> toJson() => {
        "nick": nick == null ? null : nick,
        "ntrp": ntrp == null ? null : ntrp,
        "play_style": playStyle == null ? null : playStyle,
      };
}
