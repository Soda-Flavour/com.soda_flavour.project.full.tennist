import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:tennist_flutter/pages/tab_3/profile/tennis_info/TennisInfoForm.model.dart';
import 'package:tennist_flutter/pages/tab_3/profile/tennis_info/TennisInfoForm.provider.dart';
import 'package:tennist_flutter/src/constants/BackHand.dart';
import 'package:tennist_flutter/src/constants/ForeHand.dart';
import 'package:tennist_flutter/src/constants/NTRP.dart';
import 'package:tennist_flutter/src/constants/PlayStyle.dart';
import 'package:tennist_flutter/src/provider/LoadingProvider.dart';
import 'package:tennist_flutter/src/widget/DialogPopUp.widget.dart';

class TennisInfoFormScreen extends StatelessWidget {
  static const String routeName = '/TennisInfoForm';
  final GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    final loadingProv = Provider.of<LoadingProvider>(context, listen: false);
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
          body: FutureBuilder<TennisInfoFormModel>(
            future: TennisInfoFormProvider().getData(),
            builder: (context, snapshot) {
              print(snapshot.connectionState);
              print(snapshot.data);

              if (snapshot.hasData) {
                double ntrp = (snapshot.data.result.data[0].ntrp != null)
                    ? snapshot.data.result.data[0].ntrp
                    : null;
                int forehand = (snapshot.data.result.data[0].forehand != null)
                    ? snapshot.data.result.data[0].forehand
                    : null;
                int backhand = (snapshot.data.result.data[0].backhand != null)
                    ? snapshot.data.result.data[0].backhand
                    : null;
                int playstyle = (snapshot.data.result.data[0].playstyle != null)
                    ? snapshot.data.result.data[0].playstyle
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
                                FormBuilderDropdown(
                                  attribute: "ntrp",
                                  initialValue: ntrp,
                                  decoration:
                                      InputDecoration(labelText: "NTRP"),
                                  // initialValue: 'Male',
                                  hint: Text('선택해주세요.'),
                                  validators: [
                                    FormBuilderValidators.required()
                                  ],
                                  items: NTRP
                                      .map((val) => DropdownMenuItem(
                                          value: val, child: Text("$val")))
                                      .toList(),
                                ),
                                FormBuilderDropdown(
                                  attribute: "forehand",
                                  initialValue: forehand,
                                  decoration:
                                      InputDecoration(labelText: "포핸드 스타일"),
                                  // initialValue: 'Male',
                                  hint: Text('선택해주세요.'),
                                  validators: [
                                    FormBuilderValidators.required()
                                  ],
                                  items: ForeHand.keys
                                      .map((val) => DropdownMenuItem(
                                          value: val,
                                          child: Text("${ForeHand[val]}")))
                                      .toList(),
                                ),
                                FormBuilderDropdown(
                                  attribute: "backhand",
                                  initialValue: backhand,
                                  decoration:
                                      InputDecoration(labelText: "백핸드 스타일"),
                                  // initialValue: 'Male',
                                  hint: Text('선택해주세요.'),
                                  validators: [
                                    FormBuilderValidators.required()
                                  ],
                                  items: BackHand.keys
                                      .map((val) => DropdownMenuItem(
                                          value: val,
                                          child: Text("${BackHand[val]}")))
                                      .toList(),
                                ),
                                FormBuilderDropdown(
                                  attribute: "play_style",
                                  initialValue: playstyle,
                                  decoration:
                                      InputDecoration(labelText: "플레이 스타일"),
                                  // initialValue: 1,
                                  hint: Text('선택해주세요.'),
                                  validators: [
                                    FormBuilderValidators.required()
                                  ],
                                  items: PlayStyle.keys
                                      .map((val) => DropdownMenuItem(
                                          value: val,
                                          child: Text("${PlayStyle[val]}")))
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
                              dynamic result = await TennisInfoFormProvider()
                                  .updatePlayStyleInfo(
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
