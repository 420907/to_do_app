import 'package:flutter/material.dart';

abstract class BaseState<T extends StatefulWidget> extends State<T>{

  final scaffoldState=GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context){
    return Scaffold(
      key: scaffoldState,
      appBar: getAppbar(),
      body: SafeArea(child: Container(
        padding: getContainerPadding(),
        child: Stack(
          children: [
            ...mainLayout()
          ],
        ),
      )),
    );
  }

  getAppbar()=>null;
  List<Widget> mainLayout()=>null;
  getContainerPadding()=>EdgeInsets.all(0.0);
}