import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:match_me/screen/family_details.dart';
import 'package:match_me/screen/personal_sec_details.dart';
import 'package:match_me/screen/qualification_details.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../constant.dart';

// Screens;
import '../screen/personal_fst_details.dart';

class RegisterController extends ChangeNotifier {
  // First personal details
  static final TextEditingController fullname = TextEditingController();
  static final TextEditingController nickname = TextEditingController();
  static String gender = "";
  static DateTime? dateOfBirth;

  // Second Personal Details;
  static final TextEditingController country = TextEditingController();
  static final TextEditingController city = TextEditingController();
  static final TextEditingController locality = TextEditingController();
  static final TextEditingController community = TextEditingController();
  static final TextEditingController medical = TextEditingController();
  String nationality = "";
  String religious = "";

  // Family Details;
  static final TextEditingController fathername = TextEditingController();
  static final TextEditingController mothername = TextEditingController();
  static final TextEditingController hometown = TextEditingController();
  static final TextEditingController familyDescription =
      TextEditingController();
  String fatherOccupation = "";
  String motherOccupation = "";
  String noOfSibling = "";
  String familyBackground = "";
  String familyAnualIncome = "";

  // Error message for require fields
  Map<String, bool> errMsg = {
    // For first personal Details
    "fullname": false,
    "gender": false,
    "country": false,
    "city": false,
    "locality": false,
    "nationality": false,
    "religious": false,

    // For family details;
    "fathername": false,
    "mothername": false,
    "hometown": false,
    "description": false,
  };

  void setErrorMsg(data) {
    errMsg = {...errMsg, ...data};
    notifyListeners();
  }

  // update specific field....
  // This is memeber function only not call directly..;
  static Future<dynamic> register(Map<String, dynamic> field) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    final String? token = pref.getString("token");
    final Uri url = Uri.parse("${Constant.api}users/update");
    Map<String, dynamic> data = field;
    data.addAll({"token": token});

    // API calling....
    var req = await http.post(
      url,
      body: jsonEncode(data),
      headers: {"Content-Type": "application/json"},
    );

    // remove in production
    var res = jsonDecode(req.body);
    print("============response===========");
    print(res);

    if (req.statusCode == 200) {
      return {"success": true, "res": res};
    } else {
      return {"success": false, "res": res};
    }
  }

  static void getStarted(ctx) async {
    await register({'registration_step': "1"});
    Navigator.push(
      ctx,
      MaterialPageRoute(
        builder: (ctx) => const PersonalFstDetails(),
      ),
    );
  }

  void personalFstSubmit(ctx) async {
    // Check validation
    if (fullname.text == "" || gender == "") {
      if (fullname.text.trim().isEmpty) {
        setErrorMsg({"fullname": true});
      }
      if (gender.isEmpty) {
        setErrorMsg({"gender": true});
      }

      return;
    }

    var reg = await register({
      "full_name": fullname.text.trim(),
      "nick_name": nickname.text.trim(),
      "gender": gender,
      "dob": dateOfBirth.toString(),
      "registration_step": '2'
    });

    if (reg['success'] == true) {
      Navigator.push(
        ctx,
        MaterialPageRoute(
          builder: (ctx) => const PersonalSecDetails(),
        ),
      );
    } else {
      ScaffoldMessenger.of(ctx).showSnackBar(SnackBar(
        content: Text(reg['res']['error'] ?? reg['res']['err']),
        duration: const Duration(milliseconds: 2000),
        showCloseIcon: true,
      ));
    }
  }

  void personalSecSubmit(ctx) async {
    // Check validation
    if (country.text.isEmpty ||
        city.text.isEmpty ||
        locality.text.isEmpty ||
        nationality.isEmpty ||
        religious.isEmpty) {
      if (country.text.trim().isEmpty) {
        setErrorMsg({"country": true});
      }
      if (city.text.trim().isEmpty) {
        setErrorMsg({"city": true});
      }
      if (locality.text.trim().isEmpty) {
        setErrorMsg({"locality": true});
      }
      if (nationality.isEmpty) {
        setErrorMsg({"nationality": true});
      }
      if (religious.isEmpty) {
        setErrorMsg({"religious": true});
      }

      return;
    }

    var reg = await register({
      "country": country.text.trim(),
      "city": city.text.trim(),
      "locality": locality.text.trim(),
      "nationality": nationality.trim(),
      "religion": religious.trim(),
      "community": community.text.trim(),
      "medical_history": medical.text.trim(),
      "registration_step": '3'
    });

    if (reg['success'] == true) {
      Navigator.push(
        ctx,
        MaterialPageRoute(
          builder: (ctx) => const FamilyDetails(),
        ),
      );
    } else {
      ScaffoldMessenger.of(ctx).showSnackBar(SnackBar(
        content: Text(reg['res']['error'] ?? reg['res']['err']),
        duration: const Duration(milliseconds: 2000),
        showCloseIcon: true,
      ));
    }
  }

  void familySubmit(ctx) async {
    // Check validation
    if (fathername.text.isEmpty ||
        hometown.text.isEmpty ||
        mothername.text.isEmpty ||
        familyDescription.text.isEmpty) {
      if (fathername.text.trim().isEmpty) {
        setErrorMsg({"fathername": true});
      }
      if (mothername.text.trim().isEmpty) {
        setErrorMsg({"mothername": true});
      }
      if (hometown.text.trim().isEmpty) {
        setErrorMsg({"hometown": true});
      }
      if (familyDescription.text.trim().isEmpty) {
        setErrorMsg({"description": true});
      }

      return;
    }

    var reg = await register({
      "father_name": fathername.text.trim(),
      "father_occupation": fatherOccupation.trim(),
      "mother_name": mothername.text.trim(),
      "mother_occupation": motherOccupation.trim(),
      "no_of_siblings": noOfSibling.trim(),
      "family_background": familyBackground.trim(),
      "hometown": hometown.text.trim(),
      "family_anual_income": familyAnualIncome.trim(),
      "family_description": familyDescription.text.trim(),
      "registration_step": '4'
    });

    if (reg['success'] == true) {
      Navigator.push(
        ctx,
        MaterialPageRoute(
          builder: (ctx) => const QualificationDetails(),
        ),
      );
    } else {
      ScaffoldMessenger.of(ctx).showSnackBar(SnackBar(
        content: Text(reg['res']['error'] ?? reg['res']['err']),
        duration: const Duration(milliseconds: 2000),
        showCloseIcon: true,
      ));
    }
  }
}
