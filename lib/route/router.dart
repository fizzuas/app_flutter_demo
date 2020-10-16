import 'package:flutter/material.dart';
import 'package:flutter_app/state_manager/state_manager.dart';

class Router {
  static const String stateManager = '/stateManager';
  static final Map<String, WidgetBuilder> routes = {
    stateManager:(context)=>StateManager(),
  };
}
