import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:tennist_flutter/pages/account/login/LogIn.model.dart';
import 'package:tennist_flutter/src/helper/AppConfig.dart';
import 'package:tennist_flutter/src/helper/AuthHelper.dart';
import 'package:tennist_flutter/src/model/AppError.model.dart';
import 'package:tennist_flutter/src/model/Error.model.dart';

class LogInProvider with ChangeNotifier {
  Future<dynamic> logIn(data) async {
    try {
      Map<String, String> headers = {
        "Content-Type": "application/json",
      };
      final String url = 'http://localhost:3000/api/v1/auth/login';
      // final String url = '${appConfig.baseUrl}/signup';

      final http.Response response =
          await http.post(url, headers: headers, body: json.encode(data));

      if (response.statusCode == 200) {
        final resultModel = logInModelFromJson(response.body);

        var result = resultModel.result;

        await AuthHelper.saveLoginToken(
            result.data.accessT, result.data.refreshT);

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
