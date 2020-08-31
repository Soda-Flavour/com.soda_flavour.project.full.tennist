import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:tennist_flutter/pages/BottomNaviController.dart';
import 'package:tennist_flutter/pages/account/FindPassword.screen.dart';
import 'package:tennist_flutter/pages/account/login/LogIn.provider.dart';
import 'package:tennist_flutter/pages/account/signup/SignUp.screen.dart';
import 'package:tennist_flutter/pages/tab_3/main/Tab3Main.screen.dart';
import 'package:tennist_flutter/src/provider/LoadingProvider.dart';
import 'package:tennist_flutter/src/widget/DialogPopUp.widget.dart';

class LogInScreen extends StatefulWidget {
  static const String routeName = '/LogIn';
  @override
  _LogInScreenState createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  bool isLoading = false;
  final GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();

  final TextEditingController _emailTextController =
      new TextEditingController();
  final TextEditingController _passwordTextController =
      new TextEditingController();

  _dismissKeyboard(BuildContext context) {
    FocusScope.of(context).requestFocus(new FocusNode());
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: <Widget>[
        Scaffold(
          extendBodyBehindAppBar: true,
          backgroundColor: Colors.transparent,
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(60.0),
            child: Container(
              alignment: FractionalOffset.centerRight,
              child: AppBar(
                elevation: 0,
                automaticallyImplyLeading: true,
                backgroundColor: Colors.transparent, //왼쪽 화살표 뒤로 없애기
              ),
            ),
          ),
          body: GestureDetector(
            onTap: () => this._dismissKeyboard(context),
            child: SingleChildScrollView(
              child: FormBuilder(
                key: _fbKey,
                initialValue: {
                  // 'date': DateTime.now(),
                  // 'accept_terms': false,
                },
                autovalidate: true,
                child: Container(
                  height: MediaQuery.of(context).size.height,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topRight,
                      end: Alignment.bottomLeft,
                      stops: [0.1, 0.9],
                      colors: [
                        Color(0xff141414),
                        Color(0xff003a7B),
                      ],
                    ),
                  ),
                  child: Center(
                    child: Container(
                      margin: EdgeInsets.all(48.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Image.asset('assets/images/tennist_logo.png',
                              scale: 1.2),
                          SizedBox(
                            height: 80,
                          ),
                          FormBuilderTextField(
                            attribute: "email",
                            textAlign: TextAlign.center,
                            maxLines: 1,
                            style: TextStyle(color: const Color(0xffffffff)),
                            decoration: InputDecoration(
                              hintMaxLines: 1,
                              hintText: "Email",
                              hintStyle: TextStyle(
                                color: const Color(0xff8A94A8),
                              ),
                              prefixIcon: Icon(
                                Icons.email,
                                color: Color(0xff8A94A8),
                              ),
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  width: 2,
                                  color: const Color(0xff8A94A8),
                                ),
                              ),
                            ),
                            validators: [
                              FormBuilderValidators.email(),
                            ],
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          FormBuilderTextField(
                            attribute: "password",
                            textAlign: TextAlign.center,
                            maxLines: 1,
                            style: TextStyle(color: const Color(0xffffffff)),
                            decoration: InputDecoration(
                              hintMaxLines: 1,
                              hintText: "Password",
                              hintStyle: TextStyle(
                                color: const Color(0xff8A94A8),
                              ),
                              prefixIcon: Icon(
                                Icons.lock,
                                color: Color(0xff8A94A8),
                              ),
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  width: 2,
                                  color: const Color(0xff8A94A8),
                                ),
                              ),
                            ),
                            validators: [
                              FormBuilderValidators.max(20),
                            ],
                          ),
                          SizedBox(
                            height: 40,
                          ),
                          SizedBox(
                            width: double.infinity,
                            height: 60,
                            child: new FlatButton(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(40.0),
                              ),
                              color: Color(0xff01a2ff),
                              child: new Text(
                                "로그인",
                                style: TextStyle(
                                  color: Color(0xffffffff),
                                  fontWeight: FontWeight.w600,
                                  fontSize: 20.0,
                                ),
                              ),
                              onPressed: () async {
                                setState(() => isLoading = true);
                                if (_fbKey.currentState.saveAndValidate()) {
                                  dynamic result = await LogInProvider()
                                      .logIn(_fbKey.currentState.value);
                                  setState(() => isLoading = false);
                                  if (result.status == 200) {
                                    return DialogPopUpWidget().successDialogBox(
                                      context,
                                      result.message,
                                      () =>
                                          // Navigator.of(context).pop();
                                          //     Navigator.popUntil(
                                          //   context,
                                          //   ModalRoute.withName(
                                          //       BottomNaviController.routeName),
                                          // ),
                                          Navigator.of(context)
                                              .pushNamedAndRemoveUntil(
                                        BottomNaviController.routeName,
                                        (route) => false,
                                      ),
                                    );
                                  } else {
                                    return DialogPopUpWidget().errorDialogBox(
                                        context, result.message);
                                  }
                                }
                                setState(() => isLoading = false);
                                // Navigator.of(context).pop();
                              },
                            ),
                          ),
                          SizedBox(
                            height: 36,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              InkWell(
                                onTap: () {
                                  Navigator.of(context)
                                      .pushNamed(FindPasswordScreen.routeName);
                                },
                                child: Text(
                                  "비밀번호 찾기",
                                  style: TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.w600,
                                    color: Color(0xff01a0e8),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Text(
                                    "아직 회원이 아니신가요?",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16.0,
                                      color: Color(0xffffffff),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  InkWell(
                                    onTap: () {
                                      Navigator.of(context)
                                          .pushNamed(SignUpScreen.routeName);
                                    },
                                    child: Text(
                                      "회원가입하기",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 16.0,
                                        color: Color(0xff01a0e8),
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        Container(
          child: new Center(
            child: (!isLoading)
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
        )
      ],
    );
  }
}
