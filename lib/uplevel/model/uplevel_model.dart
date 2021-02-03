import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/base/_constants.dart';
import 'package:flutter_app/network/api.dart';
import 'package:flutter_app/network/network_connectivity.dart';
import 'package:flutter_app/network/network_manager.dart';
import 'package:flutter_app/uplevel/entity/UploadFileResult.dart';
import 'package:flutter_app/uplevel/entity/app_update_apk_bean.dart';
import 'package:flutter_app/uplevel/entity/bean_upload_result.dart';
import 'package:flutter_app/util/common_utils.dart';
import 'package:flutter_app/util/encrypt_utils.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:install_plugin/install_plugin.dart';

import 'package:http/http.dart' as http;
import 'package:package_info/package_info.dart';
import 'package:sqflite/sqflite.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:xml/xml.dart' as xml;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:path/path.dart';

const String dbName = "ky_generator.db";
const String dbNameDownload = "ky_generator_download.db";
const String dbNameDownload2 = "ky_generator_download2.db";

class UploadSystemModel {
  Future<int> downloadUrl(
      BuildContext context, String dowloadUrl, String savePath) async {
    Response response = await NetworkManager.shared().download(
        dowloadUrl, savePath,
        showProgress: true, options: RequestOptions(baseUrl: Api.ApkHost));
    return response.statusCode;
  }

  /// ARM 主控
  Future<bool> checkARMUpdate(String version) async {
    print("checkARMUpdate__request" + version);
    var upload = UploadFileResult(double.parse(version));
    var jsonStr = upload.toJson(upload).toString();
    var param = await EncryptUtils.encryptJsonStr(jsonStr);
    Response response = await NetworkManager.shared().get(
        Api.findLastBleMasterInfo,
        parameters: {"param": param},
        showLoading: false,
        loadingMessage: "数据加载中...",
        options: RequestOptions(baseUrl: Api.keyMachineBaseUrl));
    print("checkARMUpdate__response" + response.toString());
    if (response == null || response.data["Value"] == null) {
      return false;
    } else
      return true;
  }

  Future<UploadFileResultNetWork> getArmInfo(String param) async {
    Response response = await NetworkManager.shared().get(
        Api.findLastBleMasterInfo,
        parameters: {"param": param},
        showLoading: true,
        loadingMessage: "数据加载中...",
        options: RequestOptions(baseUrl: Api.keyMachineBaseUrl));
    if (response.data["Value"] == null) {
      return null;
    }
    var dataResource = UploadFileResultNetWork.fromJson(response.data["Value"]);
    return dataResource;
  }

  Future<int> downloadArmFile(
      BuildContext context, String downloadUrl, String savePath,
      {CancelToken token,
      ProgressCallback progressCallback,
      DownloadStart start,
      DownloadCompleted completed,
      DownloadCanceled canceled,
      DownloadError error}) async {
    Response response = await NetworkManager.shared().download(
        downloadUrl, savePath,
        showProgress: false,
        options: RequestOptions(
            baseUrl: Api.keyMachineHost, receiveTimeout: 60 * 5 * 1000),
        cancelToken: token,
        onReceiveProgress: progressCallback,
        start: start,
        completed: completed,
        canceled: canceled,
        error: error);
    return response == null ? -1 : response.statusCode;
  }

  ///APP 更新
  Future<String> checkAppUpdate() async {
    if (Platform.isAndroid) {
      PackageInfo packageInfo = await PackageInfo.fromPlatform();
      String version = packageInfo.version;
      String versionStr = version.substring(0, 3);
      String versionJsonStr = '{"Versions":$versionStr}';
      print("checkAppUpdate_requset" + versionJsonStr);
      var encrypt = await EncryptUtils.encryptJsonStr(versionJsonStr);
      Response response;
      response = await NetworkManager.shared().get(Api.findLastBleAppInfo,
          parameters: {"param": encrypt},
          options: RequestOptions(
              // baseUrl:
              // "http://47.111.177.58:9110/WebServices/AppUpdateWebService.svc/",
              baseUrl:
                  "http://www.autorke.cn:9110/WebServices/AppUpdateWebService.svc/",
              receiveTimeout: 10 * 1000),
          showLoading: false);
      if (response == null || response.data["Value"] == null) {
        return null;
      }
      var result = AppUpdateApkBean.fromJson(response.data["Value"]);
      // String decryptData = await EncryptUtils.decryptData(
      //     result.isForceUpdateValue);
      // print("decryptData=" + decryptData);

      if (result != null &&
          result.fileAddress != null &&
          result.fileAddress.isNotEmpty) {
        print("checkAppUpdate__result=" + result.toString());
        return result.fileAddress;
      } else {
        return null;
      }
    } else {
      return null;
    }
  }

  downloadAndInstall(BuildContext context,
      {String url,
      CancelToken token,
      ProgressCallback progressCallback,
      DownloadStart start,
      DownloadCompleted completed,
      DownloadCanceled canceled,
      DownloadError error}) async {
    if (Platform.isIOS) {
      String url =
          'https://apps.apple.com/cn/app/%E9%AB%98%E5%BE%B7%E5%9C%B0%E5%9B%BE-%E7%B2%BE%E5%87%86%E5%9C%B0%E5%9B%BE-%E6%97%85%E6%B8%B8%E5%87%BA%E8%A1%8C%E5%BF%85%E5%A4%87/id461703208?l=en'; // 这是微信的地址，到时候换成自己的应用的地址
      if (await canLaunch(url)) {
        await launch(url);
      } else {
        throw 'Could not launch $url';
      }
    } else {
      String saveDirectory = await CommonUtils.getPhoneLocalPath(context);
      String fileName = "new.apk";
      String saveFilePath = "$saveDirectory/$fileName";
      print("saveFilePath" + saveFilePath);
      String realUrl = url.substring(2);
      Response response =
          await NetworkManager.shared().download(realUrl, saveFilePath,
              showProgress: false,
              options: RequestOptions(
                  // baseUrl: "http://47.111.177.58:9110/",
                  baseUrl: "http://www.autorke.cn:9110/",
                  receiveTimeout: 10 * 60 * 1000),
              cancelToken: token,
              onReceiveProgress: progressCallback,
              start: start,
              completed: completed,
              canceled: canceled,
              error: error);
      if (response != null && response.statusCode == 200) {
        InstallPlugin.installApk(saveFilePath, 'com.kydw.allinoneopp')
            .then((result) {
          print('install apk $result');
        }).catchError((error) {
          print('install apk error: $error');
        });
      }
    }
  }

  void install(BuildContext context) async {
    print('install apk ');
    String saveDirectory = await CommonUtils.getPhoneLocalPath(context);
    String fileName = "new.apk";
    String saveFilePath = "$saveDirectory/$fileName";
    InstallPlugin.installApk(saveFilePath, 'com.kydw.allinoneopp')
        .then((result) {
      print('install apk $result');
    }).catchError((error) {
      print('install apk error: $error');
    });
  }

  /// 小盒子DB 检查 更新  SOAP 通信
  Future<bool> checkDBUpdate() async {
    bool networkUnavailable = await isNetworkUnavailable();
    if (networkUnavailable) {
      EasyLoading.showError("网络访问错误");
      return false;
    }
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String date =
        prefs.getString(Constants.DB_DATE_KEY) ?? Constants.DB_DEFAULT;
    String boxId = Constants.BOX_ID;
    print("check_DB_DATE__request" + date.toString());
    var envelope = '''
<?xml version="1.0" encoding="utf-8"?>
<soap:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">
  <soap:Body>
    <checkDataUpdate xmlns="http://www.autorke.cn/">
      <boxId>${boxId}</boxId>
      <localDataTime>${date}</localDataTime>
    </checkDataUpdate>
  </soap:Body>
</soap:Envelope>
''';
    // var client = http.Client();
    http.Response response;
    try {
      response = await http
          .post('http://www.kydz.online:8188/KYDZMiniWebService.asmx',
              headers: {
                "Content-Type": "text/xml; charset=utf-8",
                "SOAPAction": "http://www.autorke.cn/checkDataUpdate",
                "Host": "www.kydz.online"
              },
              body: envelope)
          .timeout(Duration(milliseconds: 1000 * 5));
    } on Exception catch (e) {
      print(e.toString());
      return false;
    }

    xml.XmlDocument parsedXml = xml.parse(response.body);
    print("checkDBUpdate__response==" + parsedXml.toString());
    final textual = parsedXml.findAllElements("Value");
    if (textual.isNotEmpty) {
      bool needUpdate = textual.toList()[0].text.parseBool();
      print(needUpdate.toString());
      return needUpdate;
    }
    // client.close();
    return false;
  }

  Future<String> getDBUrL() async {
    bool networkUnavailable = await isNetworkUnavailable();
    if (networkUnavailable) {
      EasyLoading.showError("网络访问错误");
      return null;
    }
    String date = await CommonUtils.get(Constants.DB_DATE_KEY,
        defaultValue: Constants.DB_DEFAULT);
    String boxId = Constants.BOX_ID;

    var envelope = '''
<?xml version="1.0" encoding="utf-8"?>
<soap:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">
  <soap:Body>
    <getDownloadUrl xmlns="http://www.autorke.cn/">
      <boxId>MB4WPIP</boxId>
      <localDataTime>202012211540</localDataTime>
    </getDownloadUrl>
  </soap:Body>
</soap:Envelope>
''';
    http.Response response =
        await http.post('http://www.kydz.online:8188/KYDZMiniWebService.asmx',
            headers: {
              "Content-Type": "text/xml; charset=utf-8",
              "SOAPAction": "http://www.autorke.cn/getDownloadUrl",
              "Host": "www.kydz.online"
            },
            body: envelope);

    xml.XmlDocument parsedXml = xml.parse(response.body);
    print("response==" + parsedXml.toString());
    final textual = parsedXml.findAllElements("Value");
    if (textual.isNotEmpty) {
      String url = textual.toList()[0].text;
      print(url);
      return url;
    }
    return null;
  }

  Future<int> downloadBoxDB(
    BuildContext context, {
    String downloadUrl,
    CancelToken token,
    ProgressCallback progressCallback,
    DownloadStart start,
    DownloadCanceled canceled,
    DownloadCompleted completed,
    DownloadError error,
  }) async {
    var dbPath = await getDatabasesPath();
    var docFilePath = join(dbPath, dbName);
    print("savePath" + docFilePath);
    Response response = await NetworkManager.shared().download(
        downloadUrl, docFilePath,
        showProgress: false,
        cancelToken: token,
        start: start,
        canceled: canceled,
        completed: completed,
        onReceiveProgress: progressCallback,
        error: error,
        options: RequestOptions(
            baseUrl: Api.keyMachineHost, receiveTimeout: 10 * 60 * 1000));
    return response == null ? -1 : response.statusCode;
  }
}

extension BoolParsing on String {
  bool parseBool() {
    return this.toLowerCase() == 'true';
  }
}
