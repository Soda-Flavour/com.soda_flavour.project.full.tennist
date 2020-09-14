import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:tennist_flutter/pages/account/signup/SignUp.model.dart';
import 'package:tennist_flutter/src/helper/AppConfig.dart';
import 'package:tennist_flutter/src/model/AppError.model.dart';
import 'package:tennist_flutter/src/model/Error.model.dart';

class SignUpProvider with ChangeNotifier {
  Future<dynamic> signUp(data) async {
    try {
      Map<String, String> headers = {
        "Content-Type": "application/json",
      };
      final String url = 'http://localhost:3000/api/v1/auth/signup';
      // final String url = '${appConfig.baseUrl}/signup';

      final http.Response response =
          await http.post(url, headers: headers, body: json.encode(data));

      if (response.statusCode == 200) {
        final resultModel = signUpModelFromJson(response.body);

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
