import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:tennist/pages/account/login/LogIn.screen.dart';
import 'package:tennist/pages/account/signup/SignUp.provider.dart';
import 'package:tennist/src/constants/Sex.dart';
import 'package:tennist/src/provider/LoadingProvider.dart';
import 'package:tennist/src/widget/DialogPopUp.widget.dart';

class SignUpScreen extends StatefulWidget {
  static const String routeName = '/SignUp';
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool isLoading = false;
  final GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();
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
                backgroundColor: Colors.transparent,
                title: Text(
                  '회원가입',
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    letterSpacing: 0.07,
                    color: Colors.white,
                    fontSize: 18.0,
                  ),
                ),
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
                autovalidateMode: AutovalidateMode.always,
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
                            attribute: "nick",
                            textAlign: TextAlign.center,
                            maxLines: 1,
                            style: TextStyle(color: const Color(0xffffffff)),
                            decoration: InputDecoration(
                              hintMaxLines: 1,
                              hintText: "Nickname",
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
                              FormBuilderValidators.required(),
                            ],
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          FormBuilderTextField(
                            attribute: "password",
                            textAlign: TextAlign.center,
                            obscureText: true,
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
                          FormBuilderTextField(
                            attribute: "repassword",
                            textAlign: TextAlign.center,
                            maxLines: 1,
                            obscureText: true,
                            style: TextStyle(color: const Color(0xffffffff)),
                            decoration: InputDecoration(
                              hintMaxLines: 1,
                              hintText: "Confirm Password",
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
                                "회원가입",
                                style: TextStyle(
                                  color: Color(0xffffffff),
                                  fontWeight: FontWeight.w600,
                                  fontSize: 20.0,
                                ),
                              ),
                              onPressed: () async {
                                setState(() => isLoading = true);
                                if (_fbKey.currentState.saveAndValidate()) {
                                  print(_fbKey.currentState.value);
                                  dynamic result = await SignUpProvider()
                                      .signUp(_fbKey.currentState.value);
                                  setState(() => isLoading = false);
                                  if (result.status == 200) {
                                    return DialogPopUpWidget().successDialogBox(
                                        context,
                                        result.message,
                                        () =>
                                            // Navigator.of(context).pop();
                                            Navigator.popUntil(
                                                context,
                                                ModalRoute.withName(
                                                    LogInScreen.routeName)));
                                  } else {
                                    return DialogPopUpWidget().errorDialogBox(
                                        context, result.message);
                                  }
                                }
                                setState(() => isLoading = false);
                              },
                            ),
                          ),
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
