import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'chatt_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'add_email.dart';

class Chat_list extends StatefulWidget {
  final loggedinuser;
  Chat_list({this.loggedinuser});
  @override
  State<Chat_list> createState() => _Chat_listState();
}

class _Chat_listState extends State<Chat_list> {
  FirebaseFirestore db = FirebaseFirestore.instance;
  FirebaseAuth auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.loggedinuser),
        leading: IconButton(
          onPressed: () async {
            print(await auth.currentUser?.email);
            await auth.signOut();
            print(await auth.currentUser);
            Navigator.pop(context);
          },
          icon: Icon(Icons.logout),
        ),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            showModalBottomSheet(
              context: context,
              builder: (context) {
                return Add_email(loggedinuser: widget.loggedinuser);
              },
            );
          },
          child: Icon(Icons.add)),
      body: StreamBuilder(
        stream: db
            .collection("friendlist")
            .doc(widget.loggedinuser)
            .collection("list")
            .orderBy("time", descending: true)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<Widget> list = [];
            var messages = snapshot.data?.docs;
            for (var message in messages!) {
              final friendsemail = message.get("email");
              list.add(
                Email_tiles(
                  onpressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext) {
                          return Chatting_screen(
                            senderemail: friendsemail,
                            logginuser: widget.loggedinuser,
                          );
                        },
                      ),
                    );
                  },
                  email: friendsemail,
                ),
              );
            }
            return ListView(
              children: list,
            );
          } else {
            return Text("loading");
          }
        },
      ),
    );
  }
}

class Email_tiles extends StatelessWidget {
  late final email;
  void Function() onpressed;
  Email_tiles({this.email, required this.onpressed});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextButton(
          onPressed: onpressed,
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Expanded(
              flex: 1,
              child: Icon(
                Icons.email,
                color: Colors.white,
              ),
            ),
            Expanded(
              flex: 4,
              child: Text(
                email,
                style: TextStyle(fontSize: 30, color: Colors.white),
              ),
            ),
          ]),
        ),
        Divider(
          thickness: 1,
        ),
      ],
    );
  }
}
