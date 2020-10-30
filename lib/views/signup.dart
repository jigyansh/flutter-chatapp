// import 'package:FP/helper/helperfunctions.dart';
import 'package:FP/services/auth.dart';
import 'package:FP/services/database.dart';
import 'package:FP/widgets/widget.dart';
import 'package:flutter/material.dart';

import 'chatRoomsScreen.dart';
import 'dart:ui';

class SignUp extends StatefulWidget {
  final Function toggle;
  SignUp(this.toggle);
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  DatabaseMethods databaseMethods = new DatabaseMethods();
  AuthMethods authMethods = new AuthMethods();
  bool isLoading = false;
  final formKey = GlobalKey<FormState>();

  TextEditingController usernameTextEditingController =
      new TextEditingController();
  TextEditingController emailTextEditingController =
      new TextEditingController();
  TextEditingController passwordTextEditingController =
      new TextEditingController();

  signMeUp() {
    if (formKey.currentState.validate()) {
      Map<String, String> userInfoMap = {
        "name": usernameTextEditingController.text,
        "email": emailTextEditingController.text
      };
      databaseMethods.uploadUserInfo(userInfoMap);

      // HelperFunctions.saveUserLoggedInSharedPreference(true);
      // HelperFunctions.saveUserEmailSharedPreference(
      //     emailTextEditingController.text);
      // HelperFunctions.saveUserNameSharedPreference(
      //     usernameTextEditingController.text);

      setState(() {
        isLoading = true;
      });
    }
    authMethods
        .signUpWithEmailAndPassword(
            emailTextEditingController.text, passwordTextEditingController.text)
        .then((value) {
      if (value != null) {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => ChatRoom()));
      } else {
        setState(() {
          isLoading = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarMain(context),
      body: isLoading
          ? Container(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            )
          : SingleChildScrollView(
              child: Container(
                height: MediaQuery.of(context).size.height - 60,
                alignment: Alignment.center,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 24),
                  child: Column(mainAxisSize: MainAxisSize.min, children: [
                    Form(
                      key: formKey,
                      child: Column(
                        children: [
                          TextFormField(
                            validator: (val) {
                              return val.isEmpty || val.length < 4
                                  ? "enter valid username"
                                  : null;
                            },
                            controller: usernameTextEditingController,
                            style: TextStyle(color: Colors.white),
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "username",
                                hintStyle: TextStyle(color: Colors.white54),
                                focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.blue)),
                                enabledBorder: UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.white))),
                          ),
                          TextFormField(
                            validator: (val) {
                              return val.contains("@gmail.com") &&
                                      emailTextEditingController.text != null
                                  ? null
                                  : "enter valid email";
                            },
                            controller: emailTextEditingController,
                            style: TextStyle(color: Colors.white),
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "email",
                                hintStyle: TextStyle(color: Colors.white54),
                                focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.blue)),
                                enabledBorder: UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.white))),
                          ),
                          TextFormField(
                            obscureText: true,
                            validator: (val) {
                              return val.length < 6
                                  ? "enter strong paswword"
                                  : null;
                            },
                            style: TextStyle(color: Colors.white),
                            controller: passwordTextEditingController,
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "password",
                                hintStyle: TextStyle(color: Colors.white54),
                                focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.blue)),
                                enabledBorder: UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.white))),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20),
                    GestureDetector(
                      onTap: () {
                        signMeUp();
                      },
                      child: Container(
                        alignment: Alignment.center,
                        padding: EdgeInsets.symmetric(vertical: 20),
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                            gradient: LinearGradient(colors: [
                              const Color(0xff007EF4),
                              const Color(0XFF2A75BC)
                            ]),
                            borderRadius: BorderRadius.circular(30)),
                        child: Text(
                          "Sign Up",
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.symmetric(vertical: 20),
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          gradient: LinearGradient(colors: [
                            const Color(0x899999F4),
                            const Color(0XFF2870BC)
                          ]),
                          borderRadius: BorderRadius.circular(30)),
                      child: Text(
                        "Sign Up With Google",
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                    ),
                    SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Already have an account?",
                          style: TextStyle(color: Colors.white, fontSize: 17),
                        ),
                        GestureDetector(
                          onTap: () {
                            widget.toggle();
                          },
                          child: Container(
                            padding: EdgeInsets.all(10),
                            child: Text("Sign In",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 17)),
                          ),
                        )
                      ],
                    ),
                  ]),
                ),
              ),
            ),
    );
  }
}
