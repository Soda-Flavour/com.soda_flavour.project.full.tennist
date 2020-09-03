import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:async/async.dart';
import 'package:tennist_flutter/pages/account/signup/SignUp.model.dart';
import 'package:tennist_flutter/pages/tab_3/main/Tab3Main.model.dart';
import 'package:tennist_flutter/pages/tab_3/manage_racket/UserRacketList.model.dart';
import 'package:tennist_flutter/pages/tab_3/manage_racket/add_racket/dep_1_select_racket_company/SelectRacketCompany.model.dart';

import 'package:tennist_flutter/src/helper/AppConfig.dart';
import 'package:tennist_flutter/src/helper/AuthHelper.dart';
import 'package:tennist_flutter/src/model/AppError.model.dart';
import 'package:tennist_flutter/src/model/Error.model.dart';

class UserRacketListProvider with ChangeNotifier {
  AppConfig _appConfig;
  AppConfig get appConfig => _appConfig;
  final AsyncMemoizer _memoizer = AsyncMemoizer();

  set appConfig(AppConfig appConfigVal) {
    if (_appConfig != appConfigVal) {
      _appConfig = appConfigVal;
      notifyListeners();
    }
  }

  Future<UserRacketListModel> getData() async {
    try {
      String accessT = await AuthHelper.getAccessToken();
      Map<String, String> headers = {
        "Content-Type": "application/json",
        "Authorization": "Bearer $accessT"
      };
      final String url = 'http://localhost:3000/api/v1/user/racket/list';
      final http.Response response = await http.get(url, headers: headers);
      if (response.statusCode == 200) {
        final resultModel = userRacketListModelFromJson(response.body);
        return resultModel;
      }

      throw new Exception('notLoggedin');
    } catch (e) {
      throw new Exception('eeee');
    }
  }
}
