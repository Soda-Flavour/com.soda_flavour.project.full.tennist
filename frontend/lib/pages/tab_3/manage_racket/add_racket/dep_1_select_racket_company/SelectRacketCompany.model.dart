// To parse this JSON data, do
//
//     final selectRacketCompanyModel = selectRacketCompanyModelFromJson(jsonString);

import 'dart:convert';

SelectRacketCompanyModel selectRacketCompanyModelFromJson(String str) =>
    SelectRacketCompanyModel.fromJson(json.decode(str));

String selectRacketCompanyModelToJson(SelectRacketCompanyModel data) =>
    json.encode(data.toJson());

class SelectRacketCompanyModel {
  SelectRacketCompanyModel({
    this.result,
  });

  Result result;

  factory SelectRacketCompanyModel.fromJson(Map<String, dynamic> json) =>
      SelectRacketCompanyModel(
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
    this.id,
    this.name,
    this.nameKor,
  });

  int id;
  String name;
  String nameKor;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"] == null ? null : json["id"],
        name: json["name"] == null ? null : json["name"],
        nameKor: json["name_kor"] == null ? null : json["name_kor"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "name": name == null ? null : name,
        "name_kor": nameKor == null ? null : nameKor,
      };
}
