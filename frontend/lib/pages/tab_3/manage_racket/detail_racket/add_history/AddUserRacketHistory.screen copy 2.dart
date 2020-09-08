import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:tennist_flutter/pages/tab_3/manage_racket/detail_racket/add_history/AddUserRacketHistory.provider.dart';
import 'package:tennist_flutter/pages/tab_3/manage_racket/detail_racket/add_history/GutCompanyList.model.dart';
import 'package:tennist_flutter/src/constants/GutTension.dart';
import 'package:tennist_flutter/src/constants/RacketBalanceType.dart';
import 'package:tennist_flutter/src/constants/RacketBalanceVal.dart';
import 'package:tennist_flutter/src/provider/LoadingProvider.dart';
import 'package:tennist_flutter/src/widget/DialogPopUp.widget.dart';

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

  @override
  Widget build(BuildContext context) {
    final loadingProv = Provider.of<LoadingProvider>(context, listen: false);
    final addUserRacketHistoryProv =
        Provider.of<AddUserRacketHistoryProvider>(context, listen: false);
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
                  '신체정보',
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
          body: FutureBuilder<GutCompanyListModel>(
            future: AddUserRacketHistoryProvider().getGutCompanyListData(),
            builder: (context, snapshot) {
              print(snapshot.connectionState);

              if (snapshot.hasData) {
                List gutCompanyList = (snapshot.data.result.data.list != null)
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
                            // 'accept_terms': false,
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
                                  attribute: "gut_company_id",
                                  decoration:
                                      InputDecoration(labelText: "스트링 회사"),
                                  onChanged: (value) async =>
                                      addUserRacketHistoryProv
                                          .getGutListData(value),

                                  // initialValue: 'Male',
                                  hint: Text('선택해주세요.'),
                                  validators: [
                                    FormBuilderValidators.required()
                                  ],
                                  items: gutCompanyList.map((val) {
                                    ListElement item = val;

                                    return DropdownMenuItem(
                                      value: item.id,
                                      child: Text("${item.name}"),
                                    );
                                  }).toList(),
                                ),
                                Consumer<AddUserRacketHistoryProvider>(
                                    builder: (_, dataProv, child) {
                                  if (dataProv.getGutListModel != null &&
                                      dataProv.getGutListModel.length != 0) {
                                    print("1번진입");
                                    dynamic avalue = null;
                                    return FormBuilderDropdown(
                                        attribute: "gut_id",
                                        initialValue: avalue,
                                        onChanged: (val) {
                                          print(val);
                                          if (dataProv.isSetGutList) {
                                            print("가가");
                                          }
                                          print("vava");
                                        },
                                        decoration:
                                            InputDecoration(labelText: "스트링"),
                                        hint: Text('선택해주세요.'),
                                        validators: [
                                          FormBuilderValidators.required()
                                        ],
                                        items: dataProv.getGutListModel
                                            .map<DropdownMenuItem<dynamic>>(
                                                (dynamic value) {
                                          return DropdownMenuItem(
                                              value: value.id,
                                              child: Text(value.name));
                                        }).toList());
                                  } else {
                                    print("2번진입");
                                    return FormBuilderDropdown(
                                        attribute: "gut_id",
                                        decoration:
                                            InputDecoration(labelText: "스트링"),

                                        // initialValue: 'Male',
                                        hint: Text('선택해주세요.'),
                                        validators: [
                                          FormBuilderValidators.required()
                                        ],
                                        items: ['라켓 회사를 선택해주세요']
                                            .map((val) => DropdownMenuItem(
                                                value: 0, child: Text("$val")))
                                            .toList());
                                  }
                                }),
                                Consumer<AddUserRacketHistoryProvider>(
                                  builder: (context, dataProv, child) =>
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
                                  attribute: "essential_grip_id",
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
                                      .updatePhysicalInfo(
                                          _fbKey.currentState.value);

                              loadingProv.setEndLoading();
                              if (result.status == 200) {
                                return DialogPopUpWidget().successDialogBox(
                                  context,
                                  result.message,
                                  () => Navigator.of(context).pop(),
                                  // Navigator.popUntil(
                                  //     context, ModalRoute.withName(LogInScreen.routeName)),
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
