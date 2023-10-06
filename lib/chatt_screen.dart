import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

String name = "";

class Chatting_screen extends StatefulWidget {
  final String senderemail;
  final String logginuser;
  Chatting_screen({required this.senderemail, required this.logginuser});

  @override
  State<Chatting_screen> createState() => _Chatting_screenState();
}

class _Chatting_screenState extends State<Chatting_screen> {
  // Future<void> setname() async {
  //   bool exist=false;
  //   await FirebaseFirestore.instance.collection('list').doc(widget.logginuser+widget.senderemail).get().then((doc) {
  //     exist = doc.exists;
  //     name=widget.logginuser+widget.senderemail;
  //   });
  //   if (exist==false){
  //     name=widget.senderemail+widget.logginuser;
  //   }
  //
  // }
  @override
  Widget build(BuildContext context) {
    FirebaseFirestore db = FirebaseFirestore.instance;
    String text = "";
    final control = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.senderemail),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          StreamBuilder(
              stream: db
                  .collection("chatlist")
                  .doc('list')
                  .collection(widget.logginuser + widget.senderemail)
                  .orderBy("time")
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  List<Widget> list = [];
                  var messages = snapshot.data?.docs;
                  for (var message in messages!) {
                    final cloudtext = message.get("message");
                    final cloudsender = message.get("sender");
                    list.add(
                      Container(
                        margin: EdgeInsets.only(top: 10),
                        child: TextColumn(
                            cloudtext, cloudsender == widget.senderemail),
                      ),
                    );
                  }
                  return Expanded(
                    child: ListView(
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                      children: list,
                    ),
                  );
                } else {
                  return Text("getting data");
                }
              }),
          Container(
            color: Color(0xff202C33),
            child: ListTile(
              title: TextField(
                controller: control,
                onChanged: (value) {
                  text = value;
                },
              ),
              trailing: IconButton(
                icon: Icon(Icons.send),
                onPressed: () async {
                  DateTime now = DateTime.now();
                  try {
                    await db
                        .collection("chatlist")
                        .doc('list')
                        .collection(widget.logginuser + widget.senderemail)
                        .add({
                      'sender': widget.senderemail,
                      "message": text,
                      "time": now.toString()
                    });
                    await db
                        .collection("chatlist")
                        .doc('list')
                        .collection(widget.senderemail + widget.logginuser)
                        .add({
                      'sender': widget.senderemail,
                      "message": text,
                      "time": now.toString()
                    });
                    await db
                        .collection("friendlist")
                        .doc(widget.senderemail)
                        .collection("list")
                        .doc(widget.logginuser)
                        .set({"email": widget.logginuser, "time": now});
                    await db
                        .collection("friendlist")
                        .doc(widget.logginuser)
                        .collection("list")
                        .doc(widget.senderemail)
                        .set({"email": widget.senderemail, "time": now});
                    control.clear();
                    control.clearComposing();
                  } catch (e) {
                    print('adding text error');
                  }
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}

class TextColumn extends StatelessWidget {
  final cloudtext;
  final cloudsender;
  TextColumn(this.cloudtext, this.cloudsender);
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment:
          cloudsender ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        Material(
          borderRadius: cloudsender
              ? BorderRadius.only(
                  topLeft: Radius.circular(30),
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30))
              : BorderRadius.only(
                  topRight: Radius.circular(30),
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30)),
          elevation: 5,
          color: cloudsender ? Color(0xff005C4B) : Color(0xff202C33),
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            child: Text(
              cloudtext.toString(),
              style: TextStyle(fontSize: 25),
            ),
          ),
        ),
      ],
    );
    ;
  }
}

// BorderRadius.only(
// topLeft: Radius.circular(30),
// bottomLeft: Radius.circular(30),
// bottomRight: Radius.circular(30)
