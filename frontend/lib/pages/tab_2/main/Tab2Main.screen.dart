import 'package:flutter/material.dart';

class Tab2MainScreen extends StatefulWidget {
  static const String routeName = '/Tab2Main';

  @override
  _Tab2MainScreenState createState() => _Tab2MainScreenState();
}

class _Tab2MainScreenState extends State<Tab2MainScreen>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Tab2MainScreen'), // 타이틀
        centerTitle: true, // 타이틀 중앙정렬
        backgroundColor: Colors.redAccent, //앱바 색상
        elevation: 0.0, //앱바의 떠있는 효과(그림자) 0.0 은 앱바 그림자 지워줌
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.fromLTRB(30.0, 40.0, 0.0, 0.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center, //앱스크린 세로축 상단중단하단 정리
            children: <Widget>[
              Text(
                'Tab2MainScreen',
                style: TextStyle(
                    color: Colors.black,
                    letterSpacing: 2.0,
                    fontSize: 28.0,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
