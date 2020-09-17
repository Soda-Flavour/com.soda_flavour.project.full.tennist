import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:async/async.dart';
import 'package:tennist/pages/tab_3/manage_racket/detail_racket/dep_1_racket_list/UserRacketList.model.dart';

import 'package:tennist/src/helper/AppConfig.dart';
import 'package:tennist/src/helper/AuthHelper.dart';

class UserRacketListProvider with ChangeNotifier {
  Future<UserRacketListModel> getData() async {
    try {
      String accessT = await AuthHelper.getAccessToken();
      Map<String, String> headers = {
        "Content-Type": "application/json",
        "Authorization": "Bearer $accessT"
      };
      final String url = 'https://water-flavour.com/api/v1/user/racket/list';
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
