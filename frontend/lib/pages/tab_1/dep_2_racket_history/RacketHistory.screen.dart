import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tennist_flutter/pages/tab_1/dep_2_racket_history/RacketHistory.model.dart';
import 'package:tennist_flutter/pages/tab_1/dep_2_racket_history/RacketHistory.provider.dart';
import 'package:tennist_flutter/pages/tab_1/dep_3_user_racket_history_detail/RacketHistoryDetail.screen.dart';

import 'package:tennist_flutter/pages/tab_3/manage_racket/detail_racket/dep_2_racket_history/UserRacketHistory.provider.dart';
import 'package:tennist_flutter/pages/tab_3/manage_racket/detail_racket/dep_3_racket_history_detail/UserRacketHistoryDetail.screen.dart';
import 'package:tennist_flutter/src/helper/ScreenPassData.dart';

class RacketHistoryScreen extends StatefulWidget {
  static const String routeName = '/RacketHistory';

  @override
  _RacketHistoryScreenState createState() => _RacketHistoryScreenState();
}

class _RacketHistoryScreenState extends State<RacketHistoryScreen>
    with AutomaticKeepAliveClientMixin {
  bool loading = false;
  bool isFirstLoading = true;
  int userRacketId;
  Future serverData;

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    ScreenPassData args = ModalRoute.of(context).settings.arguments;
    print(args.data['user_racket_id']);
    if (isFirstLoading) {
      serverData = RacketHistoryProvider().getData(args.data['user_racket_id']);
      isFirstLoading = false;
    }

    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(60.0),
          child: Container(
            alignment: FractionalOffset.centerRight,
            child: AppBar(
              automaticallyImplyLeading: true, //왼쪽 화살표 뒤로 없애기
              backgroundColor: const Color(0xff141414),
              title: Text(
                '라켓 히스토리 ',
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
        body: FutureBuilder<RacketHistoryModel>(
          future: serverData,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Column(
                // mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Stack(
                    alignment: Alignment.bottomLeft,
                    children: <Widget>[
                      Padding(
                        padding:
                            const EdgeInsets.fromLTRB(24.0, 18.0, 24.0, 30.0),
                        child: Container(
                          width: double.infinity,
                          color: Colors.white,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(4.0),
                                  color: const Color(0xff004d80),
                                ),
                                child: Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(8, 4, 8, 4),
                                  child: Text(
                                    "Main",
                                    style: TextStyle(
                                      fontSize: 16.0,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 12),
                              Text(
                                "${snapshot.data.result.data.racketInfo.racketNickname}",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 22,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              SizedBox(height: 1),
                              Text(
                                "${snapshot.data.result.data.racketInfo.racketVersionName} ${snapshot.data.result.data.racketInfo.model}",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              SizedBox(height: 2),
                              Text(
                                "${snapshot.data.result.data.racketInfo.weightUngut}g ${snapshot.data.result.data.racketInfo.mainPattern}x${snapshot.data.result.data.racketInfo.crossPattern}",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              SizedBox(height: 2),
                              Text(
                                "${snapshot.data.result.data.racketInfo.racketBalanceLbVal}pt ${snapshot.data.result.data.racketInfo.racketBalanceLbType}",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              SizedBox(height: 20),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        width: double.infinity,
                        height: 1,
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                  width: 1.0, color: const Color(0xffd5d5d5)),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        height: 30,
                        width: MediaQuery.of(context).size.width - 50,
                        color: Colors.black,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 20.0),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "History",
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Expanded(
                    child: (snapshot.data.result.data.list.length < 1)
                        ? Container(
                            child: new Center(
                              child: Container(
                                child: const Center(
                                  child: Text(
                                    "라켓 히스토리가 없습니다.",
                                  ),
                                ),
                              ),
                            ),
                          )
                        : ListView.builder(
                            shrinkWrap: true,
                            padding: const EdgeInsets.all(24.0),
                            itemCount: snapshot.data.result.data.list.length,
                            itemExtent: 175,
                            itemBuilder: (BuildContext context, int index) {
                              int idx =
                                  snapshot.data.result.data.list.length - index;
                              var updatedAt = DateFormat('yyyy.MM.dd').format(
                                  snapshot.data.result.data.list[idx - 1]
                                      .updatedDate);
                              return Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 10.0),
                                child: GestureDetector(
                                  onTap: () {
                                    Map<String, dynamic> passData = {
                                      "user_racket_history_id": snapshot
                                          .data.result.data.list[index].id,
                                    };

                                    Navigator.of(context).pushNamed(
                                        RacketHistoryDetailScreen.routeName,
                                        arguments: ScreenPassData(passData));
                                  },
                                  child: Row(
                                    children: <Widget>[
                                      SizedBox(
                                        width: 90,
                                        height: double.infinity,
                                        child: Container(
                                          color: const Color(0xff004d80),
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                top: 16.0),
                                            child: Column(
                                              children: <Widget>[
                                                Container(
                                                  padding: EdgeInsets.only(
                                                      left: 10.0),
                                                  width: double.infinity,
                                                  child: Text(
                                                    "$updatedAt",
                                                    textAlign: TextAlign.left,
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 13.0,
                                                    ),
                                                  ),
                                                ),
                                                Container(
                                                  padding: EdgeInsets.only(
                                                      right: 10.0),
                                                  width: double.infinity,
                                                  child: Text(
                                                    "$idx",
                                                    textAlign: TextAlign.right,
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 20.0,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 1,
                                        child: Container(
                                          // height: 100.0,
                                          color: Colors.transparent,
                                          child: new Container(
                                            decoration: new BoxDecoration(
                                              color: Colors.white,
                                              border: new Border.all(
                                                color: const Color(0xffe2e2e3),
                                              ),
                                              borderRadius:
                                                  new BorderRadius.only(
                                                topRight:
                                                    const Radius.circular(10.0),
                                                bottomRight:
                                                    const Radius.circular(10.0),
                                              ),
                                            ),
                                            child: Row(
                                              children: <Widget>[
                                                Expanded(
                                                  child: Container(
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 16.0),
                                                      child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: <Widget>[
                                                          RichText(
                                                            text: TextSpan(
                                                              text: 'weight: ',
                                                              style: TextStyle(
                                                                color: Colors
                                                                    .black,
                                                                fontSize: 16,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                              ),
                                                              children: <
                                                                  TextSpan>[
                                                                TextSpan(
                                                                    text:
                                                                        '${snapshot.data.result.data.list[idx - 1].weightTune}g',
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            14.0,
                                                                        color: Colors
                                                                            .black87,
                                                                        fontWeight:
                                                                            FontWeight.w400)),
                                                              ],
                                                            ),
                                                          ),
                                                          SizedBox(height: 2),
                                                          RichText(
                                                            text: TextSpan(
                                                              text: 'Balance: ',
                                                              style: TextStyle(
                                                                color: Colors
                                                                    .black,
                                                                fontSize: 16,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                              ),
                                                              children: <
                                                                  TextSpan>[
                                                                TextSpan(
                                                                    text:
                                                                        '${snapshot.data.result.data.list[idx - 1].racketBalanceVal}pt(${snapshot.data.result.data.list[idx - 1].racketBalanceType})',
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            14.0,
                                                                        color: Colors
                                                                            .black87,
                                                                        fontWeight:
                                                                            FontWeight.w400)),
                                                              ],
                                                            ),
                                                          ),
                                                          SizedBox(height: 2),
                                                          RichText(
                                                            text: TextSpan(
                                                              text: 'String: ',
                                                              style: TextStyle(
                                                                color: Colors
                                                                    .black,
                                                                fontSize: 16,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                              ),
                                                              children: <
                                                                  TextSpan>[
                                                                TextSpan(
                                                                    text:
                                                                        '${snapshot.data.result.data.list[idx - 1].gutName}',
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            14.0,
                                                                        color: Colors
                                                                            .black87,
                                                                        fontWeight:
                                                                            FontWeight.w400)),
                                                              ],
                                                            ),
                                                          ),
                                                          SizedBox(height: 2),
                                                          RichText(
                                                            text: TextSpan(
                                                              text: 'Tension: ',
                                                              style: TextStyle(
                                                                color: Colors
                                                                    .black,
                                                                fontSize: 16,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                              ),
                                                              children: <
                                                                  TextSpan>[
                                                                TextSpan(
                                                                    text:
                                                                        '${snapshot.data.result.data.list[idx - 1].mainGutLbTension}-${snapshot.data.result.data.list[idx - 1].crossGutLbTension}',
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            14.0,
                                                                        color: Colors
                                                                            .black87,
                                                                        fontWeight:
                                                                            FontWeight.w400)),
                                                              ],
                                                            ),
                                                          ),
                                                          SizedBox(height: 2),
                                                          RichText(
                                                            text: TextSpan(
                                                              text:
                                                                  'Essential grip: ',
                                                              style: TextStyle(
                                                                color: Colors
                                                                    .black,
                                                                fontSize: 16,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                              ),
                                                              children: <
                                                                  TextSpan>[
                                                                TextSpan(
                                                                    text:
                                                                        '${snapshot.data.result.data.list[idx - 1].replacementGripType}',
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            14.0,
                                                                        color: Colors
                                                                            .black87,
                                                                        fontWeight:
                                                                            FontWeight.w400)),
                                                              ],
                                                            ),
                                                          ),
                                                          SizedBox(height: 2),
                                                          RichText(
                                                            text: TextSpan(
                                                              text:
                                                                  'Over grip Count: ',
                                                              style: TextStyle(
                                                                color: Colors
                                                                    .black,
                                                                fontSize: 16,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                              ),
                                                              children: <
                                                                  TextSpan>[
                                                                TextSpan(
                                                                    text:
                                                                        '${snapshot.data.result.data.list[idx - 1].overgripNum}',
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            14.0,
                                                                        color: Colors
                                                                            .black87,
                                                                        fontWeight:
                                                                            FontWeight.w400)),
                                                              ],
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 50,
                                                  height: double.infinity,
                                                  child: Center(
                                                    child: Icon(
                                                      Icons
                                                          .keyboard_arrow_right,
                                                      size: 32.0,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                  ),
                ],
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
      ),
    );
  }
}
