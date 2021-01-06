import 'dart:async';
import 'dart:io';
import 'dart:isolate';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/base/_constants.dart';
import 'package:flutter_app/network/api.dart';
import 'package:flutter_app/network/network_manager.dart';
import 'package:flutter_app/provider/progress.dart';
import 'package:flutter_app/provider/upgrade_Info.dart';
import 'package:flutter_app/uplevel/model/uplevel_model.dart';
import 'package:flutter_app/util/common_utils.dart';
import 'package:flutter_app/util/view_size_utils.dart';
import 'package:oktoast/oktoast.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as Path;

class PageIsolate extends StatefulWidget {
  @override
  _PageIsolateState createState() => _PageIsolateState();
}

class _PageIsolateState extends State<PageIsolate> {
  @override
  void initState() {
    super.initState();
    checkUpdate(context);
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
                setState(() {});
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
                  return getDBView();
                } else {
                  return getIsolateView();
                }
              },
              itemCount: 2,
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
              child: FutureBuilder(
                future: UploadSystemModel().checkDBUpdate(),
                builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.hasError) {
                      return Text("");
                    } else {
                      if (snapshot.data) {
                        return Text("");
                      }
                    }
                  }
                  return Text("");
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

  // 创建一个新的 isolate
// ignore: non_constant_identifier_names
  Isolate isolate;

  create_isolate() async {
    final ReceivePort receivePort = ReceivePort();
    // String dbPath = await getDatabasesPath();
    // downloadDBPath = Path.join(dbPath, dbName);
    isolate = await Isolate.spawn(threadTask, receivePort.sendPort);
    receivePort.listen((data) {
      String content = data as String;
      print("$content, time:${DateTime.now()}"); //3.接收子线程的数据
      if (content.startsWith("progress=")) {
        print(data.toString());
      } else if (content == "completed") {
        print("completed!!");
        receivePort.close();
        isolate.kill(priority: Isolate.immediate);
        isolate = null;
      }else if(content.startsWith("error")){
        receivePort.close();
        isolate.kill(priority: Isolate.immediate);
        isolate = null;
      }
    });
    print("Job's requested, time:${DateTime.now()}"); //1.主线程不等待
  }

  void checkUpdate(BuildContext context) async {
    bool permissionOK = true;
    if (Platform.isAndroid) {
      var status = await Permission.storage.status;
      if (status.isUndetermined) {
        permissionOK = await Permission.storage.request().isGranted;
      } else {
        permissionOK = await Permission.storage.isGranted;
      }
    }
    bool needUpgrade = await UploadSystemModel().checkDBUpdate();
    if (permissionOK && needUpgrade) {
      String url = await UploadSystemModel().getDBUrL();
      String date = url.split("/").last.split("-").last.split(".").first;
      if (isolate == null) {
        create_isolate();
      }
    }

    print("pid_main=" + pid.toString());
  }
}

void threadTask(SendPort port) async {
  print("pid=" + pid.toString());
  String downloadUrl =
      "http://www.kydz.online:8188/minidata/mini00-ful-202101051416.bin";
  String downloadDBPath =
      "/data/user/0/com.example.flutter_app/databases/ky_generator.db";

  print("downloadUrl" + downloadUrl);
  print("downloadDBPath" + downloadDBPath);
  var dio = Dio();
  try {
    dio.download(
      downloadUrl,
      downloadDBPath,
      onReceiveProgress: (int count, int total) {
        // print("当前进度=" + (count / total * 100).toStringAsFixed(0) + "%");
        port.send(
            "progress=" + (count / total * 100).toStringAsFixed(0).toString());
        if (count == total) {
          port.send("completed"); //2.子线程完成任务，回报数据
        }
      },
    );
  } on Exception catch (e) {
    print("error" + e.toString());
  }
}
