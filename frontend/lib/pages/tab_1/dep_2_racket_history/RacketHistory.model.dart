// To parse this JSON data, do
//
//     final RacketHistoryModel = racketHistoryModelFromJson(jsonString);

import 'dart:convert';

RacketHistoryModel racketHistoryModelFromJson(String str) =>
    RacketHistoryModel.fromJson(json.decode(str));

String racketHistoryModelToJson(RacketHistoryModel data) =>
    json.encode(data.toJson());

class RacketHistoryModel {
  RacketHistoryModel({
    this.result,
  });

  Result result;

  factory RacketHistoryModel.fromJson(Map<String, dynamic> json) =>
      RacketHistoryModel(
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
    this.list,
    this.racketInfo,
  });

  List<ListElement> list;
  RacketInfo racketInfo;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        list: json["list"] == null
            ? null
            : List<ListElement>.from(
                json["list"].map((x) => ListElement.fromJson(x))),
        racketInfo: json["racket_info"] == null
            ? null
            : RacketInfo.fromJson(json["racket_info"]),
      );

  Map<String, dynamic> toJson() => {
        "list": list == null
            ? null
            : List<dynamic>.from(list.map((x) => x.toJson())),
        "racket_info": racketInfo == null ? null : racketInfo.toJson(),
      };
}

class ListElement {
  ListElement({
    this.id,
    this.tRacketId,
    this.weightTune,
    this.replacementGripType,
    this.overgripNum,
    this.racketBalanceType,
    this.racketBalanceVal,
    this.mainGutLbTension,
    this.crossGutLbTension,
    this.gutCompanyName,
    this.gutName,
    this.updatedDate,
  });

  int id;
  int tRacketId;
  int weightTune;
  String replacementGripType;
  int overgripNum;
  String racketBalanceType;
  int racketBalanceVal;
  double mainGutLbTension;
  double crossGutLbTension;
  String gutCompanyName;
  String gutName;
  DateTime updatedDate;

  factory ListElement.fromJson(Map<String, dynamic> json) => ListElement(
        id: json["id"] == null ? null : json["id"],
        tRacketId: json["t__racket_id"] == null ? null : json["t__racket_id"],
        weightTune: json["weight_tune"] == null ? null : json["weight_tune"],
        replacementGripType: json["replacement_grip_type"] == null
            ? null
            : json["replacement_grip_type"],
        overgripNum: json["overgrip_num"] == null ? null : json["overgrip_num"],
        racketBalanceType: json["racket_balance_type"] == null
            ? null
            : json["racket_balance_type"],
        racketBalanceVal: json["racket_balance_val"] == null
            ? null
            : json["racket_balance_val"],
        mainGutLbTension: json["main_gut_lb_tension"] == null
            ? null
            : json["main_gut_lb_tension"].toDouble(),
        crossGutLbTension: json["cross_gut_lb_tension"] == null
            ? null
            : json["cross_gut_lb_tension"].toDouble(),
        gutCompanyName:
            json["gut_company_name"] == null ? null : json["gut_company_name"],
        gutName: json["gut_name"] == null ? null : json["gut_name"],
        updatedDate: json["updated_date"] == null
            ? null
            : DateTime.parse(json["updated_date"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "t__racket_id": tRacketId == null ? null : tRacketId,
        "weight_tune": weightTune == null ? null : weightTune,
        "replacement_grip_type":
            replacementGripType == null ? null : replacementGripType,
        "overgrip_num": overgripNum == null ? null : overgripNum,
        "racket_balance_type":
            racketBalanceType == null ? null : racketBalanceType,
        "racket_balance_val":
            racketBalanceVal == null ? null : racketBalanceVal,
        "main_gut_lb_tension":
            mainGutLbTension == null ? null : mainGutLbTension,
        "cross_gut_lb_tension":
            crossGutLbTension == null ? null : crossGutLbTension,
        "gut_company_name": gutCompanyName == null ? null : gutCompanyName,
        "gut_name": gutName == null ? null : gutName,
        "updated_date":
            updatedDate == null ? null : updatedDate.toIso8601String(),
      };
}

class RacketInfo {
  RacketInfo({
    this.racketNickname,
    this.companyName,
    this.racketVersionName,
    this.model,
    this.weightUngut,
    this.racketBalanceLbVal,
    this.racketBalanceLbType,
    this.mainPattern,
    this.crossPattern,
  });

  String racketNickname;
  String companyName;
  String racketVersionName;
  String model;
  int weightUngut;
  int racketBalanceLbVal;
  String racketBalanceLbType;
  int mainPattern;
  int crossPattern;

  factory RacketInfo.fromJson(Map<String, dynamic> json) => RacketInfo(
        racketNickname:
            json["racket_nickname"] == null ? null : json["racket_nickname"],
        companyName: json["company_name"] == null ? null : json["company_name"],
        racketVersionName: json["racket_version_name"] == null
            ? null
            : json["racket_version_name"],
        model: json["model"] == null ? null : json["model"],
        weightUngut: json["weight_ungut"] == null ? null : json["weight_ungut"],
        racketBalanceLbVal: json["racket_balance_lb_val"] == null
            ? null
            : json["racket_balance_lb_val"],
        racketBalanceLbType: json["racket_balance_lb_type"] == null
            ? null
            : json["racket_balance_lb_type"],
        mainPattern: json["main_pattern"] == null ? null : json["main_pattern"],
        crossPattern:
            json["cross_pattern"] == null ? null : json["cross_pattern"],
      );

  Map<String, dynamic> toJson() => {
        "racket_nickname": racketNickname == null ? null : racketNickname,
        "company_name": companyName == null ? null : companyName,
        "racket_version_name":
            racketVersionName == null ? null : racketVersionName,
        "model": model == null ? null : model,
        "weight_ungut": weightUngut == null ? null : weightUngut,
        "racket_balance_lb_val":
            racketBalanceLbVal == null ? null : racketBalanceLbVal,
        "racket_balance_lb_type":
            racketBalanceLbType == null ? null : racketBalanceLbType,
        "main_pattern": mainPattern == null ? null : mainPattern,
        "cross_pattern": crossPattern == null ? null : crossPattern,
      };
}