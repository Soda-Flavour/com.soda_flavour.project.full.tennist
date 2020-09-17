import 'dart:async';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:tennist/pages/BottomNaviController.dart';

class SplashScreen extends StatefulWidget {
  int splashTime;
  SplashScreen(this.splashTime);
  @override
  _SplashScreenState createState() =>
      _SplashScreenState(splashTime: splashTime);
}

/// Component UI
class _SplashScreenState extends State<SplashScreen> {
  int splashTime;
  _SplashScreenState({Key key, this.splashTime});

  /// To navigate layout change
  void NavigatorPage() async {
    Widget page;
    page = BottomNaviController();

    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => page),
        (Route<dynamic> route) => false);
  }

  /// Declare startTime to InitState
  @override
  void initState() {
    super.initState();
    (() async {
      await new Timer(Duration(milliseconds: splashTime), NavigatorPage);
    })();
  }

  /// Code Create UI Splash Screen
  Widget build(BuildContext context) {
    var assetsImage = new AssetImage('assets/images/tennist_logo.png');
    var image = new Image(
      image: assetsImage,
      width: MediaQuery.of(context).size.width / 2,
    );

    return Scaffold(
      backgroundColor: const Color(0xff141414),
      body: Center(
        child: Container(
          child: image,
        ),
      ),
    );
  }
}
