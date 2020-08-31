import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:tennist_flutter/src/constants/NTRP.dart';

class ProfileFormScreen extends StatelessWidget {
  final GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("프로필 업데이트"),
      ),
      body: ListView(
        padding: EdgeInsets.all(30.0),
        children: <Widget>[
          FormBuilder(
            key: _fbKey,
            initialValue: {
              'date': DateTime.now(),
              'accept_terms': false,
            },
            autovalidate: true,
            child: Column(
              children: <Widget>[
                FormBuilderTextField(
                  attribute: "닉네임",
                  decoration: InputDecoration(labelText: "닉네임"),
                  validators: [
                    FormBuilderValidators.numeric(),
                    FormBuilderValidators.max(70),
                  ],
                ),
                FormBuilderTextField(
                  attribute: "나이",
                  decoration: InputDecoration(labelText: "나이"),
                  validators: [
                    FormBuilderValidators.numeric(),
                    FormBuilderValidators.max(70),
                  ],
                ),
                FormBuilderDropdown(
                  attribute: "성별",
                  decoration: InputDecoration(labelText: "성별"),
                  // initialValue: 'Male',
                  hint: Text('선택해주세요.'),
                  validators: [FormBuilderValidators.required()],
                  items: [
                    '남',
                    '여',
                  ]
                      .map((sex) =>
                          DropdownMenuItem(value: sex, child: Text("$sex")))
                      .toList(),
                ),
                FormBuilderTextField(
                  attribute: "키",
                  decoration: InputDecoration(labelText: "키"),
                  validators: [
                    FormBuilderValidators.numeric(),
                    FormBuilderValidators.max(70),
                  ],
                ),
                FormBuilderTextField(
                  attribute: "몸무게",
                  decoration: InputDecoration(labelText: "몸무게"),
                  validators: [
                    FormBuilderValidators.numeric(),
                    FormBuilderValidators.max(70),
                  ],
                ),
                FormBuilderDropdown(
                  attribute: "손잡이",
                  decoration: InputDecoration(labelText: "손잡이"),
                  // initialValue: 'Male',
                  hint: Text('선택해주세요.'),
                  validators: [FormBuilderValidators.required()],
                  items: ['오른손', '왼손']
                      .map((handed) => DropdownMenuItem(
                          value: handed, child: Text("$handed")))
                      .toList(),
                ),
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
                  attribute: "포핸드 스타일",
                  decoration: InputDecoration(labelText: "포핸드 스타일"),
                  // initialValue: 'Male',
                  hint: Text('선택해주세요.'),
                  validators: [FormBuilderValidators.required()],
                  items: [
                    '플랫',
                    '탑스핀',
                  ]
                      .map((forehand) => DropdownMenuItem(
                          value: forehand, child: Text("$forehand")))
                      .toList(),
                ),
                FormBuilderDropdown(
                  attribute: "백핸드 스타일",
                  decoration: InputDecoration(labelText: "백핸드 스타일"),
                  // initialValue: 'Male',
                  hint: Text('선택해주세요.'),
                  validators: [FormBuilderValidators.required()],
                  items: [
                    '원핸드',
                    '투핸드',
                  ]
                      .map((backhand) => DropdownMenuItem(
                          value: backhand, child: Text("$backhand")))
                      .toList(),
                ),
                FormBuilderDropdown(
                  attribute: "플레이 스타일",
                  decoration: InputDecoration(labelText: "플레이 스타일"),
                  // initialValue: 'Male',
                  hint: Text('선택해주세요.'),
                  validators: [FormBuilderValidators.required()],
                  items: [
                    '베이스라이너',
                    '서비스 앤 발리',
                    '올라운더',
                    '카운터 펀처',
                    '빅서버',
                    '정크볼러',
                  ]
                      .map((playStyle) => DropdownMenuItem(
                          value: playStyle, child: Text("$playStyle")))
                      .toList(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
