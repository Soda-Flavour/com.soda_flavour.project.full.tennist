// To parse this JSON data, do
//
//     final RacketHistoryDetailCommentModel = racketHistoryDetailCommentModelFromJson(jsonString);

import 'dart:convert';

RacketHistoryDetailCommentModel racketHistoryDetailCommentModelFromJson(
        String str) =>
    RacketHistoryDetailCommentModel.fromJson(json.decode(str));

String racketHistoryDetailCommentModelToJson(
        RacketHistoryDetailCommentModel data) =>
    json.encode(data.toJson());

class RacketHistoryDetailCommentModel {
  RacketHistoryDetailCommentModel({
    this.result,
  });

  Result result;

  factory RacketHistoryDetailCommentModel.fromJson(Map<String, dynamic> json) =>
      RacketHistoryDetailCommentModel(
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
