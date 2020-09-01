import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:tennist_flutter/pages/tab_3/main/Tab3Main.model.dart';
import 'package:tennist_flutter/pages/tab_3/main/Tap3Main.provider.dart';
import 'package:tennist_flutter/pages/tab_3/manage_racket/UserRacketList.screen.dart';
import 'package:tennist_flutter/pages/tab_3/profile/ProfileList.screen.dart';
import 'package:tennist_flutter/pages/tab_3/setting/SettingList.screen.dart';
import 'package:tennist_flutter/src/model/Error.model.dart';
import 'package:tennist_flutter/src/widget/DialogPopUp.widget.dart';
import 'package:tennist_flutter/src/helper/ApiReciver.dart';
import 'package:tennist_flutter/src/helper/AuthHelper.dart';

class Tab3MainScreen extends StatefulWidget {
  static const String routeName = '/Tab3Main';

  @override
  _Tab3MainScreenState createState() => _Tab3MainScreenState();
}

class _Tab3MainScreenState extends State<Tab3MainScreen> {
  final storage = new FlutterSecureStorage();
  final isLogin = false;

  @override
  void initState() {
    super.initState();
  }

  Widget buildProfile(String nick, String ntrp) {
    return Padding(
      padding: const EdgeInsets.all(18.0),
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Stack(
                alignment: AlignmentDirectional.bottomEnd,
                children: <Widget>[
                  CircleAvatar(
                    radius: 35.0,
                    backgroundImage:
                        new AssetImage('assets/images/profile_1.jpeg'),
                  ),
                  // CircleAvatar(
                  //   radius: 12.0,
                  //   backgroundColor: const Color(0xff48caf5),
                  //   backgroundImage: new AssetImage(
                  //     'assets/images/outline_create_white.png',
                  //   ),
                  // ),
                  CircleAvatar(
                    radius: 12,
                    backgroundColor: const Color(0xff48caf5),
                    child: ClipOval(
                      child: Image.asset(
                        'assets/images/outline_create_white.png',
                        width: 18.0,
                      ),
                    ),
                  ),
                ],
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 18.0),
                  child: Column(
                    children: <Widget>[
                      Container(
                        width: double.infinity,
                        child: Text(
                          '$nick',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 4.0),
                        child: Container(
                          width: double.infinity,
                          child: Text(
                            'NTRP $ntrp',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget loadMyPage() {}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50),
        child: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            Container(
              color: const Color(0xff141414),
            ),
            Center(
              child: Container(
                margin: EdgeInsets.only(top: 35.0),
                child: Text(
                  '마이페이지',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 22.0,
                      fontWeight: FontWeight.w500),
                ),
              ),
            ),
          ],
        ),
      ),
      body: FutureBuilder<Tab3MainModel>(
        future: Tap3MainProvider().getData(),
        builder: (context, snapshot) {
          if (snapshot.hasData || snapshot.hasError) {
            bool isLoggedIn = (snapshot.data != null) ? true : false;
            String nick = (snapshot.data != null)
                ? snapshot.data.result.data[0].nick
                : '로그인이 필요합니다.';
            String ntrp = (snapshot.data != null)
                ? snapshot.data.result.data[0].ntrp
                : '-';

            String play_style = (snapshot.data != null)
                ? snapshot.data.result.data[0].playStyle
                : '-';

            print("데이터가 있습니다.");
            return ListView.builder(
              shrinkWrap: true,
              itemCount: 5,
              itemBuilder: (BuildContext context, int index) {
                // final item = snapshot.data[index];

                if (index == 0) {
                  return buildProfile(nick, ntrp);
                }

                if (index == 1) {
                  return Padding(
                    padding: const EdgeInsets.only(right: 30.0),
                    child: Container(
                      color: const Color(0xff004e80),
                      width: double.infinity,
                      height: 80.0,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(left: 40.0),
                            child: Row(
                              children: <Widget>[
                                Container(
                                  width: 60,
                                  child: Text(
                                    'NTRP',
                                    style: TextStyle(
                                      letterSpacing: .1,
                                      color: Colors.white,
                                      fontSize: 18.0,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                      left: 30.0,
                                    ),
                                    child: Container(
                                      width: double.infinity,
                                      child: Text(
                                        ('$ntrp'),
                                        style: TextStyle(
                                          letterSpacing: .1,
                                          color: const Color(0xffd6d5d5),
                                          fontSize: 16.0,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(40.0, 6.0, 0, 0),
                            child: Row(
                              children: <Widget>[
                                Container(
                                  width: 60,
                                  child: Text(
                                    'STYLE',
                                    style: TextStyle(
                                      letterSpacing: 0.1,
                                      color: Colors.white,
                                      fontSize: 18.0,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 30.0),
                                    child: Container(
                                      width: double.infinity,
                                      child: Text(
                                        '$play_style',
                                        style: TextStyle(
                                          letterSpacing: .1,
                                          color: const Color(0xffd6d5d5),
                                          fontSize: 16.0,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }

                if (index == 2) {
                  return GestureDetector(
                    onTap: () {
                      if (isLoggedIn) {
                        Navigator.of(context)
                            .pushNamed(ProfileListScreen.routeName);
                      } else {
                        DialogPopUpWidget().needLoginDialogBox(context);
                      }
                      print("Container was tapped");
                    },
                    child: Column(
                      children: <Widget>[
                        SizedBox(
                          width: double.infinity,
                          height: 30,
                        ),
                        Container(
                          height: 55,
                          color: Colors.white,
                          child: ListTile(
                            title: Text(
                              '프로필 관리',
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            trailing: Icon(Icons.keyboard_arrow_right),
                          ),
                        ),
                        Divider(
                          height: .1,
                          color: Colors.black38,
                        )
                      ],
                    ),
                  );
                }
                if (index == 3) {
                  return GestureDetector(
                    onTap: () {
                      if (isLoggedIn) {
                        Navigator.of(context)
                            .pushNamed(UserRacketListScreen.routeName);
                      } else {
                        DialogPopUpWidget().needLoginDialogBox(context);
                      }
                      print("Container was tapped");
                    },
                    child: Column(
                      children: <Widget>[
                        Container(
                          height: 55,
                          color: Colors.white,
                          child: ListTile(
                            title: Text(
                              '라켓 관리',
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            trailing: Icon(Icons.keyboard_arrow_right),
                          ),
                        ),
                      ],
                    ),
                  );
                }

                if (index == 4) {
                  return Column(
                    children: <Widget>[
                      SizedBox(
                        width: double.infinity,
                        height: 20,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context)
                              .pushNamed(SettingListScreen.routeName);
                          print("Container was tapped");
                        },
                        child: Container(
                          height: 55,
                          alignment: Alignment.center,
                          color: Colors.white,
                          child: ListTile(
                            title: Text(
                              '설정',
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            trailing: Icon(Icons.keyboard_arrow_right),
                          ),
                        ),
                      ),
                    ],
                  );
                }
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
