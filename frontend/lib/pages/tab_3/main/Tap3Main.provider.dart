import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:tennist_flutter/pages/account/signup/SignUp.model.dart';
import 'package:tennist_flutter/pages/tab_3/main/Tab3Main.model.dart';
import 'package:tennist_flutter/src/helper/AppConfig.dart';
import 'package:tennist_flutter/src/helper/AuthHelper.dart';
import 'package:tennist_flutter/src/model/AppError.model.dart';
import 'package:tennist_flutter/src/model/Error.model.dart';

class Tap3MainProvider with ChangeNotifier {
  AppConfig _appConfig;
  AppConfig get appConfig => _appConfig;

  set appConfig(AppConfig appConfigVal) {
    if (_appConfig != appConfigVal) {
      _appConfig = appConfigVal;
      print('앱콘피그 $_appConfig');
      notifyListeners();
    }
  }

  Future<Tab3MainModel> getData() async {
    try {
      String accessT = await AuthHelper.getAccessToken();
      print('accessT: $accessT');
      if (accessT == null) {
        throw new Exception('notLoggedin');
      }
      Map<String, String> headers = {
        "Content-Type": "application/json",
        "Authorization": "Bearer $accessT"
      };
      final String url = 'http://localhost:3000/api/v1/user/mypage';
      final http.Response response = await http.get(url, headers: headers);
      if (response.statusCode == 200) {
        print('진입1');
        final resultModel = tab3MainModelFromJson(response.body);
        print('진입');
        return resultModel;
      }

      throw new Exception('notLoggedin');
    } catch (e) {
      print(e);
      throw new Exception(e);
    }
  }
}
