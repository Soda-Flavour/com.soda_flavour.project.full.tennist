import 'dart:io';

import 'package:flutter/material.dart';

import 'package:tennist/main.dart';
import 'package:tennist/src/helper/AppConfig.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  const String kPort = '3000';
  final String baseUrl = Platform.isAndroid
      ? 'http://localhost:' + kPort
      : 'http://localhost:' + kPort;

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
