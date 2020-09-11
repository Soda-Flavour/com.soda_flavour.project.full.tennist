import 'dart:io';

import 'package:flutter/material.dart';

import 'package:tennist_flutter/main.dart';
import 'package:tennist_flutter/src/helper/AppConfig.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  const String kPort = '3000';
  final String baseUrl = Platform.isAndroid
      ? 'http://172.30.1.38:' + kPort
      : 'http://172.30.1.38:' + kPort;

  final String dataUrl = '$baseUrl/api/v1';

  final appConfig = AppConfig(
    baseUrl: baseUrl,
    dataUrl: dataUrl,
    buildFlavor: 'dev',
  );
  print("여기여기");
  print(appConfig.dataUrl);
  runApp(MyApp(appConfig));
}
