import 'dart:convert';

import 'package:flutter_aes_ecb_pkcs5/flutter_aes_ecb_pkcs5.dart';

import 'byte_utils.dart';


class EncryptUtils {
  static final List<int> KEY = [
    0x77,
    0x0a,
    0xf4,
    0xd0,
    0x2d,
    0xf6,
    0x0d,
    0x78,
    0x53,
    0xed,
    0xa9,
    0xd5,
    0xb2,
    0x98,
    0x4f,
    0xde
  ];

  static Future<String> encryptJsonStr(String jsonStr) async {
    var encryptText = await FlutterAesEcbPkcs5.encryptString(
        jsonStr, ByteUtils.intListToHexStringWithoutSpace(KEY));
    var baseEncryptText = base64.encode(ByteUtils.hexString2List(encryptText));

    return baseEncryptText;
  }

  static Future<String> decryptData(String data) async {
      String code=ByteUtils.intListToHexStringWithoutSpace(base64.decode(data));
      return await FlutterAesEcbPkcs5.decryptString(
        code,
        ByteUtils.intListToHexStringWithoutSpace(KEY));
  }
}
