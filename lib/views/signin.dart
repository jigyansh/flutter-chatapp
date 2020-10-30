// import 'package:FP/helper/helperfunctions.dart';
import 'package:FP/services/auth.dart';
import 'package:FP/widgets/widget.dart';
import 'package:flutter/material.dart';
import 'dart:ui';

class SignIn extends StatefulWidget {
  final Function toggle;
  SignIn(this.toggle);
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  AuthMethods authMethods = new AuthMethods();
  bool isLoading = false;
  final formKey = GlobalKey<FormState>();

  TextEditingController emailTextEditingController =
      new TextEditingController();
  TextEditingController passwordTextEditingController =
      new TextEditingController();

  signMeIn() {
    if (formKey.currentState.validate()) {
      setState(() {
        isLoading = true;
      });

      authMethods
          .signInWithEmailAndPassword(emailTextEditingController.text,
              passwordTextEditingController.text)
          .then((value) {
        if (value != null) {
          // HelperFunctions.saveUserNameSharedPreference(
          //     emailTextEditingController.text);
        } else {
          setState(() {
            isLoading = false;
          });
        }
      });
    }
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
                height: MediaQuery.of(context).size.height,
                child: Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.symmetric(horizontal: 24),
                  child: Form(
                    key: formKey,
                    child: Column(mainAxisSize: MainAxisSize.min, children: [
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
                            hintText: "email",
                            hintStyle: TextStyle(color: Colors.white54),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.blue),
                            ),
                            enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.white)),
                          )),
                      TextFormField(
                        validator: (val) {
                          return val.length >= 7
                              ? null
                              : "suggest some strong password";
                        },
                        controller: passwordTextEditingController,
                        obscureText: true,
                        style: TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "password",
                            hintStyle: TextStyle(color: Colors.white54),
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.blue)),
                            enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.white))),
                      ),
                      SizedBox(height: 20),
                      GestureDetector(
                        onTap: () {
                          authMethods
                              .resetPass(emailTextEditingController.text);
                        },
                        child: Container(
                          alignment: Alignment.centerRight,
                          child: Text(
                            "Forgot Password?",
                            style: TextStyle(color: Colors.white),
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
                              const Color(0xff007EF4),
                              const Color(0XFF2A75BC)
                            ]),
                            borderRadius: BorderRadius.circular(30)),
                        child: GestureDetector(
                          onTap: () {
                            signMeIn();
                          },
                          child: Text(
                            "Sign In",
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
                          "Sign In With Google",
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                      ),
                      SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Don't have an account?",
                            style: TextStyle(color: Colors.white, fontSize: 17),
                          ),
                          GestureDetector(
                            onTap: () {
                              widget.toggle();
                            },
                            child: Container(
                              padding: EdgeInsets.all(10),
                              child: Text("register",
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
            ),
    );
  }
}
