import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_app/ColumnSection.dart';
import 'package:flutter_app/GestureDemo.dart';
import 'package:flutter_app/custom/CustomView.dart';
import 'package:flutter_app/state.dart';
import 'package:flutter_app/util/_constants.dart';
import 'package:flutter_app/util/view_size_utils.dart';
import 'package:flutter_stetho/flutter_stetho.dart';
import 'ContainerDemo.dart';
import 'MyListView.dart';
import 'Tabs.dart';
import 'KeyMap.dart';
import 'custom/CustomText.dart';
import 'custom/RoateText.dart';
import 'db/db_ui.dart';
import 'dialog/DialogProgress.dart';
import 'dialog/DialogUpdateState.dart';
import 'dialog/input_dialog.dart';

void main() {
  Stetho.initialize();
  runApp(new MyAPP());
}

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
        body: new DBContainer(),
      ),
    );
  }
}
