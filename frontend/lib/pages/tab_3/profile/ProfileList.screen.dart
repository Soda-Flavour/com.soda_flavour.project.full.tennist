import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:tennist_flutter/pages/tab_3/profile/basic_info/UserBasicInfoForm.screen.dart';
import 'package:tennist_flutter/pages/tab_3/profile/physical_info/PhysicalInfoForm.screen.dart';
import 'package:tennist_flutter/pages/tab_3/profile/tennis_info/tennisInfoForm.screen.dart';
import 'package:tennist_flutter/src/helper/ApiReciver.dart';
import 'package:tennist_flutter/src/helper/AuthHelper.dart';
import 'package:tennist_flutter/src/widget/BasicListRow.dart';

class ProfileListScreen extends StatefulWidget {
  static const String routeName = '/ProfileList';

  @override
  _ProfileListScreen createState() => _ProfileListScreen();
}

class _ProfileListScreen extends State<ProfileListScreen> {
  final storage = new FlutterSecureStorage();
  final isLogin = false;

  final List<String> rowTitle = <String>['기본정보', '신체사항', '플레이 스타일'];
  final List<String> rowRouteName = <String>[
    UserBasicInfoFormScreen.routeName,
    PhysicalInfoFormScreen.routeName,
    TennisInfoFormScreen.routeName
  ];

  @override
  void initState() {
    super.initState();
    //TODO: 해당 응답이 3040번 에러이면 로그인이 안되어 있는 것이다. ==> 로그인 페이지 로딩
    // ApiReciver.POST(
    //     'http://172.30.1.38:3000/api/v1/auth/checkAccessToken', null, true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60.0),
        child: Container(
          alignment: FractionalOffset.centerRight,
          child: AppBar(
            automaticallyImplyLeading: true, //왼쪽 화살표 뒤로 없애기
            backgroundColor: const Color(0xff141414),
            title: Text(
              '프로필 관리',
              style: TextStyle(
                fontWeight: FontWeight.w400,
                letterSpacing: 0.07,
                color: Colors.white,
                fontSize: 18.0,
              ),
            ),
            centerTitle: true,
          ),
        ),
      ),
      body: ListView.builder(
        shrinkWrap: true,
        itemCount: rowRouteName.length,
        itemBuilder: (BuildContext context, int index) {
          // final item = snapshot.data[index];

          return BasicListRow(
            rowText: rowTitle[index],
            onTap: () {
              Navigator.of(context).pushNamed(rowRouteName[index]);
            },
          );
        },
      ),
    );
  }
}
