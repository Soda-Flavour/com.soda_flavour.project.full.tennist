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
    this.user_image,
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
  String user_image;
  int age;
  int weightKg;
  int heightCm;
  String handed;
  String playStyle;
  String forehandStyle;
  String backhandStyle;

  factory UserData.fromJson(Map<String, dynamic> json) => UserData(
        id: json["id"] == null ? null : json["id"],
        nick: json["nick"] == null ? null : json["nick"],
        ntrp: json["ntrp"] == null ? null : json["ntrp"].toDouble(),
        sex: json["sex"] == null ? null : json["sex"],
        age: json["age"] == null ? null : json["age"],
        weightKg: json["weight_kg"] == null ? null : json["weight_kg"],
        heightCm: json["height_cm"] == null ? null : json["height_cm"],
        handed: json["handed"] == null ? null : json["handed"],
        user_image: json["user_image"] == null ? null : json["user_image"],
        playStyle: json["play_style"] == null ? null : json["play_style"],
        forehandStyle:
            json["forehand_style"] == null ? null : json["forehand_style"],
        backhandStyle:
            json["backhand_style"] == null ? null : json["backhand_style"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "nick": nick == null ? null : nick,
        "ntrp": ntrp == null ? null : ntrp,
        "sex": sex == null ? null : sex,
        "age": age == null ? null : age,
        "weight_kg": weightKg == null ? null : weightKg,
        "height_cm": heightCm == null ? null : heightCm,
        "handed": handed == null ? null : handed,
        "user_image": user_image == null ? null : user_image,
        "play_style": playStyle == null ? null : playStyle,
        "forehand_style": forehandStyle == null ? null : forehandStyle,
        "backhand_style": backhandStyle == null ? null : backhandStyle,
      };
}
