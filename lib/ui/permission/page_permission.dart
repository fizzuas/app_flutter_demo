import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_app/base/_base_widget.dart';
import 'package:flutter_app/channel/battery_channel.dart';
import 'package:flutter_app/channel/permission_channel.dart';
import 'package:flutter_app/main.dart';
import 'package:flutter_app/route/router.dart';
import 'package:flutter_app/ui/alert_view/easy_alert2.dart';
import 'package:flutter_app/ui/title/common_titleview.dart';
import 'package:flutter_app/util/f_log.dart';
import 'package:flutter_app/util/permission_util.dart';
import 'package:permission_handler/permission_handler.dart';

class PagePermission extends StatefulWidget {
  @override
  _PagePermissionState createState() => _PagePermissionState();
}

class _PagePermissionState extends BaseWidgetState<PagePermission> {
  @override
  Widget initTitleView() {
    return CommonTitleView(
      titleName: "",
    );
  }

  @override
  Widget setPageLayout(BuildContext context) {
    return Container(
      child: FlatButton(
        child: Text("跳转"),
        onPressed: () async {
          request();
        },
      ),
    );
  }

  @override
  void initData() {
    BatteryChannel.initChannels();
    PermissionChannel.initChannels();

    request();
  }

  void request() {
    PermissionUtil.requestPermission(Permission.storage, onGranted: () {
      PermissionUtil.requestPermission(Permission.location, onGranted: () {
        Navigator.of(context).pushNamed(PagerRouter.shader);
      });
    }, onPermanentlyDenied: () {
      EasyAlert2.show(navigatorState.currentContext,
          content: "需要使用内存权限才使用全部功能", showCancel: true, confirmClicked: () {
        ///跳转设置
        PermissionChannel.toAndroidSetting();
      });
    });
  }
}
