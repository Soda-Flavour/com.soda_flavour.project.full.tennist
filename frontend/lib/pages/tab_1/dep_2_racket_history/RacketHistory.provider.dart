import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:async/async.dart';
import 'package:tennist/pages/tab_1/dep_2_racket_history/RacketHistory.model.dart';
import 'package:tennist/pages/tab_3/manage_racket/detail_racket/dep_1_racket_list/UserRacketList.model.dart';
import 'package:tennist/pages/tab_3/manage_racket/detail_racket/dep_2_racket_history/UserRacketHistory.model.dart';

import 'package:tennist/src/helper/AppConfig.dart';
import 'package:tennist/src/helper/AuthHelper.dart';

class RacketHistoryProvider with ChangeNotifier {
  Future<RacketHistoryModel> getData(racketHistoryId) async {
    try {
      String accessT = await AuthHelper.getAccessToken();
      Map<String, String> headers = {
        "Content-Type": "application/json",
        "Authorization": "Bearer $accessT"
      };
      final String url =
          'https://water-flavour.com/api/v1/section_1/racket_history?racket_history_id=$racketHistoryId';
      print(url);
      final http.Response response = await http.get(url, headers: headers);
      if (response.statusCode == 200) {
        final resultModel = racketHistoryModelFromJson(response.body);
        print(resultModel.result.data.list.length);
        return resultModel;
      }
      throw new Exception('notLoggedin');
    } catch (e) {
      print(e);
      throw new Exception('eeee');
    }
  }
}
