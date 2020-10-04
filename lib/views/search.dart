import 'package:FP/services/database.dart';
import 'package:FP/widgets/widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

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

  // createChatroomAndStartConversation(String userName) {
  //   List<String> users = [
  //     userName,
  //   ];
  //   databaseMethods.createChatRoom(chatRoomId, chatRoomMap);
  // }

  Widget searchList() {
    return searchSnapshot != null
        ? ListView.builder(
            shrinkWrap: true,
            itemCount: searchSnapshot.documents.length,
            itemBuilder: (context, index) {
              return SearchTile(
                  userName: searchSnapshot.documents[index].data["name"],
                  userEmail: searchSnapshot.documents[index].data["email"]);
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
