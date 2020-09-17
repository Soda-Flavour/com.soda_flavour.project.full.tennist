import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:tennist/main.dart';
import 'package:tennist/src/helper/AppConfig.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
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
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(MyApp(appConfig));
}
