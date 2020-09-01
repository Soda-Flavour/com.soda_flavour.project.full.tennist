import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:tennist_flutter/pages/tab_3/profile/physical_info/PhysicalInfoForm.model.dart';
import 'package:tennist_flutter/pages/tab_3/profile/physical_info/PhysicalInfoForm.provider.dart';
import 'package:tennist_flutter/src/constants/Handed.dart';
import 'package:tennist_flutter/src/provider/LoadingProvider.dart';
import 'package:tennist_flutter/src/widget/DialogPopUp.widget.dart';

class PhysicalInfoFormScreen extends StatelessWidget {
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
          body: FutureBuilder<PhysicalInfoFormModel>(
            future: PhysicalInfoFormProvider().getData(),
            builder: (context, snapshot) {
              print(snapshot.connectionState);

              if (snapshot.hasData) {
                String height_cm =
                    (snapshot.data.result.data[0].heightCm != null)
                        ? snapshot.data.result.data[0].heightCm.toString()
                        : '';
                String weight_kg =
                    (snapshot.data.result.data[0].weightKg != null)
                        ? snapshot.data.result.data[0].weightKg.toString()
                        : '';

                String handed = (snapshot.data.result.data[0].handed != null)
                    ? snapshot.data.result.data[0].handed
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
                                  attribute: "height_cm",
                                  initialValue: '$height_cm',
                                  decoration: InputDecoration(labelText: "키"),
                                  validators: [
                                    FormBuilderValidators.required(
                                        errorText: '키를 작성해주세요.'),
                                    FormBuilderValidators.numeric(
                                        errorText: '숫자만 가능합니다.'),
                                    FormBuilderValidators.max(250,
                                        errorText: '최대 250까지 가능합니다.'),
                                  ],
                                ),
                                FormBuilderTextField(
                                  attribute: "weight_kg",
                                  initialValue: '$weight_kg',
                                  decoration: InputDecoration(labelText: "몸무게"),
                                  validators: [
                                    FormBuilderValidators.required(
                                        errorText: '몸무게를 작성해주세요.'),
                                    FormBuilderValidators.numeric(
                                        errorText: '숫자만 가능합니다.'),
                                    FormBuilderValidators.max(250,
                                        errorText: '최대 250까지 가능합니다.'),
                                  ],
                                ),
                                FormBuilderDropdown(
                                  attribute: "handed",
                                  decoration: InputDecoration(labelText: "손잡이"),
                                  initialValue: handed,
                                  hint: Text('선택해주세요.'),
                                  // valueTransformer: (text) => {_HandedName.},
                                  validators: [
                                    FormBuilderValidators.required(
                                        errorText: '주로 사용하는 손을 선택해주세요.'),
                                  ],
                                  items: HandedName.keys
                                      .map((val) => DropdownMenuItem(
                                          value: val,
                                          child: Text("${HandedName[val]}")))
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
                              dynamic result = await PhysicalInfoFormProvider()
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
