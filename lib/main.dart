import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_app/ColumnSection.dart';
import 'package:flutter_app/GestureDemo.dart';
import 'package:flutter_app/custom/CustomView.dart';
import 'package:flutter_app/route/router.dart';
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
import 'dialog/DialogProgress.dart';
import 'dialog/DialogUpdateState.dart';
import 'dialog/input_dialog.dart';

final RouteObserver<PageRoute> routeObserver = RouteObserver();
void main() {
  // Stetho.initialize();
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
      home: new Page(),
      // 路由拦截！
      onGenerateRoute: (RouteSettings settings) {
        final String pageName = settings.name;
        print("pageName=$pageName");
        final Function pageBuilder = Router.routes[pageName];
        if (settings.arguments != null) {
          return MaterialPageRoute(
              settings: RouteSettings(name: pageName),
              builder: (context) =>
                  pageBuilder(context, arguments: settings.arguments));
        } else {
          return MaterialPageRoute(
              settings: RouteSettings(name: pageName),
              builder: (context) => pageBuilder(context));
        }
      },
    );
  }
}
class Page extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ViewSizeUtils().init(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("flutter 学习"),
      ),
      body: Column(
        children: <Widget>[
          Container(
            alignment: Alignment.center,
            margin: EdgeInsets.only(top: 25),
            child: InkWell(
              onTap: () {
                Navigator.of(context).pushNamed(Router.stateManager);
              },
              child: Container(
                width: ViewSizeUtils.getSize(343),
                height: ViewSizeUtils.getSize(42),
                alignment: Alignment.center,
                child: Text(
                  "状态管理",
                  style: TextStyle(
                    fontSize: 16,
                    color: Color.fromARGB(0xff, 0x05, 0x7c, 0xff),
                  ),
                ),
                decoration: new BoxDecoration(
                  //设置四周圆角
                  borderRadius: BorderRadius.all(Radius.circular(21)),
                  //设置四周边框
                  border: new Border.all(
                      width: 1, color: Color.fromARGB(0xff, 0x05, 0x7c, 0xff)),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
