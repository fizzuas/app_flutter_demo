import 'package:flutter/material.dart';
import 'package:flutter_app/state_manager/state_manager.dart';
import 'package:flutter_app/ui/pager/page_main.dart';

class Router {
  static const String stateManager = '/stateManager';
  static const String pages = '/pages';
  static final Map<String, WidgetBuilder> routes = {
    stateManager:(context)=>StateManager(),
    pages:(context)=>HomePager()
  };
}
