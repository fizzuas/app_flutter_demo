import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_app/base/_constants.dart';
import 'package:flutter_app/isolate/isolate_download.dart';
import 'package:flutter_app/provider/db_progress.dart';
import 'package:flutter_app/route/router.dart';
import 'package:flutter_app/ui/upgrade/upgrade_ui_helper.dart';
import 'package:flutter_app/uplevel/model/uplevel_model.dart';
// import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

String downloadBoxDBTaskID;

class PageIsolate extends StatefulWidget {
  @override
  _PageIsolateState createState() => _PageIsolateState();
}

class _PageIsolateState extends State<PageIsolate> {
  AppProgress _dbProgressProvider;

  @override
  void initState() {
    super.initState();
    print("initState");
    checkUpdate();
  }

  @override
  Widget build(BuildContext context) {
    _dbProgressProvider = Provider.of<AppProgress>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(""),
      ),
      body: Container(
        child: Column(
          children: [
            FlatButton(
              child: Text("跳转"),
              onPressed: () {
                Navigator.of(context).pushNamed(PagerRouter.threadUpdate2);
              },
            ),
            FlatButton(onPressed: (){
              var appVersion="1.6.6";
              var dbVersion="20201213";
              var min="1.4.9";
              showAppProgressDialog(context,title:"提示",installContent: "数据库版本有更新$dbVersion,当前版本数据库必须使用App版本最低$min才可以保证功能正常。\n立即安装App最新版本$appVersion",
                  downloadContent:"数据库版本有更新$dbVersion,当前版本数据库必须使用App版本最低$min才可以保证功能正常。\n正在下载$appVersion" ,isForceUpgrade: false);
            }, child: Text("显示进度"))
          ],

        ),
      ),
    );
  }

  void checkUpdate() async {
    if (downloadBoxDBTaskID == null ||
        !tasks.containsKey(downloadBoxDBTaskID)) {
      bool permissionOK = true;
      // if (Platform.isAndroid) {
      //   var status = await Permission.storage.status;
      //   if (status.isGranted) {
      //     permissionOK = await Permission.storage.request().isGranted;
      //   } else {
      //     permissionOK = await Permission.storage.isGranted;
      //   }
      // }
      // bool needUpgrade = await UploadSystemModel().checkDBUpdate();
      bool needUpgrade=true;
      if (permissionOK && needUpgrade) {
        String url = await UploadSystemModel().getDBUrL();
        String date = url.split("/").last.split("-").last.split(".").first;
        var dbPath = await getDatabasesPath();
        var dbDownloadPath = join(dbPath, dbNameDownload);
        downloadBoxDBTaskID = await isolateDownload(
          url,
          dbDownloadPath,
          taskName: "download box db",
          completed: () async {
            SharedPreferences prefs = await SharedPreferences.getInstance();
            _dbProgressProvider?.progress = 100;
            String date = url.split("/").last.split("-").last.split(".").first;
            print("下载成功，写入db下载版本" + date);
            prefs.setString(Constants.DB_DATE_KEY_DOWNLOAD, date);

            tasks.forEach((key, value) {
              print("task=" + "\t key=" + key + "\t value=" + value.toString());
            });
          },
          error: (String msg) {
            //更新UI
            _dbProgressProvider?.progress = 0;
          },
          progressCallback: (progress) {
            //更新UI
            _dbProgressProvider?.progress = progress;
          },
        );

        //请求2
        // var dbDownloadPath2 = join(dbPath, dbNameDownload2);
        // downloadBoxDBTaskID = await isolateDownload(
        //   url,
        //   dbDownloadPath2,
        //   taskName: "download box db2",
        //   completed: () async {
        //     SharedPreferences prefs = await SharedPreferences.getInstance();
        //     _dbProgressProvider?.progress = 0;
        //     String date = url.split("/").last.split("-").last.split(".").first;
        //     print("下载成功，写入db下载版本" + date);
        //     prefs.setString(Constants.DB_DATE_KEY_DOWNLOAD, date);
        //
        //     tasks.forEach((key, value) {
        //       print("task=" + "\t key=" + key + "\t value=" + value.toString());
        //     });
        //   },
        //   error: (String msg) {
        //     //更新UI
        //     _dbProgressProvider?.progress = 0;
        //   },
        //   progressCallback: (progress) {
        //     //更新UI
        //     _dbProgressProvider?.progress = progress;
        //   },
        // );
      }
    }
  }
}
