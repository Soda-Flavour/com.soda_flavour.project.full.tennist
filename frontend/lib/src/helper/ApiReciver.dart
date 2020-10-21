import 'dart:async';
import 'package:http/http.dart' as http;

import 'package:tennist/src/helper/AuthHelper.dart';

class ApiReciver {
  static Map<String, String> headers = {
    "Content-Type": "application/json",
  };

  static final ApiReciver _instance = ApiReciver._internal();
  factory ApiReciver() => _instance;

  ApiReciver._internal() {
    //초기화 코드
    print("ApiReciver loaded...");
  }

  static Future<dynamic> GET(String url, data, {bool auth = false}) async {
    try {
      if (auth) {
        if (await AuthHelper.isLogin() == false)
          throw Exception('Not login...');
      }
    } catch (e) {
      print("Error: " + e.toString());
      return false;
    }
  }

  static Future<dynamic> POST(String url, data, bool bool,
      {bool auth = false}) async {
    try {
      if (auth) {
        if (await AuthHelper.hasToken() == false)
          throw Exception('Not login...');
        else {
          headers["Authorization"] =
              'Bearer ' + await AuthHelper.getAccessToken();
        }
      }

      final response = await http.post(url, headers: headers, body: data);
      return response;
    } catch (e) {
      print("Error: " + e.toString());
      return false;
    }
  }
}
