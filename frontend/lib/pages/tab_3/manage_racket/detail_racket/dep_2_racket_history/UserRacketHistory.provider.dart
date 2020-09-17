import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:async/async.dart';
import 'package:tennist/pages/tab_3/manage_racket/detail_racket/dep_1_racket_list/UserRacketList.model.dart';
import 'package:tennist/pages/tab_3/manage_racket/detail_racket/dep_2_racket_history/UserRacketHistory.model.dart';

import 'package:tennist/src/helper/AppConfig.dart';
import 'package:tennist/src/helper/AuthHelper.dart';

class UserRacketHistoryProvider with ChangeNotifier {
  Future<UserRacketHistoryModel> getData(racketHistoryId, racketId) async {
    try {
      String accessT = await AuthHelper.getAccessToken();
      Map<String, String> headers = {
        "Content-Type": "application/json",
        "Authorization": "Bearer $accessT"
      };
      final String url =
          'https://water-flavour.com/api/v1/user/racket_history?racket_history_id=$racketHistoryId&racket_id=$racketId';
      final http.Response response = await http.get(url, headers: headers);
      if (response.statusCode == 200) {
        final resultModel = userRacketHistoryModelFromJson(response.body);
        return resultModel;
      }

      throw new Exception('notLoggedin');
    } catch (e) {
      throw new Exception('eeee');
    }
  }
}
