import 'dart:io';

import 'package:flutter_app/util/f_log.dart';
import 'package:permission_handler/permission_handler.dart';

typedef OnGranted = void Function();
typedef OnDenied = void Function();
typedef OnPermanentlyDenied = void Function();

class PermissionUtil {
  static void requestPermission(Permission permission,
      {OnGranted onGranted,
      OnDenied onDenied,
      OnPermanentlyDenied onPermanentlyDenied,
      String permanentlyDeniedTip}) async {
    if (Platform.isAndroid) {
      var status = await permission.status;
      _checkAndroidPermission(status, permission,
          onGranted: onGranted, onDenied: onDenied,onPermanentlyDenied: onPermanentlyDenied);
    }
  }

  static void _checkAndroidPermission(
    PermissionStatus status,
    Permission permission, {
    OnGranted onGranted,
    OnDenied onDenied,
    OnPermanentlyDenied onPermanentlyDenied,
  }) async {
    FLog(permission.toString() + "当前权限状态 " + status.toString());
    if (status.isGranted) {
      if (onGranted != null) {
        onGranted();
      }
    } else if (status.isDenied) {
      var statue2 = await permission.request();
      FLog(permission.toString() + "请求权限结果" + statue2.toString());
      if (statue2.isGranted) {
        if (onGranted != null) {
          onGranted();
        }
      } else if (statue2.isDenied) {
        if (onDenied != null) {
          onDenied();
        }
      } else {
        if (onPermanentlyDenied != null) {
          onPermanentlyDenied();
        }
      }
    } else if (status.isPermanentlyDenied) {
      if (onPermanentlyDenied != null) {
        onPermanentlyDenied();
      }
    }
  }
}
