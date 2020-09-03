import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:tennist_flutter/pages/tab_3/manage_racket/add_racket/dep_1_select_racket_company/SelectRacketCompany.model.dart';
import 'package:tennist_flutter/pages/tab_3/manage_racket/add_racket/dep_1_select_racket_company/SelectRacketCompany.provider.dart';
import 'package:tennist_flutter/pages/tab_3/manage_racket/add_racket/dep_2_select_racket_version/SelectRacketVersion.screen.dart';
import 'package:tennist_flutter/src/helper/ScreenPassData.dart';
import 'package:tennist_flutter/src/widget/BasicListRow.dart';

class SelectRacketCompanyScreen extends StatelessWidget {
  static const String routeName = '/SelectRacketComapny';

  bool loading = false;

  @override
  Widget build(BuildContext context) {
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
      body: FutureBuilder<SelectRacketCompanyModel>(
        future: SelectRacketCompanyProvider().getData(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data.result.data.list.length,
              itemBuilder: (context, index) {
                // ProjectModel project = projectSnap.data[index];
                return BasicListRow(
                  rowText: snapshot.data.result.data.list[index].nameKor,
                  onTap: () {
                    Map<String, dynamic> passData = {
                      "id": snapshot.data.result.data.list[index].id,
                      "versionName":
                          snapshot.data.result.data.list[index].nameKor,
                    };

                    Navigator.of(context).pushNamed(
                      SelectRacketVersionScreen.routeName,
                      arguments: ScreenPassData(passData),
                    );
                  },
                );
              },
            );
          }
          return Container(
            child: new Center(
              child: Container(
                color: Colors.black.withOpacity(.5),
                child: const Center(
                  child: const CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(
                      Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
