import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tennist_flutter/pages/tab_3/manage_racket/UserRacketList.screen.dart';
import 'package:tennist_flutter/pages/tab_3/manage_racket/add_racket/dep_3_select_racket/SelectRacket.screen.dart';
import 'package:tennist_flutter/src/widget/BasicListRow.dart';

class SelectRacketVersionScreen extends StatefulWidget {
  static const String routeName = '/SelectRacketVersion';

  @override
  _SelectRacketVersionScreenState createState() =>
      _SelectRacketVersionScreenState();
}

class _SelectRacketVersionScreenState extends State<SelectRacketVersionScreen>
    with AutomaticKeepAliveClientMixin {
  bool loading = false;
  final List<String> racket_version = <String>[
    '그라핀 360+ 그래비티',
    '그라핀 360+ 스피드',
    '인스팅트'
  ];

  final List<int> colorCodes = <int>[600, 500, 100];

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60.0),
        child: Container(
          alignment: FractionalOffset.centerRight,
          child: AppBar(
            automaticallyImplyLeading: true, //왼쪽 화살표 뒤로 없애기
            backgroundColor: const Color(0xff141414),
            title: Text(
              '라캣 버전 선택',
              style: TextStyle(
                fontWeight: FontWeight.w400,
                letterSpacing: 0.07,
                color: Colors.white,
                fontSize: 18.0,
              ),
            ),
            centerTitle: true,
            actions: <Widget>[
              new IconButton(
                icon: new Icon(Icons.close),
                onPressed: () => Navigator.popUntil(context,
                    ModalRoute.withName(UserRacketListScreen.routeName)),
              ),
            ],
          ),
        ),
      ),
      body: loading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              shrinkWrap: true,
              itemCount: racket_version.length,
              itemBuilder: (BuildContext context, int index) {
                return BasicListRow(
                  rowText: racket_version[index],
                  onTap: () {
                    Navigator.of(context)
                        .pushNamed(SelectRacketScreen.routeName);
                  },
                );
              },
            ),
    );
  }
}
