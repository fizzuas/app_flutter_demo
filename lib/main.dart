import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_app/ColumnSection.dart';
import 'package:flutter_app/GestureDemo.dart';
import 'package:flutter_app/custom/CustomView.dart';
import 'package:flutter_app/state.dart';
import 'ContainerDemo.dart';
import 'MyListView.dart';
import 'Tabs.dart';
import 'KeyMap.dart';
import 'custom/CustomText.dart';
import 'custom/RoateText.dart';
import 'dialog/DialogShow.dart';

void main() => runApp(new MyAPP());

class MyAPP extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new MyState<MyApp>();
  }
}

class MyState<MyApp> extends State {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: "ss",
      home: Scaffold(
        appBar: AppBar(
          title: Text("dd"),
        ),
        body: new MyDialogWidget(),
      ),
    );
  }
}

