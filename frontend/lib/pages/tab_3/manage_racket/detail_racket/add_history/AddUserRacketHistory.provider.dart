import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:async/async.dart';
import 'package:tennist_flutter/pages/tab_3/manage_racket/detail_racket/add_history/AddUserRacketHistory.model.dart';

import 'package:tennist_flutter/pages/tab_3/profile/physical_info/PhysicalInfoForm.model.dart';
import 'package:tennist_flutter/src/helper/AppConfig.dart';
import 'package:tennist_flutter/src/helper/AuthHelper.dart';
import 'package:tennist_flutter/src/model/AppError.model.dart';
import 'package:tennist_flutter/src/model/Error.model.dart';

class AddUserRacketHistoryProvider with ChangeNotifier {
  List<dynamic> gutResultModel;
  bool isSetGutList = false;
  int gutListValue = 0;

  get getIsSetGutList => isSetGutList;
  get getGutListModel => gutResultModel;

  Future<AddUserRacketHistoryModel> getGutListData() async {
    try {
      String accessT = await AuthHelper.getAccessToken();
      Map<String, String> headers = {
        "Content-Type": "application/json",
        "Authorization": "Bearer $accessT"
      };
      final String url = 'http://localhost:3000/api/v1/gut/list_with_company';
      final http.Response response = await http.get(url, headers: headers);
      if (response.statusCode == 200) {
        final resultModel = addUserRacketHistoryModelFromJson(response.body);
        print("resultModel");
        print(resultModel);
        return resultModel;
      }

      throw new Exception('notLoggedin');
    } catch (e) {
      throw new Exception('eeee');
    }
  }

  Future<dynamic> insertUserRacketHistory(data) async {
    try {
      print('checkData');

      String accessT = await AuthHelper.getAccessToken();
      Map<String, String> headers = {
        "Content-Type": "application/json",
        "Authorization": "Bearer $accessT"
      };
      final String url =
          'http://localhost:3000/api/v1/user/racket_history/insert';
      // final String url = '${appConfig.baseUrl}/signup';
      final http.Response response =
          await http.post(url, headers: headers, body: json.encode(data));

      if (response.statusCode == 200) {
        final resultModel = physicalInfoFormModelFromJson(response.body);

        return resultModel.result;
      }
      final errorModel = errorModelFromJson(response.body);

      return errorModel.result;
    } catch (e) {
      print(e);

      print('에러에 접근했습니다.');

      AppErrorModel result =
          AppErrorModel(status: 503, message: "에러가 발생했습니다. 잠시 후 다시 시도해주세요.");

      return result;
    }
  }
}
