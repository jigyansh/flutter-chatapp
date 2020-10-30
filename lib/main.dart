import 'package:FP/helper/authenticate.dart';
import 'package:FP/views/chatRoomsScreen.dart';
import 'package:flutter/material.dart';
// import 'helper/helperfunctions.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool userIsLoggedIn = false;
  @override
  void initState() {
    // TO
    // getLoggedInState();
    super.initState();
  }

  // getLoggedInState() async {
  //   await HelperFunctions.getUserLoggedInSharedPreference().then((value) {
  //     setState(() {
  //       userIsLoggedIn = value;
  //     });
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // title: 'FP',
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.black,
        primarySwatch: Colors.blueGrey,
      ),
      home: userIsLoggedIn ? ChatRoom() : Authenticate(),
    );
  }
}
