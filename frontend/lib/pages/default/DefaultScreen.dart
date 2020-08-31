import 'package:flutter/material.dart';

class DefaultScreen extends StatelessWidget {
  static const String routeName = '/default';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('타이틀'), // 타이틀
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
                'hihi',
                style: TextStyle(
                    color: Colors.black,
                    letterSpacing: 2.0,
                    fontSize: 28.0,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 10.0,
              ),
              Text('hihi'),
              SizedBox(
                height: 30.0,
              ),
              Row(
                children: <Widget>[
                  Icon(
                    Icons.check_circle_outline,
                  ),
                  SizedBox(
                    width: 10.0,
                  ),
                  Text(
                    'This is Text',
                    style: TextStyle(fontSize: 16.0, letterSpacing: 1.0),
                  ),
                ],
              ),
              Text('hihi'),
            ],
          ),
        ),
      ),
    );
  }
}
