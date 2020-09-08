import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:tennist_flutter/pages/tab_3/manage_racket/add_racket/dep_2_select_racket_version/SelectRacketVersion.model.dart';
import 'package:tennist_flutter/pages/tab_3/manage_racket/add_racket/dep_2_select_racket_version/SelectRacketVersion.provider.dart';
import 'package:tennist_flutter/pages/tab_3/manage_racket/add_racket/dep_3_select_racket_model/SelectRacketModel.screen.dart';
import 'package:tennist_flutter/pages/tab_3/manage_racket/detail_racket/dep_1_racket_list/UserRacketList.screen.dart';

import 'package:tennist_flutter/src/helper/ScreenPassData.dart';
import 'package:tennist_flutter/src/widget/BasicListRow.dart';

class SelectRacketVersionScreen extends StatelessWidget {
  static const String routeName = '/SelectRacketVersion';
  bool loading = false;
  bool isFirstLoading = true;
  Future serverData;

  @override
  Widget build(BuildContext context) {
    print("동적불고가!!");

    final ScreenPassData args = ModalRoute.of(context).settings.arguments;

    if (isFirstLoading) {
      serverData = SelectRacketVersionProvider().getData(args.data['id']);
      isFirstLoading = false;
    }
    print(args.data['id']);
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
      body: FutureBuilder<SelectRacketVersionModel>(
        future: serverData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data.result.data.list.length < 1) {
              return Container(
                child: new Center(
                  child: Container(
                    child: const Center(
                      child: Text(
                        "라켓 버전이 없습니다.",
                      ),
                    ),
                  ),
                ),
              );
            } else {
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
                        SelectRacketModelScreen.routeName,
                        arguments: ScreenPassData(passData),
                      );
                    },
                  );
                },
              );
            }
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
