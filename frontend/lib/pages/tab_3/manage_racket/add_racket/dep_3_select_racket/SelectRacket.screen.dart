import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tennist_flutter/pages/tab_3/manage_racket/UserRacketList.screen.dart';
import 'package:tennist_flutter/src/widget/BasicListRow.dart';

class SelectRacketScreen extends StatefulWidget {
  static const String routeName = '/SelectRacket';

  @override
  _SelectRacketScreenState createState() => _SelectRacketScreenState();
}

class _SelectRacketScreenState extends State<SelectRacketScreen>
    with AutomaticKeepAliveClientMixin {
  bool loading = false;
  final List<String> racket = <String>['PRO', 'MP', 'TEAM'];

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
              '라캣 모델 선택',
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
              itemCount: racket.length,
              itemBuilder: (BuildContext context, int index) {
                return BasicListRow(
                  rowText: racket[index],
                  onTap: () {
                    showDialog(
                      context: context,
                      barrierDismissible: false, // user must tap button!
                      builder: (BuildContext context) {
                        return CupertinoAlertDialog(
                          title: Text("라켓추가"),
                          content: Text("나의 라켓에 ${racket[index]} 모델을 추가할까요?"),
                          actions: [
                            CupertinoDialogAction(
                              child: Text("네"),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                            CupertinoDialogAction(
                              child: Text("아니오"),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                          ],
                        );
                      },
                    );
                  },
                );
              },
            ),
    );
  }
}
