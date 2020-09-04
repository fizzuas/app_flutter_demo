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
        body: new MyBody(),
      ),
    );
  }
}

class MyBody extends StatefulWidget {
  @override
  MyBodyState createState() => MyBodyState();
}

StateSetter ss;
int mDialogState = 0;

class MyBodyState extends State<MyBody> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          FlatButton(
            color: Colors.grey,
            onPressed: () {
              showTextDialog(context);
            },
          ),
        ],
      ),
    );
  }
}

Future<bool> showTextDialog(BuildContext context) {
  var sb = StatefulBuilder(
    builder: (ctx, state) {
      ss = state;

      if (mDialogState == 0) {
        return Center(
          child: Container(
            child: Column(
              children: <Widget>[
                FlatButton(
                  color: Colors.grey,
                  onPressed: () {
                    onFlatButClick();
                  },
                ),
              ],
            ),
          ),
        );
      } else {
        return Center(
          child: Container(
            child: Column(
              children: <Widget>[
                FlatButton(
                  color: Colors.red,
                  onPressed: () {
                    onFlatButClick();
                  },
                ),
              ],
            ),
          ),
        );
      }
    },
  );
  return showDialog(context: context, builder: (ctx) => sb);
}

void onFlatButClick() {
  print("onFlatButton click");
  ss(() {
    mDialogState = (mDialogState + 1) % 2;
  });
}

_showDialogWithStatefulBuilder(BuildContext context) {
  var progress = 0.0;
  StateSetter ss;
  Timer.periodic(Duration(milliseconds: 300), (timer) {
    progress += 0.1;
    if (ss != null) {
      ss(() {});
    }
    if (progress >= 1) {
      timer.cancel();
      ss = null;
    }
  });
  var sb = StatefulBuilder(
    builder: (ctx, state) {
      ss = state;
      return Center(
        child: Container(
          height: 40,
          child: LinearProgressIndicator(
            backgroundColor: Colors.white,
            value: progress,
          ),
        ),
      );
    },
  );
  showDialog(context: context, builder: (ctx) => sb);
}
