import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_app/provider/db_progress.dart';
import 'package:flutter_app/util/_constants.dart';
import 'package:flutter_app/util/view_size_utils.dart';

import 'package:provider/provider.dart';

/// 获取 在 覆盖BoxDB前   监听 APP下载的Dialog
Future<void> showAppProgressDialog(
    BuildContext context, {
      String title,
      String downloadContent = "",
      String installContent = "",
      bool isForceUpgrade = false,
    }) async {
  var sb = StatefulBuilder(builder: (ctx, state) {
    return getProgressWidget(context,
        title: title, downloadContent: downloadContent,installContent:installContent, isForceUpgrade: isForceUpgrade);
  });
  return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) {
        return sb;
      });
}

Widget getProgressWidget(BuildContext context,
    {String title, String downloadContent,String installContent, bool isForceUpgrade}) {
  return WillPopScope(
    onWillPop: () async {
      return false;
    },
    child: Consumer(
        builder: (BuildContext context, AppProgress value, Widget child) {
          if(value.progress<100){
            return  getProgressDialog(context,title: title,downloadContent:downloadContent,isForceUpgrade:isForceUpgrade,value: value);
          }else{
            return getInstallDialog(context,title: title,installContent:installContent,isForceUpgrade:isForceUpgrade);
          }
        }),
  );
}

Widget getInstallDialog(BuildContext context, {String title, String installContent, bool isForceUpgrade}) {
  return Container(
    alignment: Alignment.bottomCenter,
    child: Container(
      width: Constants.screenWidth,
      padding: EdgeInsets.all(36),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(ViewSizeUtils.getSize(16)),
            topRight: Radius.circular(ViewSizeUtils.getSize(16))),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            child: Text(
              title,
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 18),
            ),
          ),
          Container(
              margin: EdgeInsets.only(
                  top: ViewSizeUtils.getSize(24),
                  bottom: ViewSizeUtils.getSize(35)),
              child: Text(
                installContent,
                style: TextStyle(
                    color: Color.fromARGB(0xff, 0xBA, 0xBA, 0xBA),
                    fontSize: 16),
              )),

        getInstallBottom(context,isForceUpgrade)
        ],
      ),
    ),
  );
}

getInstallBottom(BuildContext context,bool isForceUpgrade) {
  if(isForceUpgrade){
    return Container(
      margin: EdgeInsets.only(
          top: ViewSizeUtils.getSize(16),
          bottom: ViewSizeUtils.getSize(22)),
      alignment: Alignment.center,
      child: FlatButton(
        minWidth: ViewSizeUtils.getSize(288),
        height: ViewSizeUtils.getSize(54),
        color: Color(0XFFF4F4F4),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(100)),
        onPressed: () {

        },
        child: Text(
          "确定",
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
              color: Color(0XFF616161)),
        ),
      ),
    );
  }else{
    return Container(
      margin: EdgeInsets.only(
          top: ViewSizeUtils.getSize(16),
          bottom: ViewSizeUtils.getSize(22)),
      alignment: Alignment.center,
      child: Column(
        children: [
          FlatButton(
            minWidth: ViewSizeUtils.getSize(288),
            height: ViewSizeUtils.getSize(54),
            color: Color(0XFFF4F4F4),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(100)),
            onPressed: () {

            },
            child: Text(
              "确定",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Color(0XFF616161)),
            ),
          ),
          Container(
            padding: EdgeInsets.only(top: ViewSizeUtils.getSize(8)),
            child: FlatButton(
              minWidth: ViewSizeUtils.getSize(288),
              height: ViewSizeUtils.getSize(54),
              color: Color(0XFFF4F4F4),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(100)),
              onPressed: () {
                Navigator.of(context).pop(true);
              },
              child: Text(
                "取消",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: Color(0XFF616161)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

Widget getProgressDialog(BuildContext context,{String title, String downloadContent = "", bool isForceUpgrade,AppProgress value}) {
  return Container(
    alignment: Alignment.bottomCenter,
    child: Container(
      width: Constants.screenWidth,
      padding: EdgeInsets.all(36),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(ViewSizeUtils.getSize(16)),
            topRight: Radius.circular(ViewSizeUtils.getSize(16))),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            child: Text(
              title,
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 18),
            ),
          ),
          Container(
              margin: EdgeInsets.only(
                  top: ViewSizeUtils.getSize(24),
                  bottom: ViewSizeUtils.getSize(35)),
              child: Text(
                downloadContent,
                style: TextStyle(
                    color: Color.fromARGB(0xff, 0xBA, 0xBA, 0xBA),
                    fontSize: 16),
              )),
          Padding(
              padding: EdgeInsets.only(
                  left: ViewSizeUtils.getSize(36),
                  right: ViewSizeUtils.getSize(36)),
              child:LinearProgressIndicator(
                backgroundColor: Colors.grey[400],
                valueColor: AlwaysStoppedAnimation(Colors.blue),
                value: value.progress / 100,
              )
          ),
          Container(
              margin: EdgeInsets.only(
                  top: ViewSizeUtils.getSize(24),
                  bottom: ViewSizeUtils.getSize(69)),
              child: Text(
                value.progress.toString() + "%",
                style: TextStyle(
                    color: Color.fromARGB(0xff, 0x61, 0x61, 0x61),
                    fontSize: 17),
              )

          ),
          getDownloadAPPDialog(context,isForceUpgrade),
        ],
      ),
    ),
  );
}

getDownloadAPPDialog(BuildContext context,bool isForceUpgrade) {
  if(isForceUpgrade){
    return Container(height: 0,);
  }else{
    return    Container(
      margin: EdgeInsets.only(
          top: ViewSizeUtils.getSize(16),
          bottom: ViewSizeUtils.getSize(22)),
      alignment: Alignment.center,
      child: FlatButton(
        minWidth: ViewSizeUtils.getSize(288),
        height: ViewSizeUtils.getSize(54),
        color: Color(0XFFF4F4F4),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(100)),
        onPressed: () {
          Navigator.of(context).pop(true);
        },
        child: Text(
          "取消",
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
              color: Color(0XFF616161)),
        ),
      ),
    );
  }

}
