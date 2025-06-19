import 'package:flutter/material.dart';
import '../widgets/age_selector.dart';

class PreferanceController extends ChangeNotifier{
  int nextIndex = 2;
  List<Map<String, dynamic>> preferencesQ = [
    {
      "content":
          "Let’s get to know about your preferences for a suitable match !",
      "type": "system",
    },
    {
      "content": "What is the age you preferred ?",
      "type": "system",
    },
    {
      "content": const AgeSelector(),
      "type": "user",
    }
  ];

  Map<String, String> agePref = {};
  String height = "";
  String education = "";
  String familyBg = "";
  String personalIncome = "";
  String marriageStatus = "";
  List<String> relegion = [];
  String location = "";


}