import 'package:flutter/cupertino.dart';

class ViewSizeUtils{
  static double _screenWidth;
  static double _screenHeight;
  static double _ratio;
  static bool _allowFontScaling = false;
  static double _textScaleFactor;
  static double _screenRatio;

  void init(BuildContext context,{double designWidth = 360,bool allowFontScaling = false}){
    MediaQueryData _mediaQueryData = MediaQuery.of(context);
    _screenWidth = _mediaQueryData.size.width;
    _screenHeight = _mediaQueryData.size.height;
    _screenRatio = _screenHeight/_screenWidth;
    _ratio = _screenWidth/designWidth;
    _allowFontScaling = allowFontScaling;
    _textScaleFactor = _mediaQueryData.textScaleFactor;
  }

  static double get getScreenWidth  => _screenWidth;
  static double get getScreenHeight => _screenHeight;
  static double get getScreenRatio => _screenRatio;

  static double getSize(double designSize){
    if(_ratio == null){
      throw Exception("context is null , please call ViewSizeUtils.init(context) first");
    }
    return designSize*_ratio;
  }

  //全局默认不可缩放，但是设置special属性会覆盖全局的默认设置
  static double setSp(double fontSize,{bool special = false}) {
    return special ? getSize(fontSize) : (_allowFontScaling
        ? getSize(fontSize)
        : getSize(fontSize) / _textScaleFactor);
  }
}