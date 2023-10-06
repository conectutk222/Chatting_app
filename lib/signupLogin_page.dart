import 'package:flutter/material.dart';
import 'components.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'chat_list.dart';
class Signup extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    late String emailAddress;
    late String password;
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            margin: EdgeInsets.only(top: 5, bottom: 5),
            padding: EdgeInsets.all(5),
            decoration: BoxDecoration(
              color: Color(0xff202C33),
              borderRadius: BorderRadius.circular(10),
            ),
            child: TextField(
              style: TextStyle(
                fontSize: 20,
              ),
              onChanged: (value) {
                emailAddress = value;
              },
              textAlign: TextAlign.center,
              decoration: InputDecoration(
                hintStyle: TextStyle(
                  fontSize: 20,
                ),
                hintText: "Enter Email",
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 5, bottom: 5),
            padding: EdgeInsets.all(5),
            decoration: BoxDecoration(
                color: Color(0xff202C33),
                borderRadius: BorderRadius.circular(10)),
            child: TextField(
              obscureText: true,
              style: TextStyle(
                fontSize: 20,
              ),
              onChanged: (value) {
                password = value;
              },
              textAlign: TextAlign.center,
              decoration: InputDecoration(
                hintStyle: TextStyle(
                  fontSize: 20,
                ),
                hintText: "Enter Password",
              ),
            ),
          ),
          button(
            title: "SignUp",
            function: () async {
              try {
                final credential =
                    await FirebaseAuth.instance.createUserWithEmailAndPassword(
                  email: emailAddress,
                  password: password,
                );
                Navigator.pop(context);
              } on FirebaseAuthException catch (e) {
                if (e.code == 'weak-password') {
                  print('The password provided is too weak.');
                } else if (e.code == 'email-already-in-use') {
                  print('The account already exists for that email.');
                }
              } catch (e) {
                print(e);
              }
            },
          ),
        ],
      ),
    );
  }
}

class Login extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    late String emailAddress;
    late String password;
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            margin: EdgeInsets.only(top: 5, bottom: 5),
            padding: EdgeInsets.all(5),
            decoration: BoxDecoration(
              color: Color(0xff202C33),
              borderRadius: BorderRadius.circular(10),
            ),
            child: TextField(
              style: TextStyle(
                fontSize: 20,
              ),
              onChanged: (value) {
                emailAddress = value;
              },
              textAlign: TextAlign.center,
              decoration: InputDecoration(
                hintStyle: TextStyle(
                  fontSize: 20,
                ),
                hintText: "Enter Email",
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 5, bottom: 5),
            padding: EdgeInsets.all(5),
            decoration: BoxDecoration(
                color: Color(0xff202C33),
                borderRadius: BorderRadius.circular(10)),
            child: TextField(
              obscureText: true,
              style: TextStyle(
                fontSize: 20,
              ),
              onChanged: (value) {
                password = value;
              },
              textAlign: TextAlign.center,
              decoration: InputDecoration(
                hintStyle: TextStyle(
                  fontSize: 20,
                ),
                hintText: "Enter Password",
              ),
            ),
          ),
          button(
            title: "SignIn",
            function: () async {
              try {
                final credential =
                    await FirebaseAuth.instance.signInWithEmailAndPassword(
                  email: emailAddress,
                  password: password,
                );
                // print([emailAddress, password]);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (BuildContext) {
                      return Chat_list(
                          loggedinuser:emailAddress
                      );
                    },
                  ),
                );
              } on FirebaseAuthException catch (e) {
                if (e.code == 'user-not-found') {
                  print('No user found for that email.');
                } else if (e.code == 'wrong-password') {
                  print('Wrong password provided for that user.');
                }
                print(e.code);
              }
            },
          ),
        ],
      ),
    );
  }
}
