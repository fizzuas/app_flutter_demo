import 'package:flutter/material.dart';
import 'package:flutter_app/isolate/page_isolate1.dart';
import 'package:flutter_app/isolate/page_isolate2.dart';
import 'package:flutter_app/state_manager/state_manager.dart';
import 'package:flutter_app/ui/input/page_input.dart';
import 'package:flutter_app/ui/pager/page_main.dart';

class PagerRouter {
  static const String stateManager = '/stateManager';
  static const String pages = '/pages';
  static const String threadUpdate1 = '/threadUpdate';
  static const String threadUpdate2 = '/threadUpdate2';
  static const String inputText = '/input';
  static final Map<String, WidgetBuilder> routes = {
    stateManager: (context) => StateManager(),
    pages: (context) => HomePager(),
    threadUpdate1: (context) => PageIsolate(),
    threadUpdate2: (context) => PageIsolate2(),
    inputText: (context) =>PageInput()
  };
}
