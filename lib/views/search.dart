import 'package:FP/helper/constants.dart';
import 'package:FP/services/database.dart';
import 'package:FP/widgets/widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'conversation_screen.dart';

// class Search extends StatefulWidget {
//   @override
//   _SearchState createState() => _SearchState();
// }

// class _SearchState extends State<Search> {
//   DatabaseMethods databaseMethods = new DatabaseMethods();
//   TextEditingController searchEditingController = new TextEditingController();
//   QuerySnapshot searchResultSnapshot;

//   bool isLoading = false;
//   bool haveUserSearched = false;

//   initiateSearch() async {
//     if (searchEditingController.text.isNotEmpty) {
//       setState(() {
//         isLoading = true;
//       });
//       await databaseMethods
//           .getuserByUsername(searchEditingController.text)
//           .then((snapshot) {
//         searchResultSnapshot = snapshot;
//         print("$searchResultSnapshot");
//         setState(() {
//           isLoading = false;
//           haveUserSearched = true;
//         });
//       });
//     }
//   }

//   Widget userList() {
//     return haveUserSearched
//         ? ListView.builder(
//             shrinkWrap: true,
//             itemCount: searchResultSnapshot.documents.length,
//             itemBuilder: (context, index) {
//               return userTile(
//                 searchResultSnapshot.documents[index].data["userName"],
//                 searchResultSnapshot.documents[index].data["userEmail"],
//               );
//             })
//         : Container();
//   }

//   /// 1.create a chatroom, send user to the chatroom, other userdetails
//   sendMessage(String userName) {
//     List<String> users = [Constants.myName, userName];

//     String chatRoomId = getChatRoomId(Constants.myName, userName);

//     Map<String, dynamic> chatRoom = {
//       "users": users,
//       "chatRoomId": chatRoomId,
//     };

//     databaseMethods.addConversationMessages(chatRoomId, chatRoom);

//     Navigator.push(
//         context,
//         MaterialPageRoute(
//             builder: (context) => Chat(
//                   chatRoomId: chatRoomId,
//                 )));
//   }

//   Widget userTile(String userName, String userEmail) {
//     return Container(
//       padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
//       child: Row(
//         children: [
//           Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 userName,
//                 style: TextStyle(color: Colors.white, fontSize: 16),
//               ),
//               Text(
//                 userEmail,
//                 style: TextStyle(color: Colors.white, fontSize: 16),
//               )
//             ],
//           ),
//           Spacer(),
//           GestureDetector(
//             onTap: () {
//               sendMessage(userName);
//             },
//             child: Container(
//               padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
//               decoration: BoxDecoration(
//                   color: Colors.blue, borderRadius: BorderRadius.circular(24)),
//               child: Text(
//                 "Message",
//                 style: TextStyle(color: Colors.white, fontSize: 16),
//               ),
//             ),
//           )
//         ],
//       ),
//     );
//   }

//   getChatRoomId(String a, String b) {
//     if (a.substring(0, 1).codeUnitAt(0) > b.substring(0, 1).codeUnitAt(0)) {
//       return "$b\_$a";
//     } else {
//       return "$a\_$b";
//     }
//   }

//   @override
//   void initState() {
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: appBarMain(context),
//       body: isLoading
//           ? Container(
//               child: Center(
//                 child: CircularProgressIndicator(),
//               ),
//             )
//           : Container(
//               child: Column(
//                 children: [
//                   Container(
//                     padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
//                     color: Color(0x54FFFFFF),
//                     child: Row(
//                       children: [
//                         Expanded(
//                           child: TextField(
//                             controller: searchEditingController,
//                             style: TextStyle(fontSize: 16, color: Colors.white),
//                             decoration: InputDecoration(
//                                 hintText: "search username ...",
//                                 hintStyle: TextStyle(
//                                   color: Colors.white,
//                                   fontSize: 16,
//                                 ),
//                                 border: InputBorder.none),
//                           ),
//                         ),
//                         GestureDetector(
//                           onTap: () {
//                             initiateSearch();
//                           },
//                           child: Container(
//                               height: 40,
//                               width: 40,
//                               decoration: BoxDecoration(
//                                   gradient: LinearGradient(
//                                       colors: [
//                                         const Color(0x36FFFFFF),
//                                         const Color(0x0FFFFFFF)
//                                       ],
//                                       begin: FractionalOffset.topLeft,
//                                       end: FractionalOffset.bottomRight),
//                                   borderRadius: BorderRadius.circular(40)),
//                               padding: EdgeInsets.all(12),
//                               child: Image.network(
//                                 "https://raw.githubusercontent.com/theindianappguy/FlutterChatAppTutorial/master/assets/images/search_white.png",
//                                 height: 25,
//                                 width: 25,
//                               )),
//                         )
//                       ],
//                     ),
//                   ),
//                   userList()
//                 ],
//               ),
//             ),
//     );
//   }
// }

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
      String chatroomId = getChatRoomId(userName, Constants.myName);
      List<String> users = [userName, Constants.myName];

      Map<String, dynamic> chatRoomMap = {
        "users": users,
        "chatroomId": chatroomId
      };

      databaseMethods.createChatRoom(chatroomId, chatRoomMap);
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ConversationScreen(chatroomId)));
    } else {
      print("you canot send msg to urself");
    }
  }

  Widget searchList() {
    return searchSnapshot != null
        ? ListView.builder(
            shrinkWrap: true,
            itemCount: searchSnapshot.documents.length,
            itemBuilder: (context, index) {
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

getChatRoomId(String a, String b) {
  if (a.substring(0, 1).codeUnitAt(0) > b.substring(0, 1).codeUnitAt(0)) {
    return "$b\_$a";
  } else {
    return "$a\_$b";
  }
}

class SearchTile extends StatelessWidget {
  final String userName;
  final String userEmail;
  SearchTile({this.userEmail, this.userName});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 5, vertical: 8),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                userName,
                style: TextStyle(fontSize: 14, color: Colors.white),
              ),
              Text(
                userEmail,
                style: TextStyle(fontSize: 14, color: Colors.white),
              ),
            ],
          ),
          Spacer(),
          Container(
              decoration: BoxDecoration(
                  color: Colors.blue, borderRadius: BorderRadius.circular(30)),
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 18),
              child: Text(
                "message",
                style: TextStyle(color: Colors.white),
              ))
        ],
      ),
    );
  }
}
//        "https://raw.githubusercontent.com/theindianappguy/FlutterChatAppTutorial/master/assets/images/search_white.png",

// userName: searchSnapshot.documents[index].data["name"],
// userEmail: searchSnapshot.documents[index].data["email"]
