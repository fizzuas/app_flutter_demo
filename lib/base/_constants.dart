
import 'dart:ui';
import 'package:flutter/material.dart';


class Constants {
  static String baseUrl;
  static Color bg_color = Color(0xFFF4F4F4);
  static Color font_hint_color = Color(0xFFBABABA);
  static Color BBBBBB_8 = Color(0XFFB8B8B8);
  static double screenWidth;
  static double screeHeight;

  //CMD
  static const int CMD_GET_ARM_ID = 0x25;
  static const int CMD_GET_MASTER_VERSION = 0x08;
  static const int CMD_GET_SYSTEM_PARAM = 0x1D;
  static const int CMD_SYSTEM_SETTING = 0x0E;

  // System Param
  static const int SYSTEM_PARAM_CUTTER_DIA = 0;
  static const int SYSTEM_PARAM_STEERING_ANGLE = 1;
  static const int SYSTEM_PARAM_FIXTURE_TYPE = 2;
  static const int SYSTEM_PARAM_DEPTH_CUT_COUNT = 3;

  //SP
  static const String SN = "sn";
  static const String ARM_VERSION = "ARM_VERSION";
  static const String MILLING_CUTTER_DIA = "MILLING_CUTTER_DIA";
  static const String DEPTH_CUT_COUNT = "DEPTH_CUT_COUNT";

  //夹具类型
  static const String FIXTURE_TYPE = "FIXTURE_TYPE";
  static const String FIXTURE_TYPE_K1_K2 = "0";
  static const String FIXTURE_TYPE_K4 = "1";

  //小盒子数据库
  static const String DB_DEFAULT = "202012211540";
  static const String DB_DATE_KEY = "db_date";
  static const String BOX_ID = "MB4WPIP";

  //当前使用的boxId
  static const String CURRENT_BOX_ID = "boxId_current";
  static const String CURRENT_BOX_POINTS = "boxPoints_current";



  static var newFunctionList1 = []; //保持在文本的中文内容
  static var newFunctionList2 = []; //被国际化处理的保持在文本的内容



}
