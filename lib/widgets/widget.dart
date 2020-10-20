// import 'package:flutter/material.dart';

// Widget appBarMain(BuildContext context) {
//   return AppBar(
//     backgroundColor: Color.fromRGBO(100, 100, 100, 1),
//     title: Image.network(
//       "https://raw.githubusercontent.com/theindianappguy/FlutterChatAppTutorial/master/assets/images/logo.png",
//       height: 50,
//     ),
//   );
// }
import 'package:flutter/material.dart';

Widget appBarMain(BuildContext context) {
  return AppBar(
    title: Image.network(
      "https://raw.githubusercontent.com/theindianappguy/FlutterChatAppTutorial/master/assets/images/logo.png",
      height: 40,
    ),
    elevation: 0.0,
    centerTitle: false,
  );
}

InputDecoration textFieldInputDecoration(String hintText) {
  return InputDecoration(
      hintText: hintText,
      hintStyle: TextStyle(color: Colors.white54),
      focusedBorder:
          UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)),
      enabledBorder:
          UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)));
}

TextStyle simpleTextStyle() {
  return TextStyle(color: Colors.white, fontSize: 16);
}

TextStyle biggerTextStyle() {
  return TextStyle(color: Colors.white, fontSize: 17);
}
