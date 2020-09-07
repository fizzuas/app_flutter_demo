import 'dart:async';

import 'package:flutter/material.dart';

class MyDialogWidget extends StatefulWidget {
  @override
  MyDialogWidgetState createState() => MyDialogWidgetState();
}

StateSetter ss;
int mDialogState = 0;

class MyDialogWidgetState extends State<MyDialogWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          FlatButton(
            color: Colors.grey,
            onPressed: () {
              // showTextDialog(context);
              _showDialogWithStatefulBuilder(context);
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
