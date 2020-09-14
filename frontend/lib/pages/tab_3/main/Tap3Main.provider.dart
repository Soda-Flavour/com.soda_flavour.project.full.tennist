import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:tennist_flutter/pages/account/signup/SignUp.model.dart';
import 'package:tennist_flutter/pages/tab_3/main/Tab3Main.model.dart';
import 'package:tennist_flutter/pages/tab_3/main/UploadThumb.model.dart';
import 'package:tennist_flutter/src/helper/AppConfig.dart';
import 'package:tennist_flutter/src/helper/AuthHelper.dart';
import 'package:tennist_flutter/src/model/AppError.model.dart';
import 'package:tennist_flutter/src/model/Error.model.dart';

class Tap3MainProvider with ChangeNotifier {
  Future<Tab3MainModel> getData() async {
    try {
      String accessT = await AuthHelper.getAccessToken();
      print('accessT: $accessT');
      if (accessT == null) {
        throw new Exception('notLoggedin');
      }
      Map<String, String> headers = {
        "Content-Type": "application/json",
        "Authorization": "Bearer $accessT"
      };
      final String url = 'http://localhost:3000/api/v1/user/mypage';
      final http.Response response = await http.get(url, headers: headers);
      if (response.statusCode == 200) {
        print('진입1');
        final resultModel = tab3MainModelFromJson(response.body);
        print('진입');
        return resultModel;
      }

      throw new Exception('notLoggedin');
    } catch (e) {
      print(e);
      throw new Exception(e);
    }
  }

  Future<dynamic> uploadThumbnail(ByteData byteData) async {
    try {
      String accessT = await AuthHelper.getAccessToken();
      Map<String, String> headers = {
        "Content-Type": "application/json",
        "Authorization": "Bearer $accessT"
      };

      var byte = byteData.buffer
          .asUint8List(byteData.offsetInBytes, byteData.lengthInBytes)
          .toList();
      var client = http.Client();

      final http.Response response = await client.post(
          'http://localhost:3000/api/v1/user/mypage/upload_thumb',
          headers: headers,
          body: json.encode({'data': base64.encode(byte)}));

      if (response.statusCode == 200) {
        final resultModel = uploadThumbModelFromJson(response.body);

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
