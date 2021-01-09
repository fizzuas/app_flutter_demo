import 'dart:async';
import 'dart:io';
import 'dart:isolate';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/base/_constants.dart';
import 'package:flutter_app/network/api.dart';
import 'package:flutter_app/network/network_manager.dart';
import 'package:flutter_app/provider/db_progress.dart';
import 'package:flutter_app/provider/progress.dart';
import 'package:flutter_app/provider/upgrade_Info.dart';
import 'package:flutter_app/uplevel/model/uplevel_model.dart';
import 'package:flutter_app/util/common_utils.dart';
import 'package:flutter_app/util/view_size_utils.dart';
import 'package:oktoast/oktoast.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../main.dart';


class PageIsolate2 extends StatefulWidget {
  @override
  _PageIsolate2State createState() => _PageIsolate2State();
}

class _PageIsolate2State extends State<PageIsolate2> {
  DBProgress _dbProgressProvider;
  @override
  void initState() {
    super.initState();

  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void deactivate() {
    print("deactivate");
    super.deactivate();
  }

  Widget getIosStyleAppBar(BuildContext context, String title,
      {showBtIcon = true, showHomeIcon = true}) {
    return CupertinoNavigationBar(
        padding: EdgeInsetsDirectional.only(start: 0),
        leading: Material(
          type: MaterialType.circle,
          color: Colors.transparent,
          clipBehavior: Clip.antiAlias,
          child: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              size: ViewSizeUtils.getSize(18),
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        middle: Text(
          title,
          style: TextStyle(fontSize: ViewSizeUtils.setSp(19)),
        ),
        trailing: Text("trailing"));
  }

  Widget getDBView() {
    return ListTile(
        onTap: () async {
          bool needUpgrade = await UploadSystemModel().checkDBUpdate();
          if (needUpgrade) {
            String url = await UploadSystemModel().getDBUrL();
            String date = url.split("/").last.split("-").last.split(".").first;
            CancelToken token = CancelToken();
            int statue = await UploadSystemModel().downloadBoxDB(context,
                downloadUrl: url,
                token: token, progressCallback: (int received, int total) {
              print(
                  "DB下载进度" + (received / total * 100).toStringAsFixed(0) + "%");
              int progress = (received / total * 100).toInt();
              context.read<Progress>().progress = progress;
            }, start: () async {
              await CommonUtils().showProgressDialog(context, cancel: () {
                token.cancel(CANCEL);
                showToast("cancel");
              }, title: "db_upgrade");
              context.read<Progress>().progress = 0;
            }, canceled: () {
              showToast("已取消");
              Navigator.of(context).pop();
            }, completed: () {
              showToast("db_upgrade_suc");
              Navigator.of(context).pop();
            }, error: (String msg) {
              Navigator.of(context).pop();
            });
            if (statue == 200) {
              SharedPreferences prefs = await SharedPreferences.getInstance();
              bool isWriteSuc =
                  await prefs.setString(Constants.DB_DATE_KEY, date);
              if (isWriteSuc) {
                showToast("升级成功");
                //更新红点
                context.read<UpgradeInfo>().boxDbUpgrade = false;
              }
            }
          } else {
            context.read<UpgradeInfo>().boxDbUpgrade = false;
          }
        },
        title: Text(
          "db version",
          style: TextStyle(fontSize: ViewSizeUtils.setSp(14)),
        ),
        contentPadding: EdgeInsets.symmetric(
          horizontal: ViewSizeUtils.getSize(16),
          vertical: ViewSizeUtils.getSize(10),
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: EdgeInsets.only(right: 16, left: 16),
              child: Consumer(
                builder:
                    (BuildContext context, UpgradeInfo value, Widget child) {
                  if (value.isBoxDbNeedUpgrade) {
                    return new Icon(
                      Icons.fiber_manual_record,
                      size: 12,
                      color: Colors.red,
                    );
                  } else {
                    return new Icon(
                      Icons.fiber_manual_record,
                      size: 12,
                      color: Colors.transparent,
                    );
                  }
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 16.0),
              child: FutureBuilder(
                future: _getDBVersion(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.data != null) {
                    return Text(snapshot.data);
                  } else {
                    return Text("");
                  }
                },
              ),
            ),
          ],
        ));
  }

  _getDBVersion() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.get(Constants.DB_DATE_KEY) ?? Constants.DB_DEFAULT;
  }

  @override
  Widget build(BuildContext context) {
    _dbProgressProvider = Provider.of<DBProgress>(context);
    return CupertinoPageScaffold(
      backgroundColor: Colors.white,
      navigationBar: getIosStyleAppBar(context, "设置"),
      child: Material(
        child: Column(
          children: [
            ListView.separated(
              shrinkWrap: true,
              itemBuilder: (context, index) {
                if (index == 0) {
                  return getIsolateView();
                  // return getDBView();
                } else {
                  return getIsolateView();
                }
              },
              itemCount: 1,
              separatorBuilder: (BuildContext context, int index) => Divider(
                height: 0,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget getIsolateView() {
    return ListTile(
        onTap: () async {},
        title: Text(
          "isolate",
          style: TextStyle(fontSize: ViewSizeUtils.setSp(14)),
        ),
        contentPadding: EdgeInsets.symmetric(
          horizontal: ViewSizeUtils.getSize(16),
          vertical: ViewSizeUtils.getSize(10),
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: EdgeInsets.only(right: 16, left: 16),
              child: getProgressView(),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 16.0),
              child: FutureBuilder(
                future: _getDBVersion(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.data != null) {
                    return Text(snapshot.data);
                  } else {
                    return Text("");
                  }
                },
              ),
            ),
          ],
        ));
  }

  getProgressView() {
    if (_dbProgressProvider.progress > 0 && _dbProgressProvider.progress < 100) {
      return Text(
        _dbProgressProvider.progress.toString() + "%",
        style: TextStyle(
            color: Color.fromARGB(0xff, 0x61, 0x61, 0x61), fontSize: 14),
      );
    } else {
      return Text("");
    }
  }
}




