import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../screen/family_details.dart';
import '../screen/more_question_next.dart';
import '../screen/personal_sec_details.dart';
import '../screen/preference.dart';
import '../screen/qualification_details.dart';
import '../screen/work_details.dart';
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

  // Qualification Details;
  String qualification = "";
  static final TextEditingController schoolName = TextEditingController();
  static final TextEditingController ugCollegeName = TextEditingController();
  static final TextEditingController pgCollegeName = TextEditingController();
  static final TextEditingController phdCollegeName = TextEditingController();
  static final TextEditingController otherDetails = TextEditingController();
  static final TextEditingController highestDegree = TextEditingController();

  // Work Details
  String profession = "";
  static final TextEditingController industry = TextEditingController();
  static final TextEditingController orgnization = TextEditingController();
  static final TextEditingController designation = TextEditingController();
  static final TextEditingController turnover = TextEditingController();
  static final TextEditingController website = TextEditingController();
  String anualIncome = "";

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

    // qualification;
    "qualification": false,
    "schoolName": false,
    "ugCollegeName": false,
    "pgCollegeName": false,
    "phdCollegeName": false,
    "highestDegree": false,

    // Work Details;
    "profession": false,
    "industry": false,
    "orgnization": false,
    "designation": false,
    "anualIncome": false,
    "turnover": false
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

//
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

//
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

  //
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

  //
  void qualificationSubmit(ctx) async {
    // Check validation
    if (schoolName.text.isEmpty ||
        ((qualification == "graduation" ||
                qualification == "post-grad" ||
                qualification == "pd.d") &&
            ugCollegeName.text == "") ||
        (qualification == "post-grad" ||
            qualification == "pd.d" && pgCollegeName.text == "") ||
        (qualification == "pd.d" && phdCollegeName.text == "") ||
        highestDegree.text == "" ||
        qualification == "") {
      if (schoolName.text.trim().isEmpty) {
        setErrorMsg({"schoolName": true});
      }
      if (ugCollegeName.text.trim().isEmpty) {
        setErrorMsg({"ugCollegeName": true});
      }
      if (pgCollegeName.text.trim().isEmpty) {
        setErrorMsg({"pgCollegeName": true});
      }
      if (highestDegree.text.trim().isEmpty) {
        setErrorMsg({"highestDegree": true});
      }
      if (phdCollegeName.text.trim().isEmpty) {
        setErrorMsg({"phdCollegeName": true});
      }
      if (qualification.trim().isEmpty) {
        setErrorMsg({"qualification": true});
      }

      return;
    }

    var reg = await register({
      "highest_qualification": qualification.trim(),
      "school_name": schoolName.text.trim(),
      "ug_college_name": ugCollegeName.text.trim(),
      "pg_college_name": pgCollegeName.text.trim(),
      "phd_college_name": phdCollegeName.text.trim(),
      "other_qualification_details": otherDetails.text.trim(),
      "hometown": hometown.text.trim(),
      "highest_degree": highestDegree.text.trim(),
      "registration_step": '5'
    });

    if (reg['success'] == true) {
      Navigator.push(
        ctx,
        MaterialPageRoute(
          builder: (ctx) => const WorkDetails(),
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

  //
  void workSubmit(ctx) async {
    // Check validation
    if (profession.isEmpty ||
        (profession == "business" && turnover.text.trim() == "") ||
        industry.text.trim() == "" ||
        orgnization.text.trim() == "" ||
        designation.text.trim() == "" ||
        anualIncome == "") {
      if (profession.isEmpty) {
        setErrorMsg({"profession": true});
      }
      if (industry.text.trim().isEmpty) {
        setErrorMsg({"industry": true});
      }
      if (orgnization.text.trim().isEmpty) {
        setErrorMsg({"orgnization": true});
      }
      if (designation.text.trim().isEmpty) {
        setErrorMsg({"designation": true});
      }
      if (anualIncome.trim().isEmpty) {
        setErrorMsg({"anualIncome": true});
      }
      if (turnover.text.trim().isEmpty) {
        setErrorMsg({"turnover": true});
      }

      return;
    }

    var reg = await register({
      "nature_of_work": profession.trim(),
      "industry": industry.text.trim(),
      "organization": orgnization.text.trim(),
      "designation": designation.text.trim(),
      "personal_anual_income": anualIncome.trim(),
      "business_turnover": turnover.text.trim(),
      "business_website": website.text.trim(),
      "registration_step": '6'
    });

    if (reg['success'] == true) {
      Navigator.push(
        ctx,
        MaterialPageRoute(
          builder: (ctx) => const MoreQuestionNext(),
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

  void moreQuestionNext(ctx) async {
    var reg = await register({'registration_step': "7"});

    if (reg['success'] == true) {
      Navigator.push(
        ctx,
        MaterialPageRoute(
          builder: (ctx) => const Preference(),
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
