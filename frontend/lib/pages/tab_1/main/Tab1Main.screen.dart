import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tennist/pages/tab_1/dep_1_racket_list/RacketList.screen.dart';
import 'package:tennist/pages/tab_1/main/Tab1Main.model.dart';
import 'package:tennist/pages/tab_1/main/Tab1Main.provider.dart';
import 'package:tennist/src/helper/ScreenPassData.dart';

class Tab1MainScreen extends StatefulWidget {
  static const String routeName = '/Tab1Main';

  @override
  _Tab1MainScreenState createState() => _Tab1MainScreenState();
}

class _Tab1MainScreenState extends State<Tab1MainScreen>
    with AutomaticKeepAliveClientMixin {
  bool loading = false;

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
      body: FutureBuilder<Tab1MainModel>(
        future: Tab1MainProvider().getData(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              padding: const EdgeInsets.all(8),
              itemCount: snapshot.data.result.data.list.length,
              itemExtent: 92,
              itemBuilder: (BuildContext context, int index) {
                return Column(
                  children: <Widget>[
                    ListTile(
                      onTap: () {
                        Map<String, dynamic> passData = {
                          "user_id":
                              snapshot.data.result.data.list[index].userId
                        };

                        Navigator.of(context).pushNamed(
                            RacketListScreen.routeName,
                            arguments: ScreenPassData(passData));
                      },
                      leading: AspectRatio(
                        aspectRatio: 1 / 1,
                        child: Container(
                          height: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(7.0),
                            color: Colors.white,
                            image: new DecorationImage(
                              image: (snapshot.data.result.data.list[index]
                                          .userThumb ==
                                      null)
                                  ? ExactAssetImage(
                                      'assets/images/logo_sq.png',
                                    )
                                  : NetworkImage(
                                      'https://water-flavour.com/public/image/thumb/' +
                                          snapshot.data.result.data.list[index]
                                              .userThumb),
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
                        '${snapshot.data.result.data.list[index].userNick}',
                        style: TextStyle(
                            fontSize: 20.0, fontWeight: FontWeight.w600),
                      ),
                      subtitle: Text(
                        '${snapshot.data.result.data.list[index].racketModel}\n${snapshot.data.result.data.list[index].racketCnt}개의 라켓',
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
              },
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
    );
  }
}
