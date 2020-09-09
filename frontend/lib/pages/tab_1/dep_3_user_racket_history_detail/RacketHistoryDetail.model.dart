// To parse this JSON data, do
//
//     final RacketHistoryDetailModel = racketHistoryDetailModelFromJson(jsonString);

import 'dart:convert';

RacketHistoryDetailModel racketHistoryDetailModelFromJson(String str) =>
    RacketHistoryDetailModel.fromJson(json.decode(str));

String racketHistoryDetailModelToJson(RacketHistoryDetailModel data) =>
    json.encode(data.toJson());

class RacketHistoryDetailModel {
  RacketHistoryDetailModel({
    this.result,
  });

  Result result;

  factory RacketHistoryDetailModel.fromJson(Map<String, dynamic> json) =>
      RacketHistoryDetailModel(
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
    this.racketData,
    this.list,
  });

  RacketData racketData;
  List<ListElement> list;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        racketData: json["racket_data"] == null
            ? null
            : RacketData.fromJson(json["racket_data"]),
        list: json["list"] == null
            ? null
            : List<ListElement>.from(
                json["list"].map((x) => ListElement.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "racket_data": racketData == null ? null : racketData.toJson(),
        "list": list == null
            ? null
            : List<dynamic>.from(list.map((x) => x.toJson())),
      };
}

class ListElement {
  ListElement({
    this.nick,
    this.comment,
    this.updatedDate,
  });

  String nick;
  String comment;
  DateTime updatedDate;

  factory ListElement.fromJson(Map<String, dynamic> json) => ListElement(
        nick: json["nick"] == null ? null : json["nick"],
        comment: json["comment"] == null ? null : json["comment"],
        updatedDate: json["updated_date"] == null
            ? null
            : DateTime.parse(json["updated_date"]),
      );

  Map<String, dynamic> toJson() => {
        "nick": nick == null ? null : nick,
        "comment": comment == null ? null : comment,
        "updated_date":
            updatedDate == null ? null : updatedDate.toIso8601String(),
      };
}

class RacketData {
  RacketData({
    this.weightTune,
    this.replacementGripType,
    this.overgripNum,
    this.racketBalanceType,
    this.racketBalanceVal,
    this.mainGutLbTension,
    this.crossGutLbTension,
    this.racketVertion,
    this.racketModel,
    this.gutCompanyName,
    this.gutName,
  });

  int weightTune;
  String replacementGripType;
  int overgripNum;
  String racketBalanceType;
  int racketBalanceVal;
  double mainGutLbTension;
  double crossGutLbTension;
  String racketVertion;
  String racketModel;
  String gutCompanyName;
  String gutName;

  factory RacketData.fromJson(Map<String, dynamic> json) => RacketData(
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
        racketVertion:
            json["racket_vertion"] == null ? null : json["racket_vertion"],
        racketModel: json["racket_model"] == null ? null : json["racket_model"],
        gutCompanyName:
            json["gut_company_name"] == null ? null : json["gut_company_name"],
        gutName: json["gut_name"] == null ? null : json["gut_name"],
      );

  Map<String, dynamic> toJson() => {
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
        "racket_vertion": racketVertion == null ? null : racketVertion,
        "racket_model": racketModel == null ? null : racketModel,
        "gut_company_name": gutCompanyName == null ? null : gutCompanyName,
        "gut_name": gutName == null ? null : gutName,
      };
}
