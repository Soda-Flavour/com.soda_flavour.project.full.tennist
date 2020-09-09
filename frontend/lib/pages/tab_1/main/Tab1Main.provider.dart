import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:async/async.dart';
import 'package:tennist_flutter/src/helper/AppConfig.dart';
import 'package:tennist_flutter/src/helper/AuthHelper.dart';
import 'package:tennist_flutter/pages/tab_1/main/Tab1Main.model.dart';

class Tab1MainProvider with ChangeNotifier {
  AppConfig _appConfig;
  AppConfig get appConfig => _appConfig;
  final AsyncMemoizer _memoizer = AsyncMemoizer();

  set appConfig(AppConfig appConfigVal) {
    if (_appConfig != appConfigVal) {
      _appConfig = appConfigVal;
      notifyListeners();
    }
  }

  Future<Tab1MainModel> getData() async {
    try {
      String accessT = await AuthHelper.getAccessToken();
      Map<String, String> headers = {
        "Content-Type": "application/json",
        "Authorization": "Bearer $accessT"
      };
      final String url =
          'http://localhost:3000/api/v1/section_1/racket_of_users';
      final http.Response response = await http.get(url, headers: headers);
      if (response.statusCode == 200) {
        final resultModel = tab1MainModelFromJson(response.body);
        return resultModel;
      }

      throw new Exception('notLoggedin');
    } catch (e) {
      throw new Exception('eeee');
    }
  }
}
