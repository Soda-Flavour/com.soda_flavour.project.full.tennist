import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:async/async.dart';
import 'package:tennist_flutter/pages/account/signup/SignUp.model.dart';
import 'package:tennist_flutter/pages/tab_3/main/Tab3Main.model.dart';
import 'package:tennist_flutter/pages/tab_3/profile/basic_info/UserBasicInfoForm.model.dart';
import 'package:tennist_flutter/src/helper/AppConfig.dart';
import 'package:tennist_flutter/src/helper/AuthHelper.dart';
import 'package:tennist_flutter/src/model/AppError.model.dart';
import 'package:tennist_flutter/src/model/Error.model.dart';

class UserBasicInfoFormProvider with ChangeNotifier {
  AppConfig _appConfig;
  AppConfig get appConfig => _appConfig;
  final AsyncMemoizer _memoizer = AsyncMemoizer();

  set appConfig(AppConfig appConfigVal) {
    if (_appConfig != appConfigVal) {
      _appConfig = appConfigVal;
      notifyListeners();
    }
  }

  // Future<UserBasicInfoFormModel> getData() async {
  //   return this._memoizer.runOnce(() async {
  //     await Future.delayed(Duration(seconds: 2));
  //     print('함수가 동작합니다./');
  //     return 'REMOTE DATA';
  //     // try {
  //     //   String accessT = await AuthHelper.getAccessToken();
  //     //   Map<String, String> headers = {
  //     //     "Content-Type": "application/json",
  //     //     "Authorization": "Bearer $accessT"
  //     //   };
  //     //   final String url = 'http://172.30.1.38:3000/api/v1/user/basic_info';
  //     //   final http.Response response = await http.get(url, headers: headers);
  //     //   if (response.statusCode == 200) {
  //     //     print("하이이이이");
  //     //     final resultModel = userBasicInfoFormModelFromJson(response.body);

  //     //     return resultModel;
  //     //   }

  //     //   throw new Exception('notLoggedin');
  //     // } catch (e) {
  //     //   throw new Exception('eeee');
  //     // }
  //   });
  // }

  Future<UserBasicInfoFormModel> getData() async {
    try {
      String accessT = await AuthHelper.getAccessToken();
      Map<String, String> headers = {
        "Content-Type": "application/json",
        "Authorization": "Bearer $accessT"
      };
      final String url = 'http://172.30.1.38:3000/api/v1/user/basic_info';
      final http.Response response = await http.get(url, headers: headers);
      if (response.statusCode == 200) {
        print("하이이이이");
        final resultModel = userBasicInfoFormModelFromJson(response.body);
        return resultModel;
      }

      throw new Exception('notLoggedin');
    } catch (e) {
      throw new Exception('eeee');
    }
  }

  Future<dynamic> updateBasicInfo(data) async {
    try {
      print('checkData');

      String accessT = await AuthHelper.getAccessToken();
      Map<String, String> headers = {
        "Content-Type": "application/json",
        "Authorization": "Bearer $accessT"
      };
      final String url = 'http://172.30.1.38:3000/api/v1/user/basic_info';
      // final String url = '${appConfig.baseUrl}/signup';
      final http.Response response =
          await http.post(url, headers: headers, body: json.encode(data));

      if (response.statusCode == 200) {
        final resultModel = userBasicInfoFormModelFromJson(response.body);

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
