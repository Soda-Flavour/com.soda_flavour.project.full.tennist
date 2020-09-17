import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:tennist/pages/tab_3/manage_racket/detail_racket/add_history/AddUserRacketHistory.model.dart';
import 'package:tennist/pages/tab_3/manage_racket/detail_racket/add_history/AddUserRacketHistory.provider.dart';
import 'package:tennist/pages/tab_3/manage_racket/detail_racket/dep_1_racket_list/UserRacketList.screen.dart';

import 'package:tennist/src/constants/GutTension.dart';
import 'package:tennist/src/constants/RacketBalanceType.dart';
import 'package:tennist/src/constants/RacketBalanceVal.dart';
import 'package:tennist/src/helper/ScreenPassData.dart';
import 'package:tennist/src/provider/LoadingProvider.dart';
import 'package:tennist/src/widget/DialogPopUp.widget.dart';

class AddUserRacketHistoryScreen extends StatelessWidget {
  static const String routeName = '/AddUserRacketHistory';
  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: [
      ChangeNotifierProvider(
        create: (_) => AddUserRacketHistoryProvider(),
      ),
    ], child: _AddUserRacketHistoryScreen());
  }
}

class _AddUserRacketHistoryScreen extends StatelessWidget {
  final GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();
  int userRacketId;
  bool isFirstLoading = true;
  @override
  Widget build(BuildContext context) {
    final loadingProv = Provider.of<LoadingProvider>(context, listen: false);
    final addUserRacketHistoryProv =
        Provider.of<AddUserRacketHistoryProvider>(context, listen: false);

    ScreenPassData args = ModalRoute.of(context).settings.arguments;

    if (isFirstLoading) {
      userRacketId = args.data['user_racket_id'];
      print("add갑확인 : $userRacketId");
      isFirstLoading = false;
    }

    var options = ["Option 1", "Option 2", "Option 3"];
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
                  '라켓 히스토리 추가',
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
          body: FutureBuilder<AddUserRacketHistoryModel>(
            future: AddUserRacketHistoryProvider().getGutListData(),
            builder: (context, snapshot) {
              print(snapshot.connectionState);

              if (snapshot.hasData) {
                List gutList = (snapshot.data.result.data.list != null)
                    ? snapshot.data.result.data.list
                    : null;

                return Column(
                  children: <Widget>[
                    Expanded(
                      child: SingleChildScrollView(
                        child: FormBuilder(
                          key: _fbKey,
                          initialValue: {
                            // 'date': DateTime.now(),
                            't_racket_id': userRacketId,
                          },
                          autovalidate: false,
                          child: Padding(
                            padding: const EdgeInsets.all(30.0),
                            child: Column(
                              children: <Widget>[
                                FormBuilderTextField(
                                  attribute: "weight",
                                  decoration:
                                      InputDecoration(labelText: "라켓무게(g)"),
                                  validators: [
                                    FormBuilderValidators.required(),
                                    FormBuilderValidators.numeric(),
                                    FormBuilderValidators.min(100),
                                    FormBuilderValidators.max(600),
                                  ],
                                ),
                                FormBuilderDropdown(
                                  attribute: "balance_type",
                                  decoration:
                                      InputDecoration(labelText: "밸런스 타입"),
                                  // initialValue: 'Male',
                                  hint: Text('선택해주세요.'),
                                  validators: [
                                    FormBuilderValidators.required()
                                  ],
                                  items: RacketBalanceType.keys
                                      .map((val) => DropdownMenuItem(
                                          value: val,
                                          child: Text(
                                              "${RacketBalanceType[val]}")))
                                      .toList(),
                                ),
                                FormBuilderDropdown(
                                  attribute: "balance_val",
                                  decoration:
                                      InputDecoration(labelText: "밸런스 수치"),
                                  // initialValue: 'Male',
                                  hint: Text('선택해주세요.'),
                                  validators: [
                                    FormBuilderValidators.required()
                                  ],
                                  items: RacketBalanceVal.map((val) =>
                                      DropdownMenuItem(
                                          value: val,
                                          child: Text("$val"))).toList(),
                                ),
                                FormBuilderDropdown(
                                  isDense: true,
                                  isExpanded: true,
                                  attribute: "t_gut_id",
                                  decoration: InputDecoration(
                                    labelText: "스트링",
                                  ),
                                  hint: Text('선택해주세요.'),
                                  validators: [
                                    FormBuilderValidators.required()
                                  ],
                                  items: gutList.map((val) {
                                    ListElement item = val;

                                    return DropdownMenuItem(
                                      value: item.id,
                                      child: Text(
                                          "${item.comapanyName}: ${item.gutName}"),
                                    );
                                  }).toList(),
                                ),
                                FormBuilderDropdown(
                                  attribute: "main_tension",
                                  decoration:
                                      InputDecoration(labelText: "메인텐션"),
                                  // initialValue: 'Male',
                                  hint: Text('선택해주세요.'),
                                  validators: [
                                    FormBuilderValidators.required()
                                  ],
                                  items: GutTension.map((val) =>
                                      DropdownMenuItem(
                                          value: val,
                                          child: Text("$val"))).toList(),
                                ),
                                FormBuilderDropdown(
                                  attribute: "cross_tension",
                                  decoration:
                                      InputDecoration(labelText: "크로스텐션"),
                                  // initialValue: 'Male',
                                  hint: Text('선택해주세요.'),
                                  validators: [
                                    FormBuilderValidators.required()
                                  ],
                                  items: GutTension.map((val) =>
                                      DropdownMenuItem(
                                          value: val,
                                          child: Text("$val"))).toList(),
                                ),
                                FormBuilderDropdown(
                                  attribute: "essential_grip",
                                  decoration: InputDecoration(labelText: "원그립"),
                                  // initialValue: 'Male',
                                  hint: Text('선택해주세요.'),
                                  validators: [
                                    FormBuilderValidators.required()
                                  ],
                                  items: ['leather', 'cusion']
                                      .map((val) => DropdownMenuItem(
                                          value: val, child: Text("$val")))
                                      .toList(),
                                ),
                                FormBuilderDropdown(
                                  attribute: "over_grip_num",
                                  decoration:
                                      InputDecoration(labelText: "오버그립 수"),
                                  // initialValue: 'Male',
                                  hint: Text('선택해주세요.'),
                                  validators: [
                                    FormBuilderValidators.required()
                                  ],
                                  items: [0, 1, 2, 3, 4, 5]
                                      .map((val) => DropdownMenuItem(
                                          value: val, child: Text("$val")))
                                      .toList(),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      height: 70,
                      child: SizedBox(
                        width: double.infinity,
                        child: RaisedButton(
                          onPressed: () async {
                            loadingProv.setIsLoading();

                            if (_fbKey.currentState.saveAndValidate()) {
                              print(_fbKey.currentState.value);
                              dynamic result =
                                  await AddUserRacketHistoryProvider()
                                      .insertUserRacketHistory(
                                          _fbKey.currentState.value);

                              loadingProv.setEndLoading();
                              if (result.status == 200) {
                                return DialogPopUpWidget().successDialogBox(
                                  context,
                                  result.message,
                                  () => Navigator.popUntil(
                                      context,
                                      ModalRoute.withName(
                                          UserRacketListScreen.routeName)),
                                );
                              } else {
                                return DialogPopUpWidget()
                                    .errorDialogBox(context, result.message);
                              }
                            }
                            loadingProv.setEndLoading();
                          },
                          color: const Color(0xff141414),
                          textColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(0),
                          ),
                          child: Text('저장'),
                        ),
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
        Container(
          child: Consumer<LoadingProvider>(
            builder: (context, loadingProv, child) => new Center(
              child: !(loadingProv.getIsLoading)
                  ? Container()
                  : Container(
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
          ),
        ),
      ],
    );
  }
}
