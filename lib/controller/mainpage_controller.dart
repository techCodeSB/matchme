import 'package:flutter/material.dart';

class MainpageController extends ChangeNotifier {
  Map<String, double> position = {};
  int currentBottomBarIndex = 0; //Home;
  String? activeIcon;
  double currentPosition = -8.0;

  void setBottomIndex(index) {
    currentBottomBarIndex = index;
    notifyListeners();
  }

  void setActiveIcon(value) {
    activeIcon = value;
    notifyListeners();
  }

  void setPosition(data){
    position = data;
    notifyListeners();
  }

  void updatePosition(String key) {
    currentPosition = position[key] ?? -10.0;
    activeIcon = key; // Set Icons key for changes icon;
    notifyListeners();
  }
}
