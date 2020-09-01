// To parse this JSON data, do
//
//     final physicalInfoFormModel = physicalInfoFormModelFromJson(jsonString);

import 'dart:convert';

PhysicalInfoFormModel physicalInfoFormModelFromJson(String str) =>
    PhysicalInfoFormModel.fromJson(json.decode(str));

String physicalInfoFormModelToJson(PhysicalInfoFormModel data) =>
    json.encode(data.toJson());

class PhysicalInfoFormModel {
  PhysicalInfoFormModel({
    this.result,
  });

  Result result;

  factory PhysicalInfoFormModel.fromJson(Map<String, dynamic> json) =>
      PhysicalInfoFormModel(
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
    this.weightKg,
    this.heightCm,
    this.handed,
  });

  int weightKg;
  int heightCm;
  String handed;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        weightKg: json["weight_kg"] == null ? null : json["weight_kg"],
        heightCm: json["height_cm"] == null ? null : json["height_cm"],
        handed: json["handed"] == null ? null : json["handed"],
      );

  Map<String, dynamic> toJson() => {
        "weight_kg": weightKg == null ? null : weightKg,
        "height_cm": heightCm == null ? null : heightCm,
        "handed": handed == null ? null : handed,
      };
}
