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
  Result({this.status, this.message, this.data, this.errorCode, this.stack});

  int status;
  String message;
  List<Datum> data;
  String errorCode;
  String stack;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        status: json["status"] == null ? null : json["status"],
        message: json["message"] == null ? null : json["message"],
        data: json["data"] == null
            ? null
            : List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
        errorCode: json["errorCode"] == null ? null : json["errorCode"],
        stack: json["stack"] == null ? null : json["stack"],
      );

  Map<String, dynamic> toJson() => {
        "status": status == null ? null : status,
        "message": message == null ? null : message,
        "data": data == null
            ? null
            : List<dynamic>.from(data.map((x) => x.toJson())),
        "errorCode": errorCode == null ? null : errorCode,
        "stack": stack == null ? null : stack,
      };
}

class Datum {
  Datum({
    this.nick,
    this.weightKg,
    this.heightCm,
    this.handed,
    this.age,
    this.sex,
    this.playStyle,
    this.ntrp,
  });

  String nick;
  dynamic weightKg;
  dynamic heightCm;
  dynamic handed;
  dynamic age;
  dynamic sex;
  String playStyle;
  dynamic ntrp;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        nick: json["nick"] == null ? null : json["nick"],
        weightKg: json["weight_kg"],
        heightCm: json["height_cm"],
        handed: json["handed"],
        age: json["age"],
        sex: json["sex"],
        playStyle:
            json["play_style"] == null ? '프로필을 완성하세요' : json["play_style"],
        ntrp: json["ntrp"] == null ? '-' : json["play_style"],
      );

  Map<String, dynamic> toJson() => {
        "nick": nick == null ? null : nick,
        "weight_kg": weightKg,
        "height_cm": heightCm,
        "handed": handed,
        "age": age,
        "sex": sex,
        "play_style": playStyle == null ? null : playStyle,
        "ntrp": ntrp,
      };
}
