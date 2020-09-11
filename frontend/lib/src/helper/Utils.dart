// import 'package:flutter/material.dart';
// import 'dart:js' as js;

// Size screenSize(BuildContext context) {
//   return MediaQuery.of(context).size;
// }

// double screenHeight(BuildContext context, {double dividedBy = 1}) {
//   return screenSize(context).height / dividedBy;
// }

// double screenWidth(BuildContext context, {double dividedBy = 1}) {
//   return screenSize(context).width / dividedBy;
// }

// bool isMobile({BuildContext context}) {
//   if (screenSize(context).width <= 480) {
//     return true;
//   }
//   return false;
// }

// // AppBar customAppBar({BuildContext context}) {
// //   return isMobile(context: context)
// //       ? new AppBar(
// //           title: const Text('PortFolio'),
// //         )
// //       : null;
// // }

// // Color getAppColor() {
// //   return Color.fromRGBO(165, 26, 26, 0.7);
// // }

// // void openLinkedIn() {
// //   js.context
// //       .callMethod('open', ['https://www.linkedin.com/in/aravindhkumar23/']);
// // }

// // void openFb() {
// //   js.context
// //       .callMethod('open', ['https://www.facebook.com/aravindh.kumar.568']);
// // }

// // void openGit() {
// //   js.context.callMethod('open', ['https://github.com/aravindhkumar23']);
// // }

// // void openCV() {
// //   js.context.callMethod('open', [
// //     'https://drive.google.com/file/d/1D79_nea5hEJDWyfqoNqXKboXGf7XFGUZ/view?usp=sharing'
// //   ]);
// // }

// void openCompanyProfile({int index}) {
//   switch (index) {
//     case 0:
//       break;
//     case 1:
//       js.context.callMethod('open', ['http://digiryte.com/']);
//       break;
//     case 2:
//       js.context.callMethod('open', ['https://www.redblacktree.com/']);
//       break;
//     case 3:
//       js.context.callMethod('open', ['https://www.redblacktree.com/']);
//       break;
//     case 4:
//       js.context.callMethod('open', ['http://aaumanalytics.com/']);
//       break;
//     default:
//       break;
//   }
// }
