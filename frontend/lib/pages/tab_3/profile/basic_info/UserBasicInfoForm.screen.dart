import 'package:async/async.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:tennist/pages/tab_3/profile/basic_info/UserBasicInfoForm.model.dart';
import 'package:tennist/pages/tab_3/profile/basic_info/UserBasicInfoForm.provider.dart';
import 'package:tennist/src/constants/Sex.dart';
import 'package:tennist/src/provider/LoadingProvider.dart';
import 'package:tennist/src/widget/DialogPopUp.widget.dart';

class UserBasicInfoFormScreen extends StatelessWidget {
  static const String routeName = '/UserBasicInfoForm';
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
                  '기본정보',
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
          body: FutureBuilder<UserBasicInfoFormModel>(
            future: UserBasicInfoFormProvider().getData(),
            builder: (context, snapshot) {
              print(snapshot.connectionState);
              print(snapshot.data);

              if (snapshot.hasData) {
                String nick = (snapshot.data != null)
                    ? snapshot.data.result.data[0].nick
                    : '로그인이 필요합니다.';
                String age = (snapshot.data.result.data[0].age != null)
                    ? snapshot.data.result.data[0].age.toString()
                    : '';

                String sex = (snapshot.data.result.data[0].sex != null)
                    ? snapshot.data.result.data[0].sex
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
                                  attribute: 'nick',
                                  initialValue: '$nick',
                                  decoration: InputDecoration(labelText: "닉네임"),
                                  validators: [
                                    FormBuilderValidators.required(),
                                  ],
                                ),
                                FormBuilderTextField(
                                  attribute: "age",
                                  initialValue: "$age",
                                  decoration: InputDecoration(labelText: "나이"),
                                  validators: [
                                    FormBuilderValidators.required(),
                                    FormBuilderValidators.numeric(),
                                    FormBuilderValidators.max(70),
                                  ],
                                ),
                                FormBuilderDropdown(
                                  attribute: "sex",
                                  decoration: InputDecoration(labelText: "성별"),
                                  initialValue: sex,
                                  hint: Text('선택해주세요.'),
                                  validators: [
                                    FormBuilderValidators.required()
                                  ],
                                  items: Sex.keys
                                      .map((val) => DropdownMenuItem(
                                          value: val,
                                          child: Text("${Sex[val]}")))
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
                              dynamic result = await UserBasicInfoFormProvider()
                                  .updateBasicInfo(_fbKey.currentState.value);

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
