
import 'package:flutter/material.dart';
import 'file:///C:/home/flutter/flutter_app/lib/ui/isolate_download/page_isolate1.dart';
import 'file:///C:/home/flutter/flutter_app/lib/ui/isolate_download/page_isolate2.dart';
import 'package:flutter_app/state_manager/state_manager.dart';
import 'package:flutter_app/ui/alert_view/page_alert.dart';
import 'package:flutter_app/ui/input/SignalAdjustPage.dart';
import 'package:flutter_app/ui/location/page_location.dart';
import 'package:flutter_app/ui/menu/page_main.dart';
import 'package:flutter_app/ui/menu/page_slider.dart';
import 'package:flutter_app/ui/pres/Pres.dart';
import 'package:flutter_app/ui/serial/page_series.dart';
import 'package:flutter_app/ui/shader/page_shader.dart';

class PagerRouter {
  static const String stateManager = '/stateManager';
  static const String pages = '/pages';
  static const String threadUpdate1 = '/threadUpdate';
  static const String threadUpdate2 = '/threadUpdate2';
  static const String inputText = '/input';
  static const String location = '/location';
  static const String slider = '/slider';
  static const String serial = '/serial';
  static const String alert = '/alert';
  static const String pres = '/pres';
  static const String shader = '/shader';
  static final Map<String, WidgetBuilder> routes = {
    stateManager: (context) => StateManager(),
    pages: (context) => HomePager(),
    threadUpdate1: (context) => PageIsolate(),
    threadUpdate2: (context) => PageIsolate2(),
    inputText: (context) =>PageSignalAdjust(),
    location:(context) =>GeoLocatorWidget(),
    slider:(context) =>PageSliderBarPage(),
    serial:(context) => PageSeries(),
    alert:(context) => PageAlert(),
    pres:(context) => PagePres(),
    shader:(context)=>PageShader()
  };
}
