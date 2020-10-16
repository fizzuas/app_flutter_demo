import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_app/util/_constants.dart';
import 'package:flutter_app/util/view_size_utils.dart';

class MyDialogWidget extends StatefulWidget {
  @override
  MyDialogWidgetState createState() => MyDialogWidgetState();
}

class MyDialogWidgetState extends State<MyDialogWidget> {
  @override
  Widget build(BuildContext context) {
    Constants.screenWidth = MediaQuery.of(context).size.width;
    Constants.screeHeight = MediaQuery.of(context).size.height;
    ViewSizeUtils().init(context, designWidth: 360);
    return Container(
      child: Column(children: <Widget>[
        FlatButton(
          color: Colors.grey,
          onPressed: () {
            // showTextDialog(context);
            showCutDialog(context);
          },
        ),
      ]),
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
            width: 288,
            height: 272,
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
            width: 288,
            height: 272,
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
  StateSetter ss;
  var progress = 0.0;
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

Future<void> showCutDialog(BuildContext context) async {
  var sb = StatefulBuilder(
    builder: (ctx, state) {
      ss = state;
      if (mDialogState == 0) {
        // 选择
        String imgPath = "images/fo21_a1.png";

        print("imgPath" + imgPath);

        return Center(
            child: Container(
          width: ViewSizeUtils.getSize(288),
          height: ViewSizeUtils.getSize(372),
          color: Colors.white,
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(top: ViewSizeUtils.getSize(16)),
                  child: Text(
                    "请将钥匙胚顺时针旋转至",
                    style: TextStyle(
                        color: Color.fromARGB(0xff, 0xff, 0x74, 0x33),
                        fontSize: 10),
                  ),
                ),
                Container(
                  child: Image.asset(imgPath),
                  width: ViewSizeUtils.getSize(200),
                  height: ViewSizeUtils.getSize(143),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Container(
                      width: ViewSizeUtils.getSize(70),
                      height: ViewSizeUtils.getSize(52),
                      child: FlatButton(
                        child: Text(
                          "取消",
                          style: TextStyle(
                            fontSize: 12,
                            color: Color.fromARGB(0xff, 0xb8, 0xb8, 0xb8),
                          ),
                        ),
                        onPressed: () {
                          cancelInChoose();
                        },
                      ),
                    ),
                    Container(
                      width: ViewSizeUtils.getSize(70),
                      height: ViewSizeUtils.getSize(52),
                      child: FlatButton(
                        child: Text(
                          "继续",
                          style: TextStyle(
                            fontSize: 12,
                            color: Color.fromARGB(0xff, 0xff, 0x74, 0x33),
                          ),
                        ),
                        onPressed: () {
                          onGoOn();
                        },
                      ),
                    ),

                  ],
                ),
                Container(
                  width: 200,
                  height: 50,
                  child:  Material(
                    child: TextField(
                      decoration: InputDecoration(),
                    ),
                  ),
                )

              ],
            ),
          ),
        ));
      } else if (mDialogState == 1) {
        //正在切割
        return Center(
            child: Container(
          width: ViewSizeUtils.getSize(288),
          height: ViewSizeUtils.getSize(272),
          color: Colors.white,
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  width: ViewSizeUtils.getSize(50),
                  height: ViewSizeUtils.getSize(50),
                  child: CircularProgressIndicator(
                    backgroundColor: Colors.grey[200],
                    valueColor: AlwaysStoppedAnimation(
                      Color.fromARGB(0xff, 0xff, 0x74, 0x33),
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(ViewSizeUtils.getSize(8)),
                  child: Text(
                    "正在切割...",
                    style: TextStyle(fontSize: 10, color: Colors.grey),
                  ),
                ),
                Container(
                  width: ViewSizeUtils.getSize(80),
                  height: ViewSizeUtils.getSize(30),
                  child: FlatButton(
                    color: Color.fromARGB(0xff, 0xc2, 0xc2, 0xc2),
                    child: Text(
                      "取消",
                      style: TextStyle(fontSize: 12, color: Colors.black),
                    ),
                    onPressed: () {
                      cancel();
                    },
                  ),
                )
              ],
            ),
          ),
        ));
      } else {
        //正在取消
        return Center(
            child: Container(
          width: ViewSizeUtils.getSize(288),
          height: ViewSizeUtils.getSize(272),
          color: Colors.white,
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  width: ViewSizeUtils.getSize(50),
                  height: ViewSizeUtils.getSize(50),
                  child: CircularProgressIndicator(
                    backgroundColor: Colors.grey[200],
                    valueColor: AlwaysStoppedAnimation(
                      Color.fromARGB(0xff, 0xff, 0x74, 0x33),
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(ViewSizeUtils.getSize(8)),
                  child: Text(
                    "正在取消...",
                    style: TextStyle(fontSize: 10, color: Colors.grey),
                  ),
                ),
                Container(
                  width: ViewSizeUtils.getSize(80),
                  height: ViewSizeUtils.getSize(30),
                  child: FlatButton(
                    color: Color.fromARGB(0xff, 0xc2, 0xc2, 0xc2),
                    child: Text(
                      "取消",
                      style: TextStyle(fontSize: 12, color: Colors.black),
                    ),
                    onPressed: () {
                      cancel();
                    },
                  ),
                )
              ],
            ),
          ),
        ));
      }
    },
  );
  return showDialog(context: context, builder: (ctx) => sb);
}

StateSetter ss;
int mDialogState = 0;

void onGoOn() {
  ss(() {
    mDialogState = 0;
  });
}

void cancelInChoose() {
  ss(() {
    mDialogState = 1;
  });
}

void cancel() {
  ss(() {
    mDialogState = 0;
  });
}
