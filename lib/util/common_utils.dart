import 'package:flutter_app/common/alert_view/easy_alert.dart';
import 'package:flutter_app/main.dart';
import 'package:flutter_app/provider/progress.dart';
import 'package:flutter_app/util/view_size_utils.dart';

import 'dart:io';
import 'dart:ui';
import 'package:flutter/material.dart';


// base64库
import 'dart:convert';
import 'dart:ui' as ui;
import 'package:flutter/services.dart';
import 'package:flutter/painting.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';


import '_constants.dart';

typedef DownloadCancelAction = void Function();

class CommonUtils {
  //获取手机目录-文件保存路径
  static Future<String> getPhoneLocalPath(BuildContext context) async {
    final directory = Theme.of(context).platform == TargetPlatform.android
        ? await getExternalStorageDirectory()
        : await getApplicationDocumentsDirectory();
    return directory.path;
  }

  //关闭键盘
  static void closeSoftBoard(BuildContext context) {
    FocusScope.of(context).requestFocus(FocusNode());
  }

  /*
  * Base64加密
  */
  static String encode(String data) {
    var content = utf8.encode(data);
    var digest = base64Encode(content);
    return digest;
  }

  /*
  * Base64解密
  */
  static String decode(String data) {
    List<int> bytes = base64Decode(data);
    // 网上找的很多都是String.fromCharCodes，这个中文会乱码
    //String txt1 = String.fromCharCodes(bytes);
    String result = utf8.decode(bytes);
    return result;
  }

  /*
  * 通过图片路径将图片转换成Base64字符串
  */
  static Future<String> image2Base64(String path) async {
    File file = new File(path);
    List<int> imageBytes = await file.readAsBytes();
    return base64Encode(imageBytes);
  }

  /*
  * 将图片文件转换成Base64字符串
  */
  static Future<String> imageFile2Base64(File file) async {
    List<int> imageBytes = await file.readAsBytes();
    return base64Encode(imageBytes);
  }

  /*
  * 将Base64字符串的图片转换成图片
  */
  static Future<Image> base642Image(String base64Txt) async {
    var decodeTxt = base64.decode(base64Txt);
    return Image.memory(
      decodeTxt,
      width: 100, fit: BoxFit.fitWidth,
      gaplessPlayback: true, //防止重绘
    );
  }

  static Future<ui.Image> getImage(String asset) async {
    ByteData data = await rootBundle.load(asset);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List());
    FrameInfo fi = await codec.getNextFrame();
    return fi.image;
  }

  static save(String key, String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, value);
  }

  static Future<String> get(String key, {String defaultValue}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey(key)) {
      return prefs.getString(key);
    } else {
      return defaultValue;
    }
  }

  static void showSureTipsDialog(String content) {
    var context = navigatorState.currentState.overlay.context;
    EasyAlert.show(context,
        title: "提示", content: content, showCancel: false, confirmText: "确定");
  }

  static void showBottomDialog(BuildContext context, Widget contentWidget) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) =>
            StatefulBuilder(builder: (context, state) {
              return genBottomWidget(contentWidget);
            }));
  }

  static Widget genBottomWidget(Widget contentWidget){
    return WillPopScope(
      onWillPop: ()async{
        return false;
      },
      child: Container(
        alignment: Alignment.bottomCenter,
        child: Container(
          width: Constants.screenWidth,
          padding: EdgeInsets.only(top: ViewSizeUtils.getSize(16),left: ViewSizeUtils.getSize(16),
          right: ViewSizeUtils.getSize(16),bottom: ViewSizeUtils.getSize(56)),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(ViewSizeUtils.getSize(8)),
                topRight: Radius.circular(ViewSizeUtils.getSize(8))),
          ),
          child: contentWidget,
        ),
      ),
    );
  }

  /// 进度条dialog
  Future<void> showProgressDialog(
    BuildContext context, {
    String title,
    DownloadCancelAction cancel,
  }) async {
    var sb = StatefulBuilder(builder: (ctx, state) {
      return getProgressWidget(context, title: title, cancel: cancel);
    });
    return showDialog(
        context: context, barrierDismissible: false, builder: (ctx) => sb);
  }

  Widget getProgressWidget(BuildContext context,
      {DownloadCancelAction cancel, String title}) {
    return WillPopScope(
      onWillPop:() async{
        return false;
      },
      child: Container(
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
                    "upgrade_tip",
                    style: TextStyle(
                        color: Color.fromARGB(0xff, 0xBA, 0xBA, 0xBA),
                        fontSize: 16),
                  )),
              Padding(
                padding: EdgeInsets.only(
                    left: ViewSizeUtils.getSize(36),
                    right: ViewSizeUtils.getSize(36)),
                child: Consumer<Progress>(
                  builder: (BuildContext context, Progress value, Widget child) {
                    return LinearProgressIndicator(
                      backgroundColor: Colors.grey[400],
                      valueColor: AlwaysStoppedAnimation(Colors.blue),
                      value: value.progress / 100,
                    );
                  },
                ),
              ),
              Container(
                  margin: EdgeInsets.only(
                      top: ViewSizeUtils.getSize(24),
                      bottom: ViewSizeUtils.getSize(69)),
                  child: Consumer<Progress>(
                    builder:
                        (BuildContext context, Progress value, Widget child) {
                      return Text(
                        value.progress.toString() + "%",
                        style: TextStyle(
                            color: Color.fromARGB(0xff, 0x61, 0x61, 0x61),
                            fontSize: 17),
                      );
                    },
                  )),
              Container(
                margin: EdgeInsets.only(
                    top: ViewSizeUtils.getSize(16),
                    bottom: ViewSizeUtils.getSize(22)),
                alignment: Alignment.center,
                child: FlatButton(
                  minWidth: ViewSizeUtils.getSize(288),
                  height: ViewSizeUtils.getSize(54),
                  color: Color(0XFFF4F4F4),
                  shape: RoundedRectangleBorder(borderRadius:BorderRadius.circular(100)),
                  onPressed: () {
                    //取消下载
                    if (cancel != null) {
                      cancel();
                    }
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
        ),
      ),
    );
  }


  //获取键盘高度
  // @override
  // void didChangeMetrics() {
  //   final renderObject = context.findRenderObject();
  //   final renderBox = renderObject as RenderBox;
  //   final offset = renderBox.localToGlobal(Offset.zero);
  //   final widgetRect = Rect.fromLTWH(
  //     offset.dx,
  //     offset.dy,
  //     renderBox.size.width,
  //     renderBox.size.height,
  //   );
  //   final keyboardTopPixels = window.physicalSize.height - window.viewInsets.bottom;
  //   final keyboardTopPoints = keyboardTopPixels / window.devicePixelRatio;
  //   double keyH = widgetRect.bottom - keyboardTopPoints;
  //   print('得到键盘高度$keyH');
  // }
}
