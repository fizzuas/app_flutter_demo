import 'package:flutter/cupertino.dart';

class UpgradeInfo extends ChangeNotifier {
  bool appNeedUpgrade = false;
  bool boxDbNeedUpgrade = false;

  set appUpgrade(bool upgrade) {
    appNeedUpgrade = upgrade;
    notifyListeners();
  }

  bool get isAppNeedUpgrade => appNeedUpgrade;

  set boxDbUpgrade(bool upgrade) {
    boxDbNeedUpgrade = upgrade;
    notifyListeners();
  }

  bool get isBoxDbNeedUpgrade => boxDbNeedUpgrade;
}
