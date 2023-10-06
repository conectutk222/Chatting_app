import 'package:flutter/material.dart';
import 'components.dart';
import 'signupLogin_page.dart';

class Welcomescreen extends StatelessWidget {
  const Welcomescreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Chatter"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          button(
            title: "SignUp",
            function: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (BuildContext) {
                    return Signup();
                  },
                ),
              );
            },
          ),
          button(
            title: "Login",
            function: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (BuildContext) {
                    return Login();
                  },
                ),
              );
            },
          )
        ],
      ),
    );
  }
}
