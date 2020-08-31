import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:tennist_flutter/pages/tab_1/dep_2_racket_history/RacketHistory.screen.dart';

class RacketListScreen extends StatefulWidget {
  static const String routeName = '/RacketList';

  @override
  _RacketListScreenState createState() => _RacketListScreenState();
}

class _RacketListScreenState extends State<RacketListScreen>
    with AutomaticKeepAliveClientMixin {
  bool loading = false;
  final List<String> entries = <String>[
    '소다맛환타',
    '콜라',
    'axa8380',
    '소다맛환타',
    '콜라',
    'axa8380'
  ];
  final List<String> racket = <String>[
    'Graphene 360+ Gravity Pro',
    'Graphene 360+ speed MP',
    'Blade V7 (18x20)',
    'Graphene 360+ Gravity Pro',
    'Graphene 360+ speed MP',
    'Blade V7 (18x20)'
  ];
  final List<String> tension = <String>['54-54', '50-48', '48-46'];
  final List<int> colorCodes = <int>[600, 500, 100];

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
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
        body: loading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Column(
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
                                        borderRadius:
                                            BorderRadius.circular(10.0),
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
                                            '소다맛환타 (NTRP 2.5)',
                                            style: TextStyle(
                                                fontSize: 20.0,
                                                fontWeight: FontWeight.w600),
                                          ),
                                          Text(
                                            'Female 31 - baseLine Player\n188cm 93Kg Right-handed\nOne-hand Back',
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
                            )
                            // child: ListTile(
                            //   // onTap: () => {
                            //   //   Navigator.of(context)
                            //   //       .pushNamed(RacketListScreen.routeName)
                            //   // },
                            //   leading: AspectRatio(
                            //     aspectRatio: 1 / 1,
                            //     child: Container(
                            //       decoration: BoxDecoration(
                            //         borderRadius: BorderRadius.circular(10.0),
                            //         color: Colors.white,
                            //         image: new DecorationImage(
                            //           image: ExactAssetImage(
                            //             'assets/images/profile_1.jpeg',
                            //           ),
                            //           fit: BoxFit.fitWidth,
                            //         ),
                            //       ),
                            //     ),
                            //   ),
                            //   title: Text(
                            //     '소다맛환타 (NTRP 2.5)',
                            //     style: TextStyle(
                            //         fontSize: 20.0, fontWeight: FontWeight.w600),
                            //   ),
                            //   subtitle: Text(
                            //     'Female 31 - baseLine Player\n188cm 93Kg Right-handed\nOne-hand Back',
                            //     style: TextStyle(
                            //       fontSize: 16.0,
                            //       fontWeight: FontWeight.w400,
                            //       color: Colors.black,
                            //     ),
                            //   ),
                            //   // trailing: Icon(Icons.keyboard_arrow_right),
                            // ),
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
                      itemCount: entries.length,
                      itemExtent: 170,
                      itemBuilder: (BuildContext context, int index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10.0),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.of(context)
                                  .pushNamed(RacketHistoryScreen.routeName);
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
                                                      "Graphene 360+ Gravity Pro",
                                                      style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                      ),
                                                    ),
                                                    SizedBox(height: 2),
                                                    Text(
                                                      "Balance: 7pt(HL)",
                                                      style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                      ),
                                                    ),
                                                    SizedBox(height: 2),
                                                    Text(
                                                      "String : 얄루파워 125",
                                                      style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                      ),
                                                    ),
                                                    SizedBox(height: 2),
                                                    Text(
                                                      "Tension: 54-54",
                                                      style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                      ),
                                                    ),
                                                    SizedBox(height: 2),
                                                    Text(
                                                      "Essential grip: leather",
                                                      style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                      ),
                                                    ),
                                                    SizedBox(height: 2),
                                                    Text(
                                                      "Over grip Count: 2",
                                                      style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.w500,
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
              ),
      ),
    );
  }
}
