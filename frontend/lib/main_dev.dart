import 'dart:io';

import 'package:flutter/material.dart';

import 'package:tennist_flutter/main.dart';
import 'package:tennist_flutter/src/helper/AppConfig.dart';

void main() {
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

  runApp(MyApp(appConfig));
}
