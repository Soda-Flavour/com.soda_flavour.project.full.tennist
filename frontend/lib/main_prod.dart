import 'dart:io';

import 'package:flutter/material.dart';

import 'package:tennist_flutter/main.dart';
import 'package:tennist_flutter/src/helper/AppConfig.dart';

void main() {
  const String kPort = '3000';
  final String baseUrl = Platform.isAndroid
      ? 'https://water-flavour.com'
      : 'https://water-flavour.com';

  final String dataUrl = '$baseUrl/api/v1';

  final appConfig = AppConfig(
    baseUrl: baseUrl,
    dataUrl: dataUrl,
    buildFlavor: 'prod',
  );

  runApp(MyApp(appConfig));
}
