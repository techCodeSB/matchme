import 'dart:convert';
import 'package:flutter/material.dart';
import '../screen/login.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../constant.dart';

import '../screen/personal_fst_details.dart';
import '../screen/personal_sec_details.dart';
import '../screen/get_started.dart';
import '../screen/family_details.dart';
import '../screen/qualification_details.dart';
import '../screen/work_details.dart';
import '../screen/more_question_next.dart';
import '../screen/chat_question.dart';
import '../screen/photo_upload.dart';
import '../screen/interest.dart';
import '../screen/goto_profile.dart';

class SplashController {
  static Future<dynamic> getSteps() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    String? token = pref.getString("token");
    Uri url = Uri.parse("${Constant.api}users/get");
    Map<String, dynamic> data = {
      "token": token,
      "fieldsArr": ["registration_status", "registration_step"]
    };

    // MAKE API CALL;
    try {
      var req = await http.post(
        url,
        body: jsonEncode(data),
        headers: {"Content-Type": "application/json"},
      );

      var res = jsonDecode(req.body);
      if (req.statusCode == 200) {
        return res;
      } else {
        return false;
      }
    } catch (e) {
      debugPrint("Something went wrong");
      debugPrint(e.toString());
      return false;
    }
  }

  static void checkSteps(ctx) async {
    var stepsAndStatus = await getSteps();
    var status = stepsAndStatus['registration_status'];
    var steps = stepsAndStatus['registration_step'];
    List<Widget> screens = [
      const GetStarted(),
      const PersonalFstDetails(),
      const PersonalSecDetails(),
      const FamilyDetails(),
      const QualificationDetails(),
      const WorkDetails(),
      const MoreQuestionNext(),
      const ChatQuestion(),
      const PhotoUpload(),
      const Interest(),
      const GotoProfile(),
    ];

    debugPrint(steps);
    debugPrint(status);
    // Registration not complete;
    if (status == "0") {
      debugPrint("run....");
      for (var i = 0; i < screens.length; i++) {
        if (steps == i.toString()) {
          Navigator.of(ctx).pushReplacement(
            MaterialPageRoute(builder: (ctx) => screens[i]),
          );

          break;
        }
      }
      return;
    }
    // Registration complete;
    else {
      //Goto Dashboard code here;
      //
    }
  }

  // Make dicision here
  // ==================
  static void decision(ctx) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    // pref.remove("token");

    // If not Login
    if (pref.getString("token") == null) {
      Navigator.of(ctx).pushReplacement(
        MaterialPageRoute(builder: (ctx) => const Login()),
      );

      return;
    }

    // If Login
    checkSteps(ctx);
  }
}
