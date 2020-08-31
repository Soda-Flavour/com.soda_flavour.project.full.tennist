import 'dart:ffi';

import 'package:flutter/material.dart';

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
          preferredSize: Size.fromHeight(50.0),
          child: Container(
            alignment: FractionalOffset.centerRight,
            child: AppBar(
              elevation: 0.0,
              automaticallyImplyLeading: false, //왼쪽 화살표 뒤로 없애기
              backgroundColor: const Color(0xffffffff),

              actions: <Widget>[
                new IconButton(
                  icon: new Icon(
                    Icons.close,
                    color: Colors.black,
                  ),
                  onPressed: () => Navigator.of(context).pop(null),
                ),
              ],
            ),
          ),
        ),
        body: loading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Stack(
                    alignment: Alignment.bottomLeft,
                    children: <Widget>[
                      Container(
                        height: 140,
                        color: Colors.white,
                        child: ListTile(
                          // onTap: () => {
                          //   Navigator.of(context)
                          //       .pushNamed(RacketListScreen.routeName)
                          // },
                          leading: AspectRatio(
                            aspectRatio: 1 / 1,
                            child: Container(
                              height: 60.0,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12.0),
                                color: Colors.white,
                                image: new DecorationImage(
                                  image: ExactAssetImage(
                                      'assets/images/profile_1.jpeg'),
                                  fit: BoxFit.fitHeight,
                                ),
                              ),
                            ),
                          ),
                          title: Text(
                            '소다맛환타',
                            style: TextStyle(
                                fontSize: 20.0, fontWeight: FontWeight.w600),
                          ),
                          subtitle: Text(
                            'Female 31 - baseLine Player\n188cm 93Kg Right-handed\nOne-hand Back',
                            style: TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.w400,
                              color: Colors.black,
                            ),
                          ),
                          // trailing: Icon(Icons.keyboard_arrow_right),
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
                  ListView.builder(
                    shrinkWrap: true,
                    padding: const EdgeInsets.all(24.0),
                    itemCount: entries.length,
                    itemExtent: 170,
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10.0),
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
                                        padding: EdgeInsets.only(left: 10.0),
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
                                        padding: EdgeInsets.only(right: 10.0),
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
                                      color: Colors.green,
                                      borderRadius: new BorderRadius.only(
                                        topRight: const Radius.circular(10.0),
                                        bottomRight:
                                            const Radius.circular(10.0),
                                      ),
                                    ),
                                    child: new Center(
                                      child: new Text("Hi modal sheet"),
                                    )),
                              ),
                              // child: Container(
                              //   color: Colors.transparent,
                              //   decoration: new BoxDecoration(
                              //     color: Colors.green,
                              //     borderRadius: new BorderRadius.only(
                              //       topRight: const Radius.circular(40.0),
                              //       bottomRight: const Radius.circular(40.0),
                              //     ),
                              //   ),
                              //   height: double.infinity,
                              //   child: Column(
                              //     children: <Widget>[
                              //       Text("Graphene 360+ Gravity Pro ")
                              //     ],
                              //   ),
                              // ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ],
              ),
      ),
    );
  }
}
