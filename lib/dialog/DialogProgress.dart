import 'dart:async';
import 'dart:ffi';

import 'package:flutter/material.dart';

class ProgressDemo extends StatefulWidget {
  ProgressDemo({Key key}) : super(key: key);

  @override
  _ProgressDemoState createState() => _ProgressDemoState();
}


class _ProgressDemoState extends State<ProgressDemo> {
  StateSetter ss;
  double progress = 0.0;
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('flutter progress demo'),
      ),
      body: Container(
        margin: EdgeInsets.only(top: 20),
        alignment: Alignment.topCenter,
        child: FlatButton(
          child: Text('进度'),
          color: Colors.blue,
          onPressed: () {
            progress=0;
            showProgressDialog(context);
            Timer.periodic(Duration(milliseconds: 1000), (timer) {
              (context as Element).markNeedsBuild();
              progress += 0.01;
              if (ss == null) {
                showProgressDialog(context);
              } else {
                ss(() {});
              }
              print("progress" + progress.toString());
              if (progress >= 1) {
                timer.cancel();
              }
            });


            // return showDialog(
            //   context: context,
            //   builder: (context) {
            //     return AlertDialog(
            //       backgroundColor: Colors.white,
            //       title: Text('升级中...'),
            //       content: LinearProgressIndicator(
            //         value: progress,
            //         valueColor: AlwaysStoppedAnimation<Color>(Colors.red),
            //         backgroundColor: Colors.grey,
            //       ),
            //       shape: RoundedRectangleBorder(
            //           borderRadius: BorderRadius.all(Radius.circular(10))),
            //     );
            //   },
            // );
          },
        ),
      ),
    );
  }

   showProgressDialog(BuildContext context) {
    var sb=StatefulBuilder(
      builder: (ctx ,state){
        ss=state;
        return Center(
          child: Container(
            color: Colors.white,
            width: 300,
            height: 10,
            child: LinearProgressIndicator(
              value: progress,
              valueColor: AlwaysStoppedAnimation<Color>(Colors.red),
              backgroundColor: Colors.grey,
            ),
          ),
        );
      },
    );
    showDialog(context: context,builder: (ctx)=>sb);
  }
}
