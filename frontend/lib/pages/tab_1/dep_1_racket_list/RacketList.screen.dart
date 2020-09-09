import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:tennist_flutter/pages/tab_1/dep_1_racket_list/RacketList.model.dart';
import 'package:tennist_flutter/pages/tab_1/dep_1_racket_list/RacketList.provider.dart';
import 'package:tennist_flutter/pages/tab_1/dep_2_racket_history/RacketHistory.screen.dart';
import 'package:tennist_flutter/src/constants/Sex.dart';
import 'package:tennist_flutter/src/helper/ScreenPassData.dart';

class RacketListScreen extends StatefulWidget {
  static const String routeName = '/RacketList';

  @override
  _RacketListScreenState createState() => _RacketListScreenState();
}

class _RacketListScreenState extends State<RacketListScreen>
    with AutomaticKeepAliveClientMixin {
  bool loading = false;
  Future serverData;
  bool isFirstLoading = true;

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    ScreenPassData args = ModalRoute.of(context).settings.arguments;

    if (isFirstLoading) {
      serverData = RacketListProvider().getData(args.data['user_id']);
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
                '유저 라켓',
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
        body: FutureBuilder<RacketListModel>(
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
                            const EdgeInsets.fromLTRB(16.0, 18.0, 16.0, 50.0),
                        child: Container(
                          width: double.infinity,
                          child: Row(
                            children: <Widget>[
                              SizedBox(
                                width: 70,
                                // height: 100,
                                child: AspectRatio(
                                  aspectRatio: 1 / 1,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10.0),
                                      color: Colors.white,
                                      image: new DecorationImage(
                                        image: ExactAssetImage(
                                          'assets/images/profile_1.jpeg',
                                        ),
                                        fit: BoxFit.fitWidth,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(20, 8, 8, 8),
                                  child: Container(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text(
                                          '${snapshot.data.result.data.userData.nick} (NTRP ${snapshot.data.result.data.userData.ntrp})',
                                          style: TextStyle(
                                              fontSize: 20.0,
                                              fontWeight: FontWeight.w600),
                                        ),
                                        Text(
                                          '${Sex[snapshot.data.result.data.userData.sex]} ${snapshot.data.result.data.userData.age} - ${snapshot.data.result.data.userData.playStyle}\n${snapshot.data.result.data.userData.heightCm}cm ${snapshot.data.result.data.userData.weightKg}Kg ${snapshot.data.result.data.userData.handed}-handed\n${snapshot.data.result.data.userData.backhandStyle}-back',
                                          style: TextStyle(
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.w400,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              )
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
                              "Racket List",
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
                    child: ListView.builder(
                      shrinkWrap: true,
                      padding: const EdgeInsets.all(24.0),
                      itemCount: snapshot.data.result.data.list.length,
                      itemExtent: 90,
                      itemBuilder: (BuildContext context, int index) {
                        ListElement rowData =
                            snapshot.data.result.data.list[index];
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10.0),
                          child: GestureDetector(
                            onTap: () {
                              Map<String, dynamic> passData = {
                                "user_racket_id": rowData.userRacketId
                              };

                              Navigator.of(context).pushNamed(
                                  RacketHistoryScreen.routeName,
                                  arguments: ScreenPassData(passData));
                            },
                            child: Row(
                              children: <Widget>[
                                SizedBox(
                                  width: 55,
                                  height: double.infinity,
                                  child: Container(
                                    color: const Color(0xff004d80),
                                    child: Padding(
                                      padding: const EdgeInsets.only(top: 10.0),
                                      child: Column(
                                        children: <Widget>[
                                          Container(
                                            padding:
                                                EdgeInsets.only(left: 10.0),
                                            width: double.infinity,
                                            child: Text(
                                              (index == 0) ? "Main" : "Sub",
                                              textAlign: TextAlign.left,
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 14.0,
                                              ),
                                            ),
                                          ),
                                          Container(
                                            padding:
                                                EdgeInsets.only(right: 10.0),
                                            width: double.infinity,
                                            child: Text(
                                              "${++index}",
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
                                        borderRadius: new BorderRadius.only(
                                          topRight: const Radius.circular(10.0),
                                          bottomRight:
                                              const Radius.circular(10.0),
                                        ),
                                      ),
                                      child: Row(
                                        children: <Widget>[
                                          Expanded(
                                            child: Container(
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 16.0),
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: <Widget>[
                                                    Text(
                                                      "${rowData.racketCompanyName}",
                                                      style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                      ),
                                                    ),
                                                    SizedBox(height: 2),
                                                    Text(
                                                      "${rowData.racketVertion} ${rowData.racketModel}",
                                                      style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                      ),
                                                    ),
                                                    // SizedBox(height: 2),
                                                    // RichText(
                                                    //   text: TextSpan(
                                                    //     text: 'weight: ',
                                                    //     style: TextStyle(
                                                    //       color: Colors.black,
                                                    //       fontSize: 16,
                                                    //       fontWeight:
                                                    //           FontWeight.w500,
                                                    //     ),
                                                    //     children: <TextSpan>[
                                                    //       TextSpan(
                                                    //           text:
                                                    //               '${rowData.weightTune}g',
                                                    //           style: TextStyle(
                                                    //               fontSize:
                                                    //                   14.0,
                                                    //               color: Colors
                                                    //                   .black87,
                                                    //               fontWeight:
                                                    //                   FontWeight
                                                    //                       .w400)),
                                                    //     ],
                                                    //   ),
                                                    // ),
                                                    // SizedBox(height: 2),
                                                    // RichText(
                                                    //   text: TextSpan(
                                                    //     text: 'Balance: ',
                                                    //     style: TextStyle(
                                                    //       color: Colors.black,
                                                    //       fontSize: 16,
                                                    //       fontWeight:
                                                    //           FontWeight.w500,
                                                    //     ),
                                                    //     children: <TextSpan>[
                                                    //       TextSpan(
                                                    //           text: '21pt(HH)',
                                                    //           style: TextStyle(
                                                    //               fontSize:
                                                    //                   14.0,
                                                    //               color: Colors
                                                    //                   .black87,
                                                    //               fontWeight:
                                                    //                   FontWeight
                                                    //                       .w400)),
                                                    //     ],
                                                    //   ),
                                                    // ),
                                                    // SizedBox(height: 2),
                                                    // RichText(
                                                    //   text: TextSpan(
                                                    //     text: 'String: ',
                                                    //     style: TextStyle(
                                                    //       color: Colors.black,
                                                    //       fontSize: 16,
                                                    //       fontWeight:
                                                    //           FontWeight.w500,
                                                    //     ),
                                                    //     children: <TextSpan>[
                                                    //       TextSpan(
                                                    //           text:
                                                    //               'erewrewrtewr',
                                                    //           style: TextStyle(
                                                    //               fontSize:
                                                    //                   14.0,
                                                    //               color: Colors
                                                    //                   .black87,
                                                    //               fontWeight:
                                                    //                   FontWeight
                                                    //                       .w400)),
                                                    //     ],
                                                    //   ),
                                                    // ),
                                                    // SizedBox(height: 2),
                                                    // RichText(
                                                    //   text: TextSpan(
                                                    //     text: 'Tension: ',
                                                    //     style: TextStyle(
                                                    //       color: Colors.black,
                                                    //       fontSize: 16,
                                                    //       fontWeight:
                                                    //           FontWeight.w500,
                                                    //     ),
                                                    //     children: <TextSpan>[
                                                    //       TextSpan(
                                                    //           text: '45-45',
                                                    //           style: TextStyle(
                                                    //               fontSize:
                                                    //                   14.0,
                                                    //               color: Colors
                                                    //                   .black87,
                                                    //               fontWeight:
                                                    //                   FontWeight
                                                    //                       .w400)),
                                                    //     ],
                                                    //   ),
                                                    // ),
                                                    // SizedBox(height: 2),
                                                    // RichText(
                                                    //   text: TextSpan(
                                                    //     text:
                                                    //         'Essential grip: ',
                                                    //     style: TextStyle(
                                                    //       color: Colors.black,
                                                    //       fontSize: 16,
                                                    //       fontWeight:
                                                    //           FontWeight.w500,
                                                    //     ),
                                                    //     children: <TextSpan>[
                                                    //       TextSpan(
                                                    //           text: 'leather',
                                                    //           style: TextStyle(
                                                    //               fontSize:
                                                    //                   14.0,
                                                    //               color: Colors
                                                    //                   .black87,
                                                    //               fontWeight:
                                                    //                   FontWeight
                                                    //                       .w400)),
                                                    //     ],
                                                    //   ),
                                                    // ),
                                                    // SizedBox(height: 2),
                                                    // RichText(
                                                    //   text: TextSpan(
                                                    //     text:
                                                    //         'Over grip Count: ',
                                                    //     style: TextStyle(
                                                    //       color: Colors.black,
                                                    //       fontSize: 16,
                                                    //       fontWeight:
                                                    //           FontWeight.w500,
                                                    //     ),
                                                    //     children: <TextSpan>[
                                                    //       TextSpan(
                                                    //           text: '4',
                                                    //           style: TextStyle(
                                                    //               fontSize:
                                                    //                   14.0,
                                                    //               color: Colors
                                                    //                   .black87,
                                                    //               fontWeight:
                                                    //                   FontWeight
                                                    //                       .w400)),
                                                    //     ],
                                                    //   ),
                                                    // ),
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
                                                Icons.keyboard_arrow_right,
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
