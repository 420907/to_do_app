import 'package:clear_app/base_state.dart';
import 'package:clear_app/util.dart';
import 'package:flutter/material.dart';

class AddToDoPage extends StatefulWidget {
  @override
  _AddToDoPageState createState() => _AddToDoPageState();
}

class _AddToDoPageState extends State<AddToDoPage> {
  TextEditingController toDoController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pop(context, toDoController.text);
      },
      child: Scaffold(
        backgroundColor: HexColor('96003250'),
        body: Container(
            color: Colors.red,
            margin: EdgeInsets.only(top: 100.0),
            child: TextField(
                controller: toDoController,
                decoration: InputDecoration(
                  labelText: "Please enter your task",
                ))),
      ),
    );
  }
}
