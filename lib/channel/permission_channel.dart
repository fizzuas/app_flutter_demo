
import 'package:flutter/services.dart';

class PermissionChannel{
  static const _permissionChannelName = "com.kydz/permission"; // 1.方法通道名称
  static MethodChannel _permissionChannel;

  static void initChannels() {
    _permissionChannel = MethodChannel(_permissionChannelName); // 2. 实例化一个方法通道
  }

  static toAndroidSetting() async {
    try {
      await _permissionChannel.invokeMethod('toPermissionSetting');
    } on PlatformException catch (e) {
    }

  }
}