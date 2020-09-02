// To parse this JSON data, do
//
//     final tennisInfoFormModel = tennisInfoFormModelFromJson(jsonString);

import 'dart:convert';

TennisInfoFormModel tennisInfoFormModelFromJson(String str) =>
    TennisInfoFormModel.fromJson(json.decode(str));

String tennisInfoFormModelToJson(TennisInfoFormModel data) =>
    json.encode(data.toJson());

class TennisInfoFormModel {
  TennisInfoFormModel({
    this.result,
  });

  Result result;

  factory TennisInfoFormModel.fromJson(Map<String, dynamic> json) =>
      TennisInfoFormModel(
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
    this.ntrp,
    this.playstyle,
    this.forehand,
    this.backhand,
  });

  double ntrp;
  int playstyle;
  int forehand;
  int backhand;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        ntrp: json["ntrp"] == null ? null : json["ntrp"].toDouble(),
        playstyle: json["playstyle"] == null ? null : json["playstyle"],
        forehand: json["forehand"] == null ? null : json["forehand"],
        backhand: json["backhand"] == null ? null : json["backhand"],
      );

  Map<String, dynamic> toJson() => {
        "ntrp": ntrp == null ? null : ntrp,
        "playstyle": playstyle == null ? null : playstyle,
        "forehand": forehand == null ? null : forehand,
        "backhand": backhand == null ? null : backhand,
      };
}
