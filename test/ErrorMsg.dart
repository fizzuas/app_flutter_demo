enum ErrorMsg {
  Run_OK, //正常
  Run_return_OK, //不上报错误

  Sensor0_Error, //传感器X检测错误
  Sensor1_Error, //传感器Y检测错误
  Sensor2_Error, //传感器Z检测错误
  Motor0_Error, //电机X故障
  Motor1_Error, //电机Y故障
  Motor2_Error, //电机Z故障

  GetAxes_OverError, //未检测到目标  8
  GetAxes_LessError, // 电机运行错误
  MotorCollision_back, // 电机运行错误

  tanzhenCollision_Error, //探针碰撞错误  B
  XiDaoCollision_Error, //铣刀碰撞错误
  HobbingProbeLevel_Error, // 探针铣刀校平错误
  key_Error, //钥匙错误

  //  以上为电机运行检查错误
  key_widthError, //切割的钥匙宽度错误   F
  KeyCut_XAxesError, //钥匙切割X轴坐标错误
  KeyCut_YAxesError, //钥匙切割Y轴坐标错误
  Rec_KeydataError, //App发送数据错误
  Copy_Key_Error, //钥匙复制失败
  fixture_surface_Error, //夹具面错误
  BLDC_RMP_Error, // 主轴电机转速错误  15
  Spi_Flash_Error, // Spi Flash 错误
  Motor_Test_Error, // 电机测试命令
  knife_R_Error, // 铣刀直径错误
  TimeOut_Error, // 超时错误
  EMTG97_Error, // EMTG97错误  1A

  MotorReset_Error, //铣刀探针没有调平
  knife_d_toolarge, //1C
  keyCut_set_timeout, //1D

  fixture_Error, // 夹具错误  30
  keyLay_Error, //钥匙位置放置错误
  keyNull_Error, //未检测到钥匙
  keythickness_Error, //钥匙厚度错误
  width_BigSmall, //钥匙太宽或太窄
  FixtureKnife_Error, // 夹具或铣刀错误，请更换夹具或短铣刀
  tanzhenHigh_Error, // 请调节探针高于铣刀
  jiaozhunkuaiNull_Error, // 未找到校准块
  jiaozhunkuai_Error, // 校准块位置错误
}

extension ErrorMsgExtension on ErrorMsg {
  String get cn => [
        "正常",
        "不上报错误",

        "传感器X检测错误",
        "传感器Y检测错误",
        "传感器Z检测错误",
        "电机X故障",
        "电机Y故障",
        "电机Z故障",

        "检查钥匙边缘溢出",
        "检查钥匙边缘过短",
        "电机运行错误",

        "探针碰撞错误",
        "铣刀碰撞错误",
        "探针铣刀校平错误",
        "钥匙错误",

        //  以上为电机运行检查错误
        "切割的钥匙宽度错误",
        "钥匙切割X轴坐标错误",
        "钥匙切割Y轴坐标错误",
        "App发送数据错误",
        "钥匙复制失败",
        "夹具面错误",
        "主轴电机转速错误",
        "Spi Flash 错误",
        "电机测试命令错误",
        "铣刀直径错误",
        "超时错误",
        "EMTG97错误",

        "铣刀探针没有调平",
        "铣刀直径过大",
        "钥匙放置超时",

        "夹具错误",
        "钥匙位置放置错误",
        "未检测到钥匙",
        "钥匙厚度错误",
        "钥匙太宽或太窄",
        "夹具或铣刀错误，请更换夹具或短铣刀",
        "请调节探针高于铣刀",
        "未找到校准块",
        "校准块位置错误",
      ][this.index];
}
