import 'package:FP/widgets/widget.dart';
import 'package:flutter/material.dart';

class ConversationScreen extends StatefulWidget {
  @override
  _ConversationScreenState createState() => _ConversationScreenState();
}

class _ConversationScreenState extends State<ConversationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: appBarMain(context),
        body: Container(
          alignment: Alignment.bottomCenter,
          child: Container(
              color: Color(0x54FFFFFF),
              padding: EdgeInsets.symmetric(horizontal: 24, vertical: 10),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "send msg...",
                          hintStyle:
                              TextStyle(fontSize: 16, color: Colors.white54)),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: Colors.blueGrey[300],
                        borderRadius: BorderRadius.circular(30)),
                    child: Image.network(
                      "https://raw.githubusercontent.com/theindianappguy/FlutterChatAppTutorial/master/assets/images/send.png",
                      height: 25,
                    ),
                  )
                ],
              )),
        ));
  }
}
