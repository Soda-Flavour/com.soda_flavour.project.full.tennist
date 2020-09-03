import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:provider/provider.dart';
import 'package:tennist_flutter/pages/tab_3/manage_racket/UserRacketList.screen.dart';
import 'package:tennist_flutter/pages/tab_3/manage_racket/add_racket/dep_3_select_racket_model/SelectRacketModel.model.dart';
import 'package:tennist_flutter/pages/tab_3/manage_racket/add_racket/dep_3_select_racket_model/SelectRacketModel.provider.dart';
import 'package:tennist_flutter/pages/tab_3/manage_racket/add_racket/dep_4_set_racket_nickname/SetRacketNickName.provider.dart';
import 'package:tennist_flutter/src/helper/ScreenPassData.dart';
import 'package:tennist_flutter/src/provider/LoadingProvider.dart';
import 'package:tennist_flutter/src/widget/BasicListRow.dart';
import 'package:tennist_flutter/src/widget/DialogPopUp.widget.dart';

class SelectRacketNickNameScreen extends StatelessWidget {
  static const String routeName = '/SetRacketNickName';
  final GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();

  bool loading = false;
  bool isFirstLoading = true;
  String racketName;
  int racketId;

  final List<String> racket = <String>['PRO', 'MP', 'TEAM'];

  @override
  Widget build(BuildContext context) {
    final loadingProv = Provider.of<LoadingProvider>(context, listen: false);
    final ScreenPassData args = ModalRoute.of(context).settings.arguments;

    if (isFirstLoading) {
      racketName = args.data['racketName'];
      racketId = args.data['id'];
      isFirstLoading = false;
    }

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
                  '라켓 별칭',
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    letterSpacing: 0.07,
                    color: Colors.white,
                    fontSize: 18.0,
                  ),
                ),
                centerTitle: true,
                actions: <Widget>[
                  new IconButton(
                    icon: new Icon(Icons.close),
                    onPressed: () => Navigator.popUntil(context,
                        ModalRoute.withName(UserRacketListScreen.routeName)),
                  ),
                ],
              ),
            ),
          ),
          body: Column(
            children: <Widget>[
              Expanded(
                child: SingleChildScrollView(
                  child: FormBuilder(
                    key: _fbKey,
                    initialValue: {
                      'racket_id': racketId,
                      // 'accept_terms': false,
                    },
                    autovalidate: false,
                    child: Padding(
                      padding: const EdgeInsets.all(30.0),
                      child: Column(
                        children: <Widget>[
                          Text("라켓 "),
                          Text("$racketName"),
                          Text("의 별칭을 적어주세요."),
                          FormBuilderTextField(
                            attribute: 'racket_nickname',
                            decoration: InputDecoration(labelText: "라켓 별칭"),
                            validators: [
                              FormBuilderValidators.required(),
                            ],
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
                        dynamic result = await SetRacketNickNameProvider()
                            .insertUserRacket(_fbKey.currentState.value);

                        loadingProv.setEndLoading();
                        if (result.status == 200) {
                          return DialogPopUpWidget().successDialogBox(
                            context,
                            result.message,
                            () => Navigator.popUntil(
                              context,
                              ModalRoute.withName(
                                  UserRacketListScreen.routeName),
                            ),
                          );
                          // Navigator.of(context).pop(),
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
