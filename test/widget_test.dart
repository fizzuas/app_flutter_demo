// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_app/ContainerDemo.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_app/main.dart';

import 'EnumDemo.dart';
import 'ErrorMsg.dart';
import 'Pair.dart';

void main() {
  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    // final m = Month.jan;
    // print('value: ${m.value},cn: ${m.cn},eng: ${m.eng}');

    // final msg=ErrorMsg.values[2].cn;
    // print(msg);
    //

    // List<Pair> _list=List<Pair>();
    // _list.add(Pair(500, 1));
    // _list.add(Pair(300, 2));
    // _list.add(Pair(200, 6));
    // _list.add(Pair(100, 1));
    //
    // var s=_list.map((e) => e.last).join("").toString();
    // print(s);

    // List<String> list=List();
    // list.add("1");
    // list.add(null);
    // list.add("2");
    // list.add("");
    // list.add("4");
    //
    //
    // var temp=list.where((element) => (element!=null&&element.isNotEmpty)).toList();
    // print(temp.toString());

    // List<String> list=List();
    // list.add("1");
    // list.add("2");
    // list.add("3");
    // list.add("4");
    // list.add("5");
    //
    // print(list.toString());
    // print(list.reversed.toString());
    // print(list.toString());

    // String whitespace = " 32 FF D5  ";
    // print(whitespace.replaceAll(new RegExp(r"\s\b|\b\s"), ""));

    //
    // List list=[1,2,3,5];
    // print(list.sublist(0,1));//前闭后开
    //
    // List data=List(4);
    // List.copyRange(data, 0, list,0,3);//前闭后开
    // print(data.toString());

    //base64
    String data = "Po+uX9pw7qUFJ3ewPqpEQQ11";
    print(base64.decode(data));
  });
}
