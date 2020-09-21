import 'package:flutter/cupertino.dart';

class ViewSizeUtils{
  MediaQueryData _mediaQueryData;
  double _screenWidth;
//  double _screenHeight;
  static double _ratio;

  void init(BuildContext context,{double designWidth = 360}){
    _mediaQueryData = MediaQuery.of(context);
    _screenWidth = _mediaQueryData.size.width;
//    _screenHeight = _mediaQueryData.size.height;
    _ratio = _screenWidth/designWidth;
  }

  static double getSize(double designSize){
    return designSize*_ratio;
  }
}