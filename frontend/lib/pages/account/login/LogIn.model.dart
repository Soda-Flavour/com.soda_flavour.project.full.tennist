// To parse this JSON data, do
//
//     final logInModel = logInModelFromJson(jsonString);

import 'dart:convert';

LogInModel logInModelFromJson(String str) =>
    LogInModel.fromJson(json.decode(str));

String logInModelToJson(LogInModel data) => json.encode(data.toJson());

class LogInModel {
  LogInModel({
    this.result,
  });

  Result result;

  factory LogInModel.fromJson(Map<String, dynamic> json) => LogInModel(
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
    this.user,
    this.accessT,
    this.refreshT,
  });

  User user;
  String accessT;
  String refreshT;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        user: json["user"] == null ? null : User.fromJson(json["user"]),
        accessT: json["access_t"] == null ? null : json["access_t"],
        refreshT: json["refresh_t"] == null ? null : json["refresh_t"],
      );

  Map<String, dynamic> toJson() => {
        "user": user == null ? null : user.toJson(),
        "access_t": accessT == null ? null : accessT,
        "refresh_t": refreshT == null ? null : refreshT,
      };
}

class User {
  User({
    this.id,
    this.nick,
    this.email,
  });

  int id;
  String nick;
  String email;

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"] == null ? null : json["id"],
        nick: json["nick"] == null ? null : json["nick"],
        email: json["email"] == null ? null : json["email"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "nick": nick == null ? null : nick,
        "email": email == null ? null : email,
      };
}
