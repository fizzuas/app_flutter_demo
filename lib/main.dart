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

void main() => runApp(new MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("ss"),
        ),
        body: Container(
          child: CustomText(),
        ),
      ),
    ));
