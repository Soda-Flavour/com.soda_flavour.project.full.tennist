// import 'package:flutter/material.dart';
// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import 'package:async/async.dart';
// import 'package:tennist/pages/account/signup/SignUp.model.dart';
// import 'package:tennist/pages/tab_3/main/Tab3Main.model.dart';
// import 'package:tennist/pages/tab_3/manage_racket/add_racket/dep_2_select_racket_version/SelectRacketVersion.model.dart';

// import 'package:tennist/src/helper/AppConfig.dart';
// import 'package:tennist/src/helper/AuthHelper.dart';
// import 'package:tennist/src/model/AppError.model.dart';
// import 'package:tennist/src/model/Error.model.dart';

// class SelectRacketVersionProvider with ChangeNotifier {
//   Future<SelectRacketVersionModel> getData(id) async {
//     try {
//       String accessT = await AuthHelper.getAccessToken();
//       Map<String, String> headers = {
//         "Content-Type": "application/json",
//         "Authorization": "Bearer $accessT"
//       };
//       final String url = 'https://water-flavour.com/api/v1/racket_version/$id';
//       final http.Response response = await http.get(url, headers: headers);
//       if (response.statusCode == 200) {
//         final resultModel = selectRacketVersionModelFromJson(response.body);
//         return resultModel;
//       }

//       throw new Exception('notLoggedin');
//     } catch (e) {
//       throw new Exception('eeee');
//     }
//   }
// }
