import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_app/base/_base_widget.dart';
import 'package:flutter_app/ui/title/common_titleview.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PagePres extends StatefulWidget {
  @override
  _PagePresState createState() => _PagePresState();
}

class _PagePresState extends BaseWidgetState<PagePres> {
  @override
  void initData() {}

  @override
  Widget initTitleView() {
    return CommonTitleView(titleName: "");
  }

  @override
  Widget setPageLayout(BuildContext context) {
    return Container(
        child: Column(
      children: [
        FlatButton(
            onPressed: () async {
              SharedPreferences prefs = await SharedPreferences.getInstance();
              List<String> newList = prefs.getStringList("ids");
              if (newList == null) {
                newList = new List<String>();
              }
              newList.add("2");
              prefs.setStringList("ids", newList);
            },
            child: Text("插入")),
        FlatButton(
            onPressed: () async {
              SharedPreferences prefs = await SharedPreferences.getInstance();

              print("读取" + prefs.getStringList("ids").toString());
            },
            child: Text("读"))
      ],
    ));
  }
}
