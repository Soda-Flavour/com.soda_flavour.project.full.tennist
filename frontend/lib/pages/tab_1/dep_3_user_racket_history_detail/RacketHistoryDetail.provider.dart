import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:async/async.dart';
import 'package:tennist_flutter/pages/tab_1/dep_3_user_racket_history_detail/RacketHistoryDetail.model.dart';
import 'package:tennist_flutter/pages/tab_3/manage_racket/detail_racket/dep_1_racket_list/UserRacketList.model.dart';
import 'package:tennist_flutter/pages/tab_3/manage_racket/detail_racket/dep_2_racket_history/UserRacketHistory.model.dart';
import 'package:tennist_flutter/pages/tab_3/manage_racket/detail_racket/dep_3_racket_history_detail/UserRacketHistoryDetail.model.dart';
import 'package:tennist_flutter/pages/tab_3/manage_racket/detail_racket/dep_3_racket_history_detail/UserRacketHistoryDetailComment.model.dart';

import 'package:tennist_flutter/src/helper/AppConfig.dart';
import 'package:tennist_flutter/src/helper/AuthHelper.dart';
import 'package:tennist_flutter/src/model/AppError.model.dart';
import 'package:tennist_flutter/src/model/Error.model.dart';

class RacketHistoryDetailProvider with ChangeNotifier {
  Future<RacketHistoryDetailModel> getData(
    racketHistoryDetailId,
  ) async {
    try {
      String accessT = await AuthHelper.getAccessToken();
      Map<String, String> headers = {
        "Content-Type": "application/json",
        "Authorization": "Bearer $accessT"
      };
      final String url =
          'http://localhost:3000/api/v1/section_1/racket_history/detail?user_racket_history_id=$racketHistoryDetailId';
      final http.Response response = await http.get(url, headers: headers);
      if (response.statusCode == 200) {
        final resultModel = racketHistoryDetailModelFromJson(response.body);
        print("resultModel");
        return resultModel;
      }

      throw new Exception('notLoggedin');
    } catch (e) {
      throw new Exception('eeee');
    }
  }

  Future<dynamic> sendComment(userRacketHistoryId, comment) async {
    try {
      print('checkData');

      String accessT = await AuthHelper.getAccessToken();
      Map<String, String> headers = {
        "Content-Type": "application/json",
        "Authorization": "Bearer $accessT"
      };
      final String url =
          'http://localhost:3000/api/v1/section_1/racket_history/detail';
      // final String url = '${appConfig.baseUrl}/signup';
      final http.Response response = await http.post(url,
          headers: headers,
          body: json.encode({
            'user_racket_history_id': userRacketHistoryId,
            'comment': comment
          }));

      if (response.statusCode == 200) {
        final resultModel =
            userRacketHistoryDetailCommentModelFromJson(response.body);

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
