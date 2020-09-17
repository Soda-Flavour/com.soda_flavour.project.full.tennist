import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:tennist/pages/BottomNaviController.dart';
import 'package:tennist/src/helper/ApiReciver.dart';
import 'package:tennist/src/helper/AuthHelper.dart';
import 'package:tennist/src/widget/BasicListRow.dart';

class SettingListScreen extends StatefulWidget {
  static const String routeName = '/SettingList';

  @override
  _SettingListScreen createState() => _SettingListScreen();
}

class _SettingListScreen extends State<SettingListScreen> {
  final storage = new FlutterSecureStorage();
  final isLogin = false;

  @override
  void initState() {
    super.initState();
    //TODO: 해당 응답이 3040번 에러이면 로그인이 안되어 있는 것이다. ==> 로그인 페이지 로딩
    // ApiReciver.POST(
    //     'https://water-flavour.com/api/v1/auth/checkAccessToken', null, true);
  }

  logout() async {
    await AuthHelper.deleteAllToken();
    Navigator.of(context).pushNamedAndRemoveUntil(
      BottomNaviController.routeName,
      (route) => false,
    );
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
                  '설정',
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    letterSpacing: 0.07,
                    color: Colors.white,
                    fontSize: 18.0,
                  ),
                ),
                centerTitle: true,
              ))),
      body: ListView.builder(
        shrinkWrap: true,
        itemCount: 6,
        itemBuilder: (BuildContext context, int index) {
          // final item = snapshot.data[index];

          if (index == 0) {
            return Column(
              children: <Widget>[
                SizedBox(
                  width: double.infinity,
                  height: 30,
                ),
                BasicListRow(
                  rowText: '이용약관',
                  onTap: () {
                    showDialog(
                      context: context,
                      barrierDismissible: false, // user must tap button!
                      builder: (BuildContext context) {
                        return CupertinoAlertDialog(
                          title: Text("준비중"),
                          content: Text("준비하고 있어요..!!!"),
                          actions: [
                            CupertinoDialogAction(
                              child: Text("확인"),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                          ],
                        );
                      },
                    );
                  },
                ),
                Divider(
                  height: .1,
                  color: Colors.black38,
                )
              ],
            );
          }
          if (index == 1) {
            return Column(
              children: <Widget>[
                BasicListRow(
                  rowText: '개인정보처리방침',
                  onTap: () {
                    showDialog(
                      context: context,
                      barrierDismissible: false, // user must tap button!
                      builder: (BuildContext context) {
                        return CupertinoAlertDialog(
                          title: Text("준비중"),
                          content: Text("준비하고 있어요..!!!"),
                          actions: [
                            CupertinoDialogAction(
                              child: Text("확인"),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                          ],
                        );
                      },
                    );
                  },
                ),
                Divider(
                  height: .1,
                  color: Colors.black38,
                )
              ],
            );
          }

          if (index == 2) {
            return Column(
              children: <Widget>[
                BasicListRow(
                  rowText: '언어',
                  onTap: () {
                    showDialog(
                      context: context,
                      barrierDismissible: false, // user must tap button!
                      builder: (BuildContext context) {
                        return CupertinoAlertDialog(
                          title: Text("준비중"),
                          content: Text("준비하고 있어요..!!!"),
                          actions: [
                            CupertinoDialogAction(
                              child: Text("확인"),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                          ],
                        );
                      },
                    );
                  },
                ),
              ],
            );
          }

          if (index == 3) {
            return Card(
              color: const Color(0xff004e80),
              child: Padding(
                padding: EdgeInsets.all(0),
                child: ListTile(
                  title: new Center(
                    child: Text(
                      "로그아웃",
                      style: TextStyle(
                          fontWeight: FontWeight.w400,
                          color: Colors.white,
                          fontSize: 16.0),
                    ),
                  ),
                  onTap: () {
                    showDialog(
                      context: context,
                      barrierDismissible: false, // user must tap button!
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text(
                            "로그아웃",
                            style: TextStyle(
                              color: const Color(0xff444444),
                              fontSize: 16.0,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          content: Text(
                            "로그아웃 하시겠나요?",
                            style: TextStyle(
                              color: const Color(0xff444444),
                              fontSize: 16.0,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          actions: <Widget>[
                            FlatButton(
                              child: new Text(
                                "아니요",
                                style: TextStyle(
                                  color: const Color(0xffFF4E72),
                                  fontSize: 15.0,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                            FlatButton(
                              child: new Text(
                                "네",
                                style: TextStyle(
                                  color: const Color(0xffFF4E72),
                                  fontSize: 15.0,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              onPressed: () {
                                logout();
                              },
                            ),
                          ],
                        );
                      },
                    );
                  },
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
