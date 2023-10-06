import 'package:flutter/material.dart';
class button extends StatelessWidget {
  final String title;
  final void Function() function;
  button({required this.title, required this.function});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top:10,bottom: 10),
      decoration: BoxDecoration(
          color: Color(0xff00A884), borderRadius: BorderRadius.circular(20)),
      child: TextButton(
          onPressed: function,
          child: Text(
            title,
            style: TextStyle(color: Colors.white, fontSize: 20),
          )),
    );
  }
}