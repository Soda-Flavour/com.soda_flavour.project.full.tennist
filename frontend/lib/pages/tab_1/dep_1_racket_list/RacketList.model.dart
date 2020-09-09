// To parse this JSON data, do
//
//     final racketListModel = racketListModelFromJson(jsonString);

import 'dart:convert';

RacketListModel racketListModelFromJson(String str) =>
    RacketListModel.fromJson(json.decode(str));

String racketListModelToJson(RacketListModel data) =>
    json.encode(data.toJson());

class RacketListModel {
  RacketListModel({
    this.result,
  });

  Result result;

  factory RacketListModel.fromJson(Map<String, dynamic> json) =>
      RacketListModel(
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
    this.userData,
    this.list,
  });

  UserData userData;
  List<ListElement> list;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        userData: UserData.fromJson(json["user_data"]),
        list: List<ListElement>.from(
            json["list"].map((x) => ListElement.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "user_data": userData.toJson(),
        "list": List<dynamic>.from(list.map((x) => x.toJson())),
      };
}

class ListElement {
  ListElement({
    this.userRacketId,
    this.racketVertion,
    this.racketModel,
    this.racketCompanyName,
  });

  int userRacketId;
  String racketVertion;
  String racketModel;
  String racketCompanyName;

  factory ListElement.fromJson(Map<String, dynamic> json) => ListElement(
        userRacketId: json["user_racket_id"],
        racketVertion: json["racket_vertion"],
        racketModel: json["racket_model"],
        racketCompanyName: json["racket_company_name"],
      );

  Map<String, dynamic> toJson() => {
        "user_racket_id": userRacketId,
        "racket_vertion": racketVertion,
        "racket_model": racketModel,
        "racket_company_name": racketCompanyName,
      };
}

class UserData {
  UserData({
    this.id,
    this.nick,
    this.ntrp,
    this.sex,
    this.age,
    this.weightKg,
    this.heightCm,
    this.handed,
    this.playStyle,
    this.forehandStyle,
    this.backhandStyle,
  });

  int id;
  String nick;
  double ntrp;
  String sex;
  int age;
  int weightKg;
  int heightCm;
  String handed;
  String playStyle;
  String forehandStyle;
  String backhandStyle;

  factory UserData.fromJson(Map<String, dynamic> json) => UserData(
        id: json["id"],
        nick: json["nick"],
        ntrp: json["ntrp"].toDouble(),
        sex: json["sex"],
        age: json["age"],
        weightKg: json["weight_kg"],
        heightCm: json["height_cm"],
        handed: json["handed"],
        playStyle: json["play_style"],
        forehandStyle: json["forehand_style"],
        backhandStyle: json["backhand_style"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "nick": nick,
        "ntrp": ntrp,
        "sex": sex,
        "age": age,
        "weight_kg": weightKg,
        "height_cm": heightCm,
        "handed": handed,
        "play_style": playStyle,
        "forehand_style": forehandStyle,
        "backhand_style": backhandStyle,
      };
}
