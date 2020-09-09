// To parse this JSON data, do
//
//     final userRacketHistoryDetailCommentModel = userRacketHistoryDetailCommentModelFromJson(jsonString);

import 'dart:convert';

UserRacketHistoryDetailCommentModel userRacketHistoryDetailCommentModelFromJson(
        String str) =>
    UserRacketHistoryDetailCommentModel.fromJson(json.decode(str));

String userRacketHistoryDetailCommentModelToJson(
        UserRacketHistoryDetailCommentModel data) =>
    json.encode(data.toJson());

class UserRacketHistoryDetailCommentModel {
  UserRacketHistoryDetailCommentModel({
    this.result,
  });

  Result result;

  factory UserRacketHistoryDetailCommentModel.fromJson(
          Map<String, dynamic> json) =>
      UserRacketHistoryDetailCommentModel(
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
    this.comment,
    this.updatedAt,
    this.nick,
  });

  String comment;
  DateTime updatedAt;
  String nick;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        comment: json["comment"] == null ? null : json["comment"],
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        nick: json["nick"] == null ? null : json["nick"],
      );

  Map<String, dynamic> toJson() => {
        "comment": comment == null ? null : comment,
        "updated_at": updatedAt == null ? null : updatedAt.toIso8601String(),
        "nick": nick == null ? null : nick,
      };
}
