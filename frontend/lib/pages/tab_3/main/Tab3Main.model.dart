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
    this.nick,
    this.ntrp,
    this.playStyle,
  });

  String nick;
  double ntrp;
  String playStyle;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        nick: json["nick"],
        ntrp: json["ntrp"].toDouble(),
        playStyle: json["play_style"],
      );

  Map<String, dynamic> toJson() => {
        "nick": nick,
        "ntrp": ntrp,
        "play_style": playStyle,
      };
}
