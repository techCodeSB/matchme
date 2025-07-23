import 'package:matchme/controller/splash_controller.dart';
import 'package:matchme/screen/photo_upload.dart';
import 'package:matchme/widgets/my_snackbar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../constant.dart';

// Screens;
import '../screen/introduction.dart';
import '../screen/family_details.dart';
import '../screen/more_question_next.dart';
import '../screen/personal_sec_details.dart';
import '../screen/personal_trd_details.dart';
import '../screen/preference.dart';
import '../screen/qualification_details.dart';
import '../screen/work_details.dart';
import '../screen/personal_fst_details.dart';
import '../screen/lifestyle_1.dart';
import '../screen/lifestyle_2.dart';
import '../screen/lifestyle_3.dart';
import '../screen/lifestyle_4.dart';
import '../screen/lifestyle_5.dart';

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
  static String nationality = "";
  static String religious = "";

  // Third Personal Details;
  static final TextEditingController whatsappNumber = TextEditingController();
  static final TextEditingController heightFeet = TextEditingController();
  static final TextEditingController heightInch = TextEditingController();
  String height = "${heightFeet.text.trim()}.${heightInch.text.trim()}";
  static final TextEditingController weight = TextEditingController();
  static String maritalStatus = "";
  static String eatingPref = "";

  // Family Details;
  static final TextEditingController fathername = TextEditingController();
  static final TextEditingController mothername = TextEditingController();
  static final TextEditingController hometown = TextEditingController();
  static final TextEditingController familyDescription =
      TextEditingController();
  static String fatherOccupation = "";
  static String motherOccupation = "";
  static String noOfSibling = "";
  static String familyBackground = "";
  static String familyAnualIncome = "";

  // Qualification Details;
  static String qualification = "";
  static final TextEditingController schoolName = TextEditingController();
  static final TextEditingController ugCollegeName = TextEditingController();
  static final TextEditingController pgCollegeName = TextEditingController();
  static final TextEditingController phdCollegeName = TextEditingController();
  static final TextEditingController otherDetails = TextEditingController();
  static final TextEditingController highestDegree = TextEditingController();

  // Work Details
  static String profession = "";
  static final TextEditingController industry = TextEditingController();
  static final TextEditingController orgnization = TextEditingController();
  static final TextEditingController designation = TextEditingController();
  static final TextEditingController turnover = TextEditingController();
  static final TextEditingController website = TextEditingController();
  static String anualIncome = "";

  // Life Style
  static String drink = "";
  static String smoker = "";
  static String workout = "";
  static List<String> weekendActivites = [];
  static List<String> interest = [];
  static List<String> holidays = [];
  static String eatOut = "";
  static String travle = "";
  static String socialise = "";
  static String goOut = "";
  static String spritual = "";
  static String howReligious = "";

  // Introduction about Your sele;
  static final TextEditingController introduction = TextEditingController();

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
    "whatsappNumber": false,
    "height": false,
    "weight": false,
    "maritalStatus": false,
    "eatingPref": false,

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
    "turnover": false,

    // Lifestyle
    "drink": false,
    "smoker": false,
    "workout": false,
    "weekendActivites": false,
    "interest": false,
    "holidays": false,
    "eatOut": false,
    "travle": false,
    "socialise": false,
    "goOut": false,
    "spritual": false,
    "howReligious": false,

    "introduction": false,
  };

  void setErrorMsg(data) {
    errMsg = {...errMsg, ...data};
    notifyListeners();
  }

  // update specific field....
  // This is memeber function only, not call directly..;
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

    if (req.statusCode == 200) {
      return {"success": true, "res": res};
    } else {
      return {"success": false, "res": res};
    }
  }

  //
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
      mySnackBar(ctx, "Error: ${reg['res']['error'] ?? reg['res']['err']}");
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
          builder: (ctx) => const PersonalTrdDetails(),
        ),
      );
    } else {
      mySnackBar(ctx, "Error: ${reg['res']['error'] ?? reg['res']['err']}");
    }
  }

  //
  void personalTrdSubmit(ctx) async {
    var height = "${heightFeet.text.trim()}.${heightInch.text.trim()}";
    // Check validation
    if (whatsappNumber.text.isEmpty ||
        height.isEmpty ||
        weight.text.isEmpty ||
        maritalStatus.isEmpty ||
        eatingPref.isEmpty) {
      if (whatsappNumber.text.trim().isEmpty) {
        setErrorMsg({"whatsappNumber": true});
      }

      if (height.trim().isEmpty ||
          height.trim() == "." ||
          height.trim() == "0.0") {
        setErrorMsg({"height": true});
      }
      if (weight.text.trim().isEmpty) {
        setErrorMsg({"weight": true});
      }
      if (maritalStatus.isEmpty) {
        setErrorMsg({"maritalStatus": true});
      }
      if (eatingPref.isEmpty) {
        setErrorMsg({"eatingPref": true});
      }

      return;
    }

    var reg = await register({
      "country": whatsappNumber.text.trim(),
      "height": height.trim(),
      "weight": weight.text.trim(),
      "marital_status": maritalStatus.trim(),
      "eating_preferences": eatingPref.trim(),
      "registration_step": '4'
    });

    if (reg['success'] == true) {
      Navigator.push(
        ctx,
        MaterialPageRoute(
          builder: (ctx) => const FamilyDetails(),
        ),
      );
    } else {
      mySnackBar(ctx, "Error: ${reg['res']['error'] ?? reg['res']['err']}");
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
      "registration_step": '5'
    });

    if (reg['success'] == true) {
      Navigator.push(
        ctx,
        MaterialPageRoute(
          builder: (ctx) => const QualificationDetails(),
        ),
      );
    } else {
      mySnackBar(ctx, "Error: ${reg['res']['error'] ?? reg['res']['err']}");
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
      "registration_step": '6'
    });

    if (reg['success'] == true) {
      Navigator.push(
        ctx,
        MaterialPageRoute(
          builder: (ctx) => const WorkDetails(),
        ),
      );
    } else {
      mySnackBar(ctx, "Error: ${reg['res']['error'] ?? reg['res']['err']}");
      mySnackBar(ctx, "Error: ${reg['res']['error'] ?? reg['res']['err']}");
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
      "registration_step": '7'
    });

    if (reg['success'] == true) {
      Navigator.push(
        ctx,
        MaterialPageRoute(
          builder: (ctx) => const Lifestyle1(),
        ),
      );
    } else {
      mySnackBar(ctx, "Error: ${reg['res']['error'] ?? reg['res']['err']}");
    }
  }

  //
  void lifeStyle1Submit(ctx) async {
    if (smoker.isEmpty || drink.isEmpty) {
      if (smoker.isEmpty) {
        setErrorMsg({"smoker": true});
      }
      if (drink.isEmpty) {
        setErrorMsg({"drink": true});
      }

      return;
    }

    var reg = await register({
      "how_often_you_drink": drink.trim(),
      "are_you_a_smoker": smoker.trim(),
      "registration_step": '8'
    });

    if (reg['success'] == true) {
      Navigator.push(
        ctx,
        MaterialPageRoute(
          builder: (ctx) => const Lifestyle2(),
        ),
      );
    } else {
      mySnackBar(ctx, "Error: ${reg['res']['error'] ?? reg['res']['err']}");
    }
  }

  //
  void lifeStyle2Submit(ctx, List<String> act) async {
    weekendActivites = act; // add all Activites;

    if (workout.isEmpty || weekendActivites.isEmpty) {
      if (workout.isEmpty) {
        setErrorMsg({"workout": true});
      }
      if (weekendActivites.isEmpty) {
        setErrorMsg({"weekendActivites": true});
      }

      return;
    }

    var reg = await register({
      "how_often_you_workout": workout.trim(),
      "favourite_weekend_activities": weekendActivites,
      "registration_step": '9'
    });

    if (reg['success'] == true) {
      Navigator.push(
        ctx,
        MaterialPageRoute(
          builder: (ctx) => const Lifestyle3(),
        ),
      );
    } else {
      mySnackBar(ctx, "Error: ${reg['res']['error'] ?? reg['res']['err']}");
    }
  }

  //
  void lifeStyle3Submit(ctx, List<String> intst) async {
    interest = intst; // add all intersets;

    if (interest.isEmpty) {
      setErrorMsg({"interest": true});
      return;
    }

    var reg =
        await register({"interests": interest, "registration_step": '10'});

    if (reg['success'] == true) {
      Navigator.push(
        ctx,
        MaterialPageRoute(
          builder: (ctx) => const Lifestyle4(),
        ),
      );
    } else {
      mySnackBar(ctx, "Error: ${reg['res']['error'] ?? reg['res']['err']}");
    }
  }

  //
  void lifeStyle4Submit(ctx, List<String> h) async {
    holidays = h; // add all holidays;

    if (holidays.isEmpty || eatOut.isEmpty || travle.isEmpty) {
      if (holidays.isEmpty) {
        setErrorMsg({"holidays": true});
      }
      if (eatOut.isEmpty) {
        setErrorMsg({"eatOut": true});
      }
      if (travle.isEmpty) {
        setErrorMsg({"travle": true});
      }
      return;
    }

    var reg = await register({
      "holidays_prefrences": holidays,
      "how_often_you_eat_out": eatOut.trim(),
      "how_often_you_travel": travle.trim(),
      "registration_step": '11',
    });

    if (reg['success'] == true) {
      Navigator.push(
        ctx,
        MaterialPageRoute(
          builder: (ctx) => const Lifestyle5(),
        ),
      );
    } else {
      mySnackBar(ctx, "Error: ${reg['res']['error'] ?? reg['res']['err']}");
    }
  }

  //
  void lifeStyle5Submit(ctx) async {
    if (socialise.isEmpty ||
        goOut.isEmpty ||
        spritual.isEmpty ||
        howReligious.isEmpty) {
      if (socialise.isEmpty) {
        setErrorMsg({"socialise": true});
      }
      if (goOut.isEmpty) {
        setErrorMsg({"goOut": true});
      }
      if (spritual.isEmpty) {
        setErrorMsg({"spritual": true});
      }
      if (howReligious.isEmpty) {
        setErrorMsg({"howReligious": true});
      }
      return;
    }

    var reg = await register({
      "prefered_social_event": socialise.trim(),
      "whom_do_you_like_going_out_with": goOut.trim(),
      "how_spiritual_are_you": spritual.trim(),
      "how_religious_are_you": howReligious.trim(),
      "registration_step": '12',
    });

    if (reg['success'] == true) {
      Navigator.push(
        ctx,
        MaterialPageRoute(
          builder: (ctx) => const Introduction(),
        ),
      );
    } else {
      mySnackBar(ctx, "Error: ${reg['res']['error'] ?? reg['res']['err']}");
    }
  }

  //
  void introductionSubmit(ctx) async {
    var getStatus = await SplashController.getSteps();
    var status = getStatus['registration_status'];

    // Check validation
    if (introduction.text.isEmpty) {
      setErrorMsg({"introduction": true});

      return;
    }

    var reg = await register({
      "about_yourself": introduction.text.trim(),
      "registration_step": '13',
    });

    if (reg['success'] == true) {
      if (status == "0") {
        Navigator.push(
          ctx,
          MaterialPageRoute(
            builder: (ctx) => const MoreQuestionNext(),
          ),
        );
      }else{
        Navigator.push(
          ctx,
          MaterialPageRoute(
            builder: (ctx) => const PhotoUpload(),
          ),
        );
      }
    } else {
      mySnackBar(ctx, "Error: ${reg['res']['error'] ?? reg['res']['err']}");
    }
  }

  //
  void moreQuestionNext(ctx) async {
    var reg = await register({'registration_step': "14"});

    if (reg['success'] == true) {
      Navigator.push(
        ctx,
        MaterialPageRoute(
          builder: (ctx) => const Preference(),
        ),
      );
    } else {
      mySnackBar(ctx, "Error: ${reg['res']['error'] ?? reg['res']['err']}");
    }
  }
}
