import 'package:flutter/material.dart';

Widget appBarMain(BuildContext context) {
  return AppBar(
    backgroundColor: Color.fromRGBO(100, 100, 100, 1),
    title: Image.network(
      "https://raw.githubusercontent.com/theindianappguy/FlutterChatAppTutorial/master/assets/images/logo.png",
      height: 50,
    ),
  );
}
