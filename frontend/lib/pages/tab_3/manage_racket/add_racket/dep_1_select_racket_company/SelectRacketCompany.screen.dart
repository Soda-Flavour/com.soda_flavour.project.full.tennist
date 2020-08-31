import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:tennist_flutter/pages/tab_3/manage_racket/add_racket/dep_2_select_racket_version/SelectRacketVersion.screen.dart';
import 'package:tennist_flutter/src/widget/BasicListRow.dart';

class SelectRacketCompanyScreen extends StatefulWidget {
  static const String routeName = '/SelectRacketComapny';

  @override
  _SelectRacketCompanyScreenState createState() =>
      _SelectRacketCompanyScreenState();
}

class _SelectRacketCompanyScreenState extends State<SelectRacketCompanyScreen>
    with AutomaticKeepAliveClientMixin {
  bool loading = false;
  final List<String> company = <String>['윌슨', '헤드', '바볼랏'];

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
            automaticallyImplyLeading: false, //왼쪽 화살표 뒤로 없애기
            backgroundColor: const Color(0xff141414),
            title: Text(
              '라캣 회사 선택',
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
                onPressed: () => Navigator.of(context).pop(null),
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
              itemCount: company.length,
              itemBuilder: (BuildContext context, int index) {
                return BasicListRow(
                  rowText: company[index],
                  onTap: () {
                    Navigator.of(context)
                        .pushNamed(SelectRacketVersionScreen.routeName);
                  },
                );
              },
            ),
    );
  }
}
