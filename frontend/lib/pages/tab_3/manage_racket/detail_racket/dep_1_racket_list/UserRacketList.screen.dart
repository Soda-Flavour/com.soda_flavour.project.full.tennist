import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:tennist/pages/tab_3/manage_racket/add_racket/dep_1_select_racket_company/SelectRacketCompany.screen.dart';
import 'package:tennist/pages/tab_3/manage_racket/detail_racket/dep_1_racket_list/UserRacketList.model.dart';
import 'package:tennist/pages/tab_3/manage_racket/detail_racket/dep_1_racket_list/UserRacketList.provider.dart';
import 'package:tennist/pages/tab_3/manage_racket/detail_racket/dep_2_racket_history/UserRacketHistory.screen.dart';
import 'package:tennist/src/helper/PopWithResults.dart';
import 'package:tennist/src/helper/ScreenPassData.dart';

import 'package:tennist/src/widget/BasicListRow.dart';

class UserRacketListScreen extends StatefulWidget {
  static const String routeName = '/UserRacketList';

  @override
  _UserRacketListScreen createState() => _UserRacketListScreen();
}

class _UserRacketListScreen extends State<UserRacketListScreen> {
  final storage = new FlutterSecureStorage();
  final isLogin = false;
  Future serverData;

  @override
  void initState() {
    print("페이지가 인잇됩니다.");
    super.initState();
    serverData = UserRacketListProvider().getData();
    //TODO: 해당 응답이 3040번 에러이면 로그인이 안되어 있는 것이다. ==> 로그인 페이지 로딩
    // ApiReciver.POST(
    //     'https://water-flavour.com/api/v1/auth/checkAccessToken', null, true);
  }

  @override
  Widget build(BuildContext context) {
    print("동적불고가!!");

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60.0),
        child: Container(
          alignment: FractionalOffset.centerRight,
          child: AppBar(
            automaticallyImplyLeading: true, //왼쪽 화살표 뒤로 없애기
            backgroundColor: const Color(0xff141414),
            title: Text(
              '라캣 관리',
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
                icon: new Icon(Icons.add),
                onPressed: () {
                  Navigator.of(context)
                      .pushNamed(SelectRacketCompanyScreen.routeName)
                      .then((results) {
                    PopWithResults popResult = results as PopWithResults;
                    if (popResult != null) {
                      if (popResult.toPage == UserRacketListScreen.routeName) {
                        print(popResult.results.values.toList()[0]);
                        serverData = UserRacketListProvider().getData();
                        setState(() {});
                      } else {
                        Navigator.of(context).pop(results);
                      }
                    }
                  });

                  // Navigator.of(context)
                  //     .pushNamed(SelectRacketCompanyScreen.routeName);
                },
              ),
            ],
          ),
        ),
      ),
      body: FutureBuilder<UserRacketListModel>(
        future: serverData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data.result.data.list.length,
              itemBuilder: (context, index) {
                // ProjectModel project = projectSnap.data[index];
                return BasicListRow(
                  rowText:
                      "${snapshot.data.result.data.list[index].racketNickname}\n ${snapshot.data.result.data.list[index].nameKor} ${snapshot.data.result.data.list[index].model}",
                  onTap: () {
                    Map<String, dynamic> passData = {
                      "user_racket_id":
                          snapshot.data.result.data.list[index].id,
                      "racket_id":
                          snapshot.data.result.data.list[index].tRacketId,
                    };
                    print("아이디 전달 : ${snapshot.data.result.data.list[index]}");
                    print(
                        "라켓값 전달 : ${snapshot.data.result.data.list[index].tRacketId}");
                    Navigator.of(context).pushNamed(
                        UserRacketHistoryScreen.routeName,
                        arguments: ScreenPassData(passData));
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
