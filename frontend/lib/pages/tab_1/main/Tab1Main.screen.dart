import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:tennist_flutter/pages/tab_1/dep_1_racket_list/RacketList.screen.dart';

class Tab1MainScreen extends StatefulWidget {
  static const String routeName = '/Tab1Main';

  @override
  _Tab1MainScreenState createState() => _Tab1MainScreenState();
}

class _Tab1MainScreenState extends State<Tab1MainScreen>
    with AutomaticKeepAliveClientMixin {
  bool loading = false;
  final List<String> entries = <String>['소다맛환타', '콜라', 'axa8380'];
  final List<String> racket = <String>[
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
    return Scaffold(
      // appBar: AppBar(
      //   title: Image.asset(
      //     'assets/images/tennist_logo.png',
      //     scale: 2.2,
      //   ),
      //   backgroundColor: const Color(0xff141414), //앱바 색상
      //   elevation: 0.0, //앱바의 떠있는 효과(그림자) 0.0 은 앱바 그림자 지워줌
      // ),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50),
        child: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            Container(
              color: const Color(0xff141414),
            ),
            Center(
              child: Container(
                margin: EdgeInsets.only(top: 30.0),
                decoration: BoxDecoration(
                  image: new DecorationImage(
                    image: ExactAssetImage(
                      'assets/images/tennist_logo.png',
                      scale: 2.5,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      body: loading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(8),
              itemCount: entries.length,
              itemExtent: 92,
              itemBuilder: (BuildContext context, int index) {
                // return Container(
                //   height: 100,
                //   color: Colors.amber[colorCodes[index]],
                //   child: Center(child: Text('Entry ${entries[index]}')),
                // );

                return Column(
                  children: <Widget>[
                    ListTile(
                      onTap: () => {
                        Navigator.of(context)
                            .pushNamed(RacketListScreen.routeName)
                      },
                      leading: AspectRatio(
                        aspectRatio: 1 / 1,
                        child: Container(
                          height: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(7.0),
                            color: Colors.white,
                            image: new DecorationImage(
                              image: ExactAssetImage(
                                  'assets/images/profile_1.jpeg'),
                              fit: BoxFit.fitHeight,
                            ),
                          ),
                        ),
                      ),
                      // leading: CircleAvatar(
                      //   radius: 25.0,
                      //   backgroundImage:
                      //       new AssetImage('assets/images/profile_1.jpeg'),
                      //   backgroundColor: Colors.white,
                      // ),
                      title: Text(
                        '${entries[index]}',
                        style: TextStyle(
                            fontSize: 20.0, fontWeight: FontWeight.w600),
                      ),
                      subtitle: Text(
                        '${racket[index]} \n(tension: ${tension[index]})',
                        style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.w400,
                          color: Colors.black,
                        ),
                      ),
                      trailing: Icon(Icons.keyboard_arrow_right),
                    ),
                    Divider(
                      color: Colors.black38,
                    )
                  ],
                );
              }),
    );
  }
}
