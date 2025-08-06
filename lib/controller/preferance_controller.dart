import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:matchme/controller/splash_controller.dart';
import 'package:matchme/screen/main_page.dart';
import 'package:matchme/widgets/my_snackbar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../constant.dart';
import '../screen/photo_upload.dart';
import '../widgets/preferance/location_selector.dart';
import '../widgets/preferance/relegion_selector.dart';
import '../widgets/preferance/marrital_selector.dart';
import '../widgets/preferance/income_selector.dart';
import '../widgets/preferance/familybg_selector.dart';
import '../widgets/preferance/education_selector.dart';
import '../widgets/preferance/height_selector.dart';
import '../widgets/preferance/age_selector.dart';

class PreferanceController extends ChangeNotifier {
  // ScrollController to control the scroll of the question list
  final ScrollController scrollController = ScrollController();
  bool prefUpdate = false;
  Map<String, String> agePref = {};
  String height = "";
  String education = "";
  String familyBg = "";
  String personalIncome = "";
  String marriageStatus = "";
  List<String> relegion = [];
  String location = "";

  // if done is true show continue button;
  bool isDone = false;

  // All Question set here
  List<Map<String, dynamic>> preferencesQ = [
    {
      'content':
          "What is the minimum height preferred? (Height is a physical attribute that may or may not define your compatiblity)",
      "type": "system",
    },
    {
      'content': const HeightSelector(),
      "type": "user",
    },
    {
      "content": "What is the preferred education qualification?",
      "type": "system",
    },
    {
      "content": const EducationSelector(),
      "type": "user",
    },
    {
      "content": "Preferred family background?",
      "type": "system",
    },
    {
      "content": const FamilybgSelector(),
      "type": "user",
    },
    {
      "content": "What is the income preferred?",
      "type": "system",
    },
    {
      "content": const IncomeSelector(),
      "type": "user",
    },
    {
      "content": "What is the preferred marital status of your partner?",
      "type": "system",
    },
    {
      "content": const MarritalSelector(),
      "type": "user",
    },
    {
      "content": "What is the relegions you are open to",
      "type": "system",
    },
    {
      "content": const RelegionSelector(),
      "type": "user",
    },
    {
      "content": "What is the preferred location?",
      "type": "system",
    },
    {
      "content": const LocationSelector(),
      "type": "user",
    },
  ];

  // In Ui display this value
  List<Map<String, dynamic>> renderQ = [
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

  //
  void resetRederQ() {
    renderQ = [
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

    notifyListeners();
  }

  //
  void scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (scrollController.hasClients) {
        scrollController.animateTo(
          scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  // Get preferance and push to renderQ using index number;
  void nextIndex(index) {
    if (!renderQ.contains(preferencesQ[index])) {
      renderQ.add(preferencesQ[index]);
      Timer(const Duration(milliseconds: 900), () {
        renderQ.add(preferencesQ[index + 1]);

        scrollToBottom();
        notifyListeners();
      });
    }

    notifyListeners();
  }

  // Set true when all questions are answered;
  void setIsDone() {
    isDone = true;
    notifyListeners();
  }

  // Add Preferance ;
  void registerPreferance(ctx) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    var token = pref.getString("token");
    Uri url = Uri.parse("${Constant.api}preferance/add");
    Uri url2 = Uri.parse("${Constant.api}users/update");
    var getStatus = await SplashController.getSteps();
    var status = getStatus['registration_status'];

    Map<String, dynamic> data = {
      "token": token,
      "age_preference": agePref,
      "height_preference": height,
      "education_preference": education,
      "family_background_preference": familyBg,
      "personal_income_preference": personalIncome,
      "marriage_status_preference": marriageStatus,
      "religion_preference": relegion,
      "preferred_location": location,
      "update": prefUpdate
    };

    try {
      // Make API call to register preference
      var req = await http.post(
        url,
        body: jsonEncode(data),
        headers: {"Content-Type": "application/json"},
      );

      // API call for update screen status;
      var req2 = await http.post(
        url2,
        body: jsonEncode({
          "token": token,
          "registration_step": "9",
        }),
        headers: {"Content-Type": "application/json"},
      );

      if (req.statusCode == 200 && req2.statusCode == 200) {
        if (status == "0") {
          Navigator.push(
            ctx,
            MaterialPageRoute(
              builder: (context) => const PhotoUpload(),
            ),
          );
        } else if (status == "1") {
          Navigator.push(
            ctx,
            MaterialPageRoute(
              builder: (context) => const MainPage(),
            ),
          );
        }
      } else {
        // If API call failed then show error message;
        mySnackBar(ctx, "Something went wrong, try again later.");
      }
    } catch (er) {
      mySnackBar(ctx, "Something went wrong, try again later.");
    }
  }

  Future<void> getData(ctx) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    var token = pref.getString("token");
    Uri url = Uri.parse("${Constant.api}preferance/get");

    try {
      var req = await http.post(
        url,
        body: jsonEncode({"token": token}),
        headers: {"Content-Type": "application/json"},
      );

      if (req.statusCode == 200) {
        var res = jsonDecode(req.body);
        agePref['from'] = res['age_preference']['from'].toString();
        agePref['to'] = res['age_preference']['to'].toString();
        height = res['height_preference'];
        education = res["education_preference"];
        familyBg = res['family_background_preference'];
        personalIncome = res['personal_income_preference'];
        marriageStatus = res['marriage_status_preference'];
        location = res['preferred_location'];
        relegion = (res['religion_preference'] as List<dynamic>)
            .map((e) => e.toString())
            .toList();

        prefUpdate = true;

        notifyListeners();
      } else {
        // If API call failed then show error message;
        mySnackBar(ctx, "Something went wrong, try again later.");
      }
    } catch (er) {
      debugPrint("Error: $er");
      mySnackBar(ctx, "[Preferance:] Something went wrong, try again later.");
    }
  }

  void clearData() {
    prefUpdate = false;
    agePref.clear();
    height = "";
    education = "";
    familyBg = "";
    personalIncome = "";
    marriageStatus = "";
    relegion = [];
    location = "";

    renderQ = [
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

    notifyListeners();
  }
}
