import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:tennist_flutter/pages/tab_3/profile/basic_info/UserBasicInfoForm.model.dart';
import 'package:tennist_flutter/pages/tab_3/profile/basic_info/UserBasicInfoForm.provider.dart';
import 'package:tennist_flutter/src/constants/Sex.dart';
import 'package:tennist_flutter/src/provider/LoadingProvider.dart';
import 'package:tennist_flutter/src/widget/DialogPopUp.widget.dart';

class UserBasicInfoFormScreen extends StatefulWidget {
  static const String routeName = '/UserBasicInfoForm';
  @override
  _UserBasicInfoFormScreenState createState() =>
      _UserBasicInfoFormScreenState();
}

class _UserBasicInfoFormScreenState extends State<UserBasicInfoFormScreen> {
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
            if (snapshot.hasData) {
              String nick = (snapshot.data != null)
                  ? snapshot.data.result.data[0].nick
                  : '로그인이 필요합니다.';
              String age = (snapshot.data.result.data[0].age != null)
                  ? snapshot.data.result.data[0].age
                  : '';

              String sex = (snapshot.data.result.data[0].sex != null)
                  ? snapshot.data.result.data[0].sex
                  : null;

              return ListView(
                padding: EdgeInsets.all(30.0),
                children: <Widget>[
                  FormBuilder(
                    key: _fbKey,
                    initialValue: {
                      // 'date': DateTime.now(),
                      // 'accept_terms': false,
                    },
                    autovalidate: false,
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
                          initialValue: '$age',
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
                          validators: [FormBuilderValidators.required()],
                          items: Sex.keys
                              .map((val) => DropdownMenuItem(
                                  value: val, child: Text("${Sex[val]}")))
                              .toList(),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            }
            if (snapshot.hasError) {}

            return CircularProgressIndicator();
          }),
      bottomNavigationBar: Container(
        height: 70,
        child: RaisedButton(
          onPressed: () async {
            // loadingProv.setIsLoading();
            // // bool isSubmit = await submit(context);
            // loadingProv.setEndLoading();

            if (_fbKey.currentState.saveAndValidate()) {
              print(_fbKey.currentState.value);
              dynamic result = await UserBasicInfoFormProvider()
                  .updateBasicInfo(_fbKey.currentState.value);

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
            // Navig
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
