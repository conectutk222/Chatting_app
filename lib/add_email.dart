import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Add_email extends StatelessWidget {
  final String loggedinuser;
  Add_email({required this.loggedinuser});
  @override
  Widget build(BuildContext context) {
    TextEditingController control = TextEditingController();
    String newemail = "";
    FirebaseFirestore db = FirebaseFirestore.instance;
    return Container(
      color: Color(0xff111B21),
      height: 450,
      child: ListTile(
        title: TextField(
          decoration: InputDecoration(hintText: 'Enter Email addres'),
          controller: control,
          onChanged: (value) {
            newemail = value;
          },
        ),
        trailing: IconButton(
          icon: Icon(Icons.send),
          onPressed: () async {
            DateTime now = DateTime.now();
            try {
              await db
                  .collection("friendlist")
                  .doc(loggedinuser)
                  .collection("list")
                  .doc(newemail)
                  .set({"email": newemail, "time": now});
              await db
                  .collection("friendlist")
                  .doc(newemail)
                  .collection("list")
                  .doc(loggedinuser)
                  .set({"email": loggedinuser, "time": now});
              control.clear();
              control.clearComposing();
              Navigator.pop(context);
            } catch (e) {
              print('adding email to database error');
            }
          },
        ),
      ),
    );
  }
}
