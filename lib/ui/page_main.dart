import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_app/route/router.dart';
import 'package:flutter_app/util/view_size_utils.dart';

class PageMain extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ViewSizeUtils().init(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("flutter 学习"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              _getItem(context, "状态管理", PagerRouter.stateManager),
              _getItem(context, "PageView", PagerRouter.pages),
              _getItem(context, "子线程下载", PagerRouter.threadUpdate1),
              _getItem(context, "输入框", PagerRouter.inputText),
              // _getItem(context, "定位", PagerRouter.location),
              _getItem(context, "seekbar", PagerRouter.slider),
              _getItem(context, "序列化", PagerRouter.serial),
              _getItem(context, "alert", PagerRouter.alert),
              _getItem(context, "pres列表", PagerRouter.pres),
              _getItem(context, "阴影", PagerRouter.shader),
              _getItem(context, "权限", PagerRouter.permission),
              _getItem(context, "引导", PagerRouter.intro),
            ],
          ),
        ),
      ),
    );
  }

  _getItem(BuildContext context, String name, String pushName) {
    return Container(
      alignment: Alignment.center,
      margin: EdgeInsets.only(top: 25),
      child: InkWell(
        onTap: () {
          Navigator.of(context).pushNamed(pushName);
        },
        child: Container(
          width: ViewSizeUtils.getSize(343),
          height: ViewSizeUtils.getSize(42),
          alignment: Alignment.center,
          child: Text(
            name,
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
    );
  }
}