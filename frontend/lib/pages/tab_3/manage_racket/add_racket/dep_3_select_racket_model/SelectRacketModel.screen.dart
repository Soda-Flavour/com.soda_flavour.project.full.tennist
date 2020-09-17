import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:tennist/pages/tab_3/manage_racket/add_racket/dep_3_select_racket_model/SelectRacketModel.model.dart';
import 'package:tennist/pages/tab_3/manage_racket/add_racket/dep_3_select_racket_model/SelectRacketModel.provider.dart';
import 'package:tennist/pages/tab_3/manage_racket/add_racket/dep_4_set_racket_nickname/SetRacketNickname.screen.dart';
import 'package:tennist/pages/tab_3/manage_racket/detail_racket/dep_1_racket_list/UserRacketList.screen.dart';
import 'package:tennist/src/helper/PopWithResults.dart';
import 'package:tennist/src/helper/ScreenPassData.dart';
import 'package:tennist/src/provider/LoadingProvider.dart';
import 'package:tennist/src/widget/BasicListRow.dart';
import 'package:tennist/src/widget/DialogPopUp.widget.dart';

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
                          Map<String, dynamic> passData = {
                            "id": snapshot.data.result.data.list[index].id,
                            "racketName":
                                "${args.data['versionName']} ${snapshot.data.result.data.list[index].model}",
                          };
                          Navigator.of(context)
                              .pushNamed(
                            SelectRacketNickNameScreen.routeName,
                            arguments: ScreenPassData(passData),
                          )
                              .then((results) {
                            if (results is PopWithResults) {
                              PopWithResults popResult = results;
                              if (popResult.toPage ==
                                  SelectRacketModelScreen.routeName) {
                                // TODO do stuff
                              } else {
                                Navigator.of(context).pop(results);
                              }
                            }
                          });

                          // Navigator.of(context).pushNamed(
                          //   SelectRacketNickNameScreen.routeName,
                          //   arguments: ScreenPassData(passData),
                          // );
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
