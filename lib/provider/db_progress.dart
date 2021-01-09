import 'package:flutter/cupertino.dart';

class DBProgress extends ChangeNotifier {
  String _version = "";
  int _progress = 0;

  set progress(int progress) {
    _progress = progress;
    notifyListeners();
  }

  int get progress => _progress;

  set version(String version) {
    _version = version;
    notifyListeners();
  }
}
