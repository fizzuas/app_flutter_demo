import 'package:flutter/cupertino.dart';

class DBProgress extends ChangeNotifier {
  int _progress = 0;

  set progress(int progress) {
    _progress = progress;
    notifyListeners();
  }

  int get progress => _progress;
}
