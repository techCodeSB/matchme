import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:matchme/constant.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PsychometricController extends ChangeNotifier {
  List<dynamic>? qaData;
  List<dynamic> userAnswer = [];

  void getQuestions() async {
    Uri url = Uri.parse("${Constant.api}psychometric/get");
    final SharedPreferences pref = await SharedPreferences.getInstance();
    final token = pref.getString("token");

    try {
      var req = await http.get(url, headers: {
        "Content-Type": 'application/json',
        "Authorization": "Bearer $token"
      });

      var res = jsonDecode(req.body);
      qaData = res;

      notifyListeners();
    } catch (e) {
      debugPrint("Error fetching user data: $e");
    }
  }

  void nextCall(int index, String answer) {
    Map<dynamic, dynamic> selectedQa = Map.from(qaData![index]);

    var tempStore = [...selectedQa['options']];
    tempStore.removeWhere((item) => item['answer'] != answer);
    selectedQa['options'] = tempStore;

    userAnswer.insert(index, selectedQa);
    notifyListeners();
  }

  Future<bool> submit(int index, String answer) async {
    nextCall(index, answer);

    Uri url = Uri.parse("${Constant.api}psychometric/add");
    final SharedPreferences pref = await SharedPreferences.getInstance();
    final token = pref.getString("token");

    try {
      var req = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "token": token,
          "questionAnswer": userAnswer,
        }),
      );

      // var res = jsonDecode(req.body);
      if (req.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      debugPrint("Error fetching user data: $e");
      return false;
    }
  }
}
