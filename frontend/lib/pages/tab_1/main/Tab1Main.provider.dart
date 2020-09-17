import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:async/async.dart';
import 'package:tennist/src/helper/AppConfig.dart';
import 'package:tennist/src/helper/AuthHelper.dart';
import 'package:tennist/pages/tab_1/main/Tab1Main.model.dart';

class Tab1MainProvider with ChangeNotifier {
  Future<Tab1MainModel> getData() async {
    try {
      String accessT = await AuthHelper.getAccessToken();
      Map<String, String> headers = {
        "Content-Type": "application/json",
        "Authorization": "Bearer $accessT"
      };
      final String url =
          'https://water-flavour.com/api/v1/section_1/racket_of_users';
      final http.Response response = await http.get(url, headers: headers);
      if (response.statusCode == 200) {
        final resultModel = tab1MainModelFromJson(response.body);
        return resultModel;
      }

      throw new Exception('notLoggedin');
    } catch (e) {
      print(e);
      throw new Exception('eeee');
    }
  }
}
