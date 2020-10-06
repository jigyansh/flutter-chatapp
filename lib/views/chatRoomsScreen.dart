import 'package:FP/helper/constants.dart';
import 'package:FP/helper/helperfunctions.dart';
import 'package:FP/services/auth.dart';
import 'package:FP/helper/authenticate.dart';
import 'package:FP/views/search.dart';
import 'package:flutter/material.dart';

class ChatRoom extends StatefulWidget {
  @override
  _ChatRoomState createState() => _ChatRoomState();
}

class _ChatRoomState extends State<ChatRoom> {
  AuthMethods authMethods = new AuthMethods();
  @override
  void initState() {
    // TOD
    getUserInfo();
    super.initState();
  }

  getUserInfo() async {
    Constants.myName = await HelperFunctions.getUserNameSharedPreference();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromRGBO(100, 100, 100, 1),
          title: Image.network(
            "https://raw.githubusercontent.com/theindianappguy/FlutterChatAppTutorial/master/assets/images/logo.png",
            height: 50,
          ),
          actions: [
            GestureDetector(
              onTap: () {
                authMethods.signOut();
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => Authenticate()));
              },
              child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 17),
                  child: Icon(Icons.exit_to_app)),
            )
          ],
        ),
        floatingActionButton: FloatingActionButton(
            child: Icon(Icons.search),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => SearchScreen()));
            }));
  }
}
