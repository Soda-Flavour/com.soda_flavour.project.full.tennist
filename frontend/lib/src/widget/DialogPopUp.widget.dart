import 'package:flutter/material.dart';
import 'package:tennist/pages/account/login/LogIn.screen.dart';

class DialogPopUpWidget {
  void errorDialogBox(BuildContext context, String msg) {
    // flutter defined fZunction
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("확인해주세요!"),
          content: new Text(msg),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("확인"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void successDialogBox(BuildContext context, String msg, Function onPress) {
    // flutter defined fZunction
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("완료"),
          content: new Text(msg),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("확인"),
              onPressed: () {
                onPress();
                // Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void needLoginDialogBox(BuildContext context) {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("함께해요!"),
          content: new Text("회원가입 또는 로그인 후\n 이용할 수 있습니다."),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("취소"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            new FlatButton(
              child: new Text("로그인/회원가입"),
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).pushNamed(LogInScreen.routeName);
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
