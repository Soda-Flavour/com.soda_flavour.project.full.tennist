// To parse this JSON data, do
//
//     final userBasicInfoFormModel = userBasicInfoFormModelFromJson(jsonString);

import 'dart:convert';

UserBasicInfoFormModel userBasicInfoFormModelFromJson(String str) =>
    UserBasicInfoFormModel.fromJson(json.decode(str));

String userBasicInfoFormModelToJson(UserBasicInfoFormModel data) =>
    json.encode(data.toJson());

class UserBasicInfoFormModel {
  UserBasicInfoFormModel({
    this.result,
  });

  Result result;

  factory UserBasicInfoFormModel.fromJson(Map<String, dynamic> json) =>
      UserBasicInfoFormModel(
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
  List<Datum> data;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        status: json["status"] == null ? null : json["status"],
        message: json["message"] == null ? null : json["message"],
        data: json["data"] == null
            ? null
            : List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status == null ? null : status,
        "message": message == null ? null : message,
        "data": data == null
            ? null
            : List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Datum {
  Datum({
    this.nick,
    this.age,
    this.sex,
  });

  String nick;
  int age;
  String sex;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        nick: json["nick"] == null ? null : json["nick"],
        age: json["age"] == null ? null : json["age"],
        sex: json["sex"] == null ? null : json["sex"],
      );

  Map<String, dynamic> toJson() => {
        "nick": nick == null ? null : nick,
        "age": age == null ? null : age,
        "sex": sex == null ? null : sex,
      };
}
