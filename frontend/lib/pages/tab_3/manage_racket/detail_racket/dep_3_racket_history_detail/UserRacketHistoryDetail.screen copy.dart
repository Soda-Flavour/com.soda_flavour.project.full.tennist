import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tennist/pages/tab_3/manage_racket/detail_racket/dep_3_racket_history_detail/UserRacketHistoryDetail.model.dart';
import 'package:tennist/pages/tab_3/manage_racket/detail_racket/dep_3_racket_history_detail/UserRacketHistoryDetail.provider.dart';
import 'package:tennist/src/helper/ScreenPassData.dart';

class UserRacketHistoryDetailScreen extends StatefulWidget {
  static const String routeName = '/UserRacketHistoryDetail';

  @override
  _RacketHistoryDetailScreenState createState() =>
      _RacketHistoryDetailScreenState();
}

class _RacketHistoryDetailScreenState
    extends State<UserRacketHistoryDetailScreen>
    with AutomaticKeepAliveClientMixin {
  bool loading = false;
  TextEditingController textController = TextEditingController();
  int userRacketHistoryId;
  bool isFirstLoading = true;
  Future<UserRacketHistoryDetailModel> serverData;

  @override
  bool get wantKeepAlive => true;

  void addItemToList() {
    // UserRacketHistoryDetailProvider()
    //     .sendComment(userRacketHistoryId, textController.text);

    // setState(() {
    //   serverData.asStream().;
    //   msgCount.insert(0, 0);
    // });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    print(" vjasdvadsvs");
    ScreenPassData args = ModalRoute.of(context).settings.arguments;
    print("ㅇ류류류");
    if (isFirstLoading) {
      print("로딩작업");
      userRacketHistoryId = args.data['user_racket_history_id'];
      serverData =
          UserRacketHistoryDetailProvider().getData(userRacketHistoryId);
      isFirstLoading = false;
    }

    double DeviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60.0),
        child: Container(
          alignment: FractionalOffset.centerRight,
          child: AppBar(
            automaticallyImplyLeading: true, //왼쪽 화살표 뒤로 없애기
            backgroundColor: const Color(0xff141414),
            title: Text(
              '라켓 상세 히스토리',
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
      body: FutureBuilder<UserRacketHistoryDetailModel>(
          future: serverData,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return GestureDetector(
                onTap: () => FocusScope.of(context).unfocus(),
                child: SingleChildScrollView(
                  physics: ClampingScrollPhysics(),
                  child: Container(
                    height: MediaQuery.of(context).size.height -
                        AppBar().preferredSize.height -
                        48,
                    child: Column(
                      // mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Stack(
                          alignment: Alignment.bottomLeft,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.fromLTRB(
                                  24.0, 18.0, 24.0, 60.0),
                              child: Container(
                                width: double.infinity,
                                color: Colors.white,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Center(
                                      child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(4.0),
                                          color: const Color(0xff004d80),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              8, 4, 8, 4),
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
                                    ),
                                    SizedBox(height: 8),
                                    Center(
                                      child: Text(
                                        "${snapshot.data.result.data.racketData.racketVertion} ${snapshot.data.result.data.racketData.racketModel}",
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 20,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 10),
                                    Center(
                                      child: Container(
                                        color: Colors.black,
                                        width:
                                            DeviceWidth - (DeviceWidth * 0.92),
                                        height: 2,
                                      ),
                                    ),
                                    SizedBox(height: 10),
                                    Column(
                                      children: <Widget>[
                                        Row(
                                          // mainAxisAlignment:
                                          //     MainAxisAlignment.spaceEvenly,
                                          mainAxisSize: MainAxisSize.max,
                                          children: <Widget>[
                                            Expanded(
                                              child: Column(
                                                children: <Widget>[
                                                  Text("Weight"),
                                                  SizedBox(height: 3.0),
                                                  Text(
                                                    "${snapshot.data.result.data.racketData.weightTune}g",
                                                    style: TextStyle(
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontSize: 20.0,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Expanded(
                                              child: Column(
                                                children: <Widget>[
                                                  Text("Balance"),
                                                  SizedBox(height: 3.0),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment.end,
                                                    children: <Widget>[
                                                      Text(
                                                        "${snapshot.data.result.data.racketData.racketBalanceVal}pt",
                                                        style: TextStyle(
                                                          color: Colors.black,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          fontSize: 20.0,
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(
                                                          bottom: 2,
                                                        ),
                                                        child: Text(
                                                          "(${snapshot.data.result.data.racketData.racketBalanceType})",
                                                          style: TextStyle(
                                                            color: Colors.black,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            fontSize: 12.0,
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  )
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                        SizedBox(height: 12.0),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          mainAxisSize: MainAxisSize.max,
                                          children: <Widget>[
                                            Expanded(
                                              child: Column(
                                                children: <Widget>[
                                                  Text("String"),
                                                  SizedBox(height: 5.0),
                                                  Text(
                                                    "${snapshot.data.result.data.racketData.gutName}",
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                      color: Colors.black,
                                                      height: 1,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontSize: 18.0,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Expanded(
                                              child: Column(
                                                children: <Widget>[
                                                  Text("Tension"),
                                                  SizedBox(height: 5.0),
                                                  Text(
                                                    "${snapshot.data.result.data.racketData.mainGutLbTension}-${snapshot.data.result.data.racketData.crossGutLbTension}",
                                                    style: TextStyle(
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontSize: 20.0,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 12.0),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: <Widget>[
                                            Expanded(
                                              child: Column(
                                                children: <Widget>[
                                                  Text("Essential grip"),
                                                  SizedBox(height: 3.0),
                                                  Text(
                                                    "${snapshot.data.result.data.racketData.replacementGripType}",
                                                    style: TextStyle(
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontSize: 20.0,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Expanded(
                                              child: Column(
                                                children: <Widget>[
                                                  Text("Over grip count"),
                                                  SizedBox(height: 3.0),
                                                  Text(
                                                    "${snapshot.data.result.data.racketData.overgripNum}",
                                                    style: TextStyle(
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontSize: 20.0,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
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
                                        width: 1.0,
                                        color: const Color(0xffd5d5d5)),
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
                                    "Comment",
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
                                          "라켓 코멘트가 없습니다.",
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                              : ListView.builder(
                                  shrinkWrap: true,
                                  padding: const EdgeInsets.all(0.0),
                                  reverse: true,
                                  itemCount:
                                      snapshot.data.result.data.list.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    var updatedAt = DateFormat('yyyy.MM.dd')
                                        .format(snapshot.data.result.data
                                            .list[index].updatedDate);
                                    return Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 5.0),
                                      child: GestureDetector(
                                          onTap: () {},
                                          child: ConstrainedBox(
                                            constraints:
                                                BoxConstraints(minHeight: 80.0),
                                            child: Container(
                                              color: Colors.white,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                        20, 20, 20, 10),
                                                child: Column(
                                                  children: <Widget>[
                                                    Text(
                                                      "${snapshot.data.result.data.list[index].comment}",
                                                      style: TextStyle(
                                                          fontSize: 18,
                                                          height: 1,
                                                          fontWeight:
                                                              FontWeight.w500),
                                                    ),
                                                    SizedBox(
                                                      height: 15,
                                                    ),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment.end,
                                                      children: <Widget>[
                                                        CircleAvatar(
                                                          radius: 10,
                                                          backgroundImage:
                                                              AssetImage(
                                                                  'assets/images/profile_1.jpeg'),
                                                        ),
                                                        SizedBox(
                                                          width: 5.0,
                                                        ),
                                                        Text(
                                                            "${snapshot.data.result.data.list[index].nick}"),
                                                        Icon(
                                                          Icons.star,
                                                          color: const Color(
                                                              0xff0076BA),
                                                          size: 15.0,
                                                        ),
                                                        SizedBox(
                                                          width: 5.0,
                                                        ),
                                                        Text("$updatedAt")
                                                      ],
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                          )),
                                    );
                                  },
                                ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 12.0),
                          height: 70.0,
                          color: Colors.white,
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                child: TextField(
                                  controller: textController,
                                  decoration: InputDecoration(
                                    contentPadding:
                                        EdgeInsets.symmetric(horizontal: 12.0),
                                    border: new OutlineInputBorder(
                                      borderRadius: const BorderRadius.all(
                                        const Radius.circular(15.0),
                                      ),
                                    ),
                                    hintText: '코멘트를 작성해주세요.',
                                  ),
                                ),
                              ),
                              IconButton(
                                icon: Icon(Icons.send),
                                iconSize: 25.0,
                                color: Theme.of(context).primaryColor,
                                onPressed: () {
                                  //                               setState(() {
                                  //   serverData.asStream().;
                                  //   msgCount.insert(0, 0);
                                  // });

                                  addItemToList();
                                },
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
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
          }),
    );
  }
}
