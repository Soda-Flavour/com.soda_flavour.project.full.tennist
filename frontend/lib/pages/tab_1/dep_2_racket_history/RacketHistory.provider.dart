import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:async/async.dart';
import 'package:tennist_flutter/pages/tab_1/dep_2_racket_history/RacketHistory.model.dart';
import 'package:tennist_flutter/pages/tab_3/manage_racket/detail_racket/dep_1_racket_list/UserRacketList.model.dart';
import 'package:tennist_flutter/pages/tab_3/manage_racket/detail_racket/dep_2_racket_history/UserRacketHistory.model.dart';

import 'package:tennist_flutter/src/helper/AppConfig.dart';
import 'package:tennist_flutter/src/helper/AuthHelper.dart';

class RacketHistoryProvider with ChangeNotifier {
  AppConfig _appConfig;
  AppConfig get appConfig => _appConfig;
  final AsyncMemoizer _memoizer = AsyncMemoizer();

  set appConfig(AppConfig appConfigVal) {
    if (_appConfig != appConfigVal) {
      _appConfig = appConfigVal;
      notifyListeners();
    }
  }

  Future<RacketHistoryModel> getData(racketHistoryId) async {
    try {
      String accessT = await AuthHelper.getAccessToken();
      Map<String, String> headers = {
        "Content-Type": "application/json",
        "Authorization": "Bearer $accessT"
      };
      final String url =
          'http://172.30.1.38:3000/api/v1/section_1/racket_history?racket_history_id=$racketHistoryId';
      final http.Response response = await http.get(url, headers: headers);
      if (response.statusCode == 200) {
        final resultModel = racketHistoryModelFromJson(response.body);
        return resultModel;
      }

      throw new Exception('notLoggedin');
    } catch (e) {
      throw new Exception('eeee');
    }
  }
}
