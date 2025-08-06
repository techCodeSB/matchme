import 'package:flutter/material.dart';
import 'package:matchme/controller/preferance_controller.dart';
import 'package:matchme/controller/profile_controller.dart';
import 'package:provider/provider.dart';

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


  // When reload all data call
  static void reload(ctx){
    Provider.of<ProfileController>(ctx, listen: false).getUserData(ctx);
    Provider.of<ProfileController>(ctx, listen: false).setData();
    Provider.of<PreferanceController>(ctx, listen: false).getData(ctx);
    
  }
}
