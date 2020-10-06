import 'package:FP/helper/constants.dart';
import 'package:FP/services/database.dart';
import 'package:FP/widgets/widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'conversation_screen.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  QuerySnapshot searchSnapshot;

  initiateSearch() {
    databaseMethods
        .getuserByUsername(usernameTexteditingController.text)
        .then((val) {
      setState(() {
        searchSnapshot = val;
      });
    });
  }

  createChatroomAndStartConversation(String userName) {
    // print("${Constants.myName}");
    if (userName != Constants.myName) {
      String chatroomId = getChatRommId(userName, Constants.myName);
      List<String> users = [userName, Constants.myName];

      Map<String, dynamic> chatRoomMap = {
        "users": users,
        "chatroomId": chatroomId
      };

      databaseMethods.createChatRoom(chatroomId, chatRoomMap);
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => ConversationScreen()));
    } else {
      print("you canot send msg to urself");
    }
  }

  Widget searchList() {
    // DatabaseMethods databaseMethods = new DatabaseMethods();
    return searchSnapshot != null
        ? ListView.builder(
            shrinkWrap: true,
            itemCount: searchSnapshot.documents.length,
            itemBuilder: (context, index) {
              // userName: searchSnapshot.documents[index].data["name"],
              // userEmail: searchSnapshot.documents[index].data["email"]
              return Container(
                padding: EdgeInsets.symmetric(horizontal: 5, vertical: 8),
                child: Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          searchSnapshot.documents[index].data["name"],
                          style: TextStyle(fontSize: 14, color: Colors.white),
                        ),
                        Text(
                          searchSnapshot.documents[index].data["email"],
                          style: TextStyle(fontSize: 14, color: Colors.white),
                        ),
                      ],
                    ),
                    Spacer(),
                    GestureDetector(
                      onTap: () {
                        createChatroomAndStartConversation(
                            searchSnapshot.documents[index].data["name"]);
                      },
                      child: Container(
                          decoration: BoxDecoration(
                              color: Colors.blue,
                              borderRadius: BorderRadius.circular(30)),
                          padding: EdgeInsets.symmetric(
                              horizontal: 16, vertical: 18),
                          child: Text(
                            "message",
                            style: TextStyle(color: Colors.white),
                          )),
                    )
                  ],
                ),
              );
            })
        : Container();
  }

  DatabaseMethods databaseMethods = new DatabaseMethods();
  TextEditingController usernameTexteditingController =
      new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarMain(context),
      body: Container(
        child: Column(
          children: [
            Container(
              color: Color(0x54FFFFFF),
              padding: EdgeInsets.symmetric(horizontal: 24, vertical: 13),
              child: Row(
                children: [
                  Expanded(
                      child: TextField(
                    controller: usernameTexteditingController,
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                        hintText: "search username...",
                        hintStyle: TextStyle(color: Colors.white54),
                        border: InputBorder.none),
                  )),
                  GestureDetector(
                    onTap: () {
                      initiateSearch();
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.blueGrey[300],
                        borderRadius: BorderRadius.circular(30),
                      ),
                      padding: EdgeInsets.all(10),
                      child: Image.network(
                        "https://raw.githubusercontent.com/theindianappguy/FlutterChatAppTutorial/master/assets/images/search_white.png",
                        height: 30,
                        width: 30,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            searchList()
          ],
        ),
      ),
    );
  }
}

getChatRommId(String a, String b) {
  if (a.substring(0, 1).codeUnitAt(0) > b.substring(0, 1).codeUnitAt(0)) {
    return "$b\_$a";
  } else {
    return "$a\_$b";
  }
}

// class SearchTile extends StatelessWidget {
//   final String userName;
//   final String userEmail;
//   SearchTile({this.userEmail, this.userName});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: EdgeInsets.symmetric(horizontal: 5, vertical: 8),
//       child: Row(
//         children: [
//           Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 userName,
//                 style: TextStyle(fontSize: 14, color: Colors.white),
//               ),
//               Text(
//                 userEmail,
//                 style: TextStyle(fontSize: 14, color: Colors.white),
//               ),
//             ],
//           ),
//           Spacer(),
//           Container(
//               decoration: BoxDecoration(
//                   color: Colors.blue, borderRadius: BorderRadius.circular(30)),
//               padding: EdgeInsets.symmetric(horizontal: 16, vertical: 18),
//               child: Text(
//                 "message",
//                 style: TextStyle(color: Colors.white),
//               ))
//         ],
//       ),
//     );
//   }
// }
