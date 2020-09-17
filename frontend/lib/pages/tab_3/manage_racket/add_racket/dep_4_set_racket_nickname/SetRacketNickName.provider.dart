import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:async/async.dart';
import 'package:tennist/pages/tab_3/manage_racket/add_racket/dep_3_select_racket_model/SelectRacketModel.model.dart';

import 'package:tennist/src/helper/AppConfig.dart';
import 'package:tennist/src/helper/AuthHelper.dart';
import 'package:tennist/src/model/AppError.model.dart';
import 'package:tennist/src/model/Error.model.dart';

class SetRacketNickNameProvider with ChangeNotifier {
  Future<dynamic> insertUserRacket(data) async {
    try {
      print('checkData');
      print(json.encode(data));
      String accessT = await AuthHelper.getAccessToken();
      Map<String, String> headers = {
        "Content-Type": "application/json",
        "Authorization": "Bearer $accessT"
      };
      final String url =
          'https://water-flavour.com/api/v1/racket_model/insert_user_racket';
      // final String url = '${appConfig.baseUrl}/signup';
      final http.Response response =
          await http.post(url, headers: headers, body: json.encode(data));

      if (response.statusCode == 200) {
        final resultModel = selectRacketModelModelFromJson(response.body);

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
