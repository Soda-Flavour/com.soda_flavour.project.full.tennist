import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:tennist_flutter/src/constants/BackHand.dart';
import 'package:tennist_flutter/src/constants/ForeHand.dart';
import 'package:tennist_flutter/src/constants/NTRP.dart';
import 'package:tennist_flutter/src/constants/PlayStyle.dart';
import 'package:tennist_flutter/src/provider/LoadingProvider.dart';

class TennisInfoFormScreen extends StatefulWidget {
  static const String routeName = '/TennisInfoForm';
  @override
  _TennisInfoFormScreenState createState() => _TennisInfoFormScreenState();
}

class _TennisInfoFormScreenState extends State<TennisInfoFormScreen> {
  final GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    final loadingProv = Provider.of<LoadingProvider>(context, listen: false);
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60.0),
        child: Container(
          alignment: FractionalOffset.centerRight,
          child: AppBar(
            automaticallyImplyLeading: true, //왼쪽 화살표 뒤로 없애기
            backgroundColor: const Color(0xff141414),
            title: Text(
              '플레이 스타일',
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
      body: ListView(
        padding: EdgeInsets.all(30.0),
        children: <Widget>[
          FormBuilder(
            key: _fbKey,
            initialValue: {
              'date': DateTime.now(),
              // 'accept_terms': false,
            },
            autovalidate: true,
            child: Column(
              children: <Widget>[
                FormBuilderDropdown(
                  attribute: "ntrp",
                  decoration: InputDecoration(labelText: "NTRP"),
                  // initialValue: 'Male',
                  hint: Text('선택해주세요.'),
                  validators: [FormBuilderValidators.required()],
                  items: NTRP
                      .map((ntrp) =>
                          DropdownMenuItem(value: ntrp, child: Text("$ntrp")))
                      .toList(),
                ),
                FormBuilderDropdown(
                  attribute: "forehand",
                  decoration: InputDecoration(labelText: "포핸드 스타일"),
                  // initialValue: 'Male',
                  hint: Text('선택해주세요.'),
                  validators: [FormBuilderValidators.required()],
                  items: ForeHand.keys
                      .map((val) => DropdownMenuItem(
                          value: val, child: Text("${ForeHand[val]}")))
                      .toList(),
                ),
                FormBuilderDropdown(
                  attribute: "backhand",
                  decoration: InputDecoration(labelText: "백핸드 스타일"),
                  // initialValue: 'Male',
                  hint: Text('선택해주세요.'),
                  validators: [FormBuilderValidators.required()],
                  items: BackHand.keys
                      .map((val) => DropdownMenuItem(
                          value: val, child: Text("${BackHand[val]}")))
                      .toList(),
                ),
                FormBuilderDropdown(
                  attribute: "play_style",
                  decoration: InputDecoration(labelText: "플레이 스타일"),
                  // initialValue: 1,
                  hint: Text('선택해주세요.'),
                  validators: [FormBuilderValidators.required()],
                  items: PlayStyle.keys
                      .map((val) => DropdownMenuItem(
                          value: val, child: Text("${PlayStyle[val]}")))
                      .toList(),
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        height: 70,
        child: RaisedButton(
          onPressed: () async {
            loadingProv.setIsLoading();
            if (_fbKey.currentState.saveAndValidate()) {
              print(_fbKey.currentState.value);
              // bool isSubmit = await submit(context);
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
    );
  }
}
