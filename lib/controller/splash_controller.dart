import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:matchme/screen/dashboard.dart';
import 'package:matchme/screen/opening.dart';
import '../screen/login.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../constant.dart';

import '../screen/personal_fst_details.dart';
import '../screen/personal_sec_details.dart';
import '../screen/personal_trd_details.dart';
import '../screen/get_started.dart';
import '../screen/family_details.dart';
import '../screen/qualification_details.dart';
import '../screen/work_details.dart';
import '../screen/more_question_next.dart';
import '../screen/preference.dart';
import '../screen/photo_upload.dart';
import '../screen/goto_profile.dart';
import '../screen/lifestyle_1.dart';
import '../screen/lifestyle_2.dart';
import '../screen/lifestyle_3.dart';
import '../screen/lifestyle_4.dart';
import '../screen/lifestyle_5.dart';
import '../screen/introduction.dart';

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

  // Dicision function and login function call this function;
  static void checkSteps(ctx) async {
    var stepsAndStatus = await getSteps();
    var status = stepsAndStatus['registration_status'];
    var steps = stepsAndStatus['registration_step'];
    List<Widget> screens = const [
      GetStarted(),
      PersonalFstDetails(),
      PersonalSecDetails(),
      PersonalTrdDetails(),
      FamilyDetails(),
      QualificationDetails(),
      WorkDetails(),
      Lifestyle1(),
      Lifestyle2(),
      Lifestyle3(),
      Lifestyle4(),
      Lifestyle5(),
      Introduction(),
      MoreQuestionNext(),
      Preference(),
      PhotoUpload(),
      GotoProfile(),
    ];

    debugPrint("[SplashController]: $steps");
    debugPrint("[SplashController]: $status");
    
    // Registration not complete;
    if (status == "0") {
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
      Navigator.of(ctx).pushReplacement(
        MaterialPageRoute(builder: (ctx) => const Dashboard()),
      );
    }
  }

  // Make dicision here
  // ==================
  static void decision(ctx) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    // pref.remove("token");

    // If Opening
    if (pref.getBool("opening") == null) {
      Navigator.of(ctx).pushReplacement(
        MaterialPageRoute(builder: (ctx) => const Opening()),
      );
      return;
    }

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

  // Opening Screen Function;
  static void setOpeningStatus(ctx) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();

    // Set Opening Status;
    if (pref.getBool("opening") == null) {
      pref.setBool("opening", true);

      decision(ctx);
    }
  }
}
