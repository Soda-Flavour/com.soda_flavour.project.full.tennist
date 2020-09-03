import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tennist_flutter/pages/tab_3/manage_racket/UserRacketList.screen.dart';
import 'package:tennist_flutter/pages/tab_3/manage_racket/add_racket/dep_3_select_racket_model/SelectRacketModel.model.dart';
import 'package:tennist_flutter/pages/tab_3/manage_racket/add_racket/dep_3_select_racket_model/SelectRacketModel.provider.dart';
import 'package:tennist_flutter/src/helper/ScreenPassData.dart';
import 'package:tennist_flutter/src/provider/LoadingProvider.dart';
import 'package:tennist_flutter/src/widget/BasicListRow.dart';
import 'package:tennist_flutter/src/widget/DialogPopUp.widget.dart';

class SelectRacketModelScreen extends StatelessWidget {
  static const String routeName = '/SelectRacketModel';

  bool loading = false;
  bool isFirstLoading = true;
  Future serverData;
  final List<String> racket = <String>['PRO', 'MP', 'TEAM'];

  @override
  Widget build(BuildContext context) {
    final loadingProv = Provider.of<LoadingProvider>(context, listen: false);
    final ScreenPassData args = ModalRoute.of(context).settings.arguments;

    if (isFirstLoading) {
      serverData = SelectRacketModelProvider().getData(args.data['id']);
      isFirstLoading = false;
    }

    return Stack(
      fit: StackFit.expand,
      children: <Widget>[
        Scaffold(
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
          body: FutureBuilder<SelectRacketModelModel>(
            future: serverData,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                if (snapshot.data.result.data.list.length < 1) {
                  return Container(
                    child: new Center(
                      child: Container(
                        child: const Center(
                          child: Text(
                            "라켓 모델이 없습니다.",
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
                        rowText:
                            "${args.data['versionName']} ${snapshot.data.result.data.list[index].model}",
                        onTap: () {
                          showDialog(
                            context: context,
                            barrierDismissible: false, // user must tap button!
                            builder: (BuildContext context) {
                              return CupertinoAlertDialog(
                                title: Text("라켓추가"),
                                content: Text(
                                    "나의 라켓에 ${snapshot.data.result.data.list[index].model} 모델을 추가할까요?"),
                                actions: [
                                  CupertinoDialogAction(
                                    child: Text("네"),
                                    onPressed: () async {
                                      loadingProv.setIsLoading();
                                      dynamic result =
                                          await SelectRacketModelProvider()
                                              .insertModel(snapshot.data.result
                                                  .data.list[index].id);

                                      loadingProv.setEndLoading();
                                      if (result.status == 200) {
                                        Navigator.of(context).pop();
                                        return DialogPopUpWidget()
                                            .successDialogBox(
                                          context,
                                          result.message,
                                          () => Navigator.of(context).pop(),
                                          // Navigator.popUntil(
                                          //     context, ModalRoute.withName(LogInScreen.routeName)),
                                        );
                                      } else {
                                        Navigator.of(context).pop();
                                        return DialogPopUpWidget()
                                            .errorDialogBox(
                                                context, result.message);
                                      }
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
        )
      ],
    );
  }
}
