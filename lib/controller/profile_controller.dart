import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:matchme/controller/photoupload_controller.dart';
import 'package:matchme/controller/register_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../constant.dart';

class ProfileController extends RegisterController {
  Map<String, dynamic> userData = {}; // Self user data;
  bool isPsycho = false;

  void setUserData(data) {
    userData = data;
    notifyListeners();
  }

  Future<void> getUserData(ctx) async {
    Uri url = Uri.parse("${Constant.api}users/get");
    final SharedPreferences pref = await SharedPreferences.getInstance();
    final token = pref.getString("token");

    try {
      var req = await http.post(
        url,
        body: jsonEncode({"token": token}),
        headers: {"Content-Type": 'application/json'},
      );
      var res = jsonDecode(req.body);
      userData = res;
      isPsycho = res['psychometric_test'];

      notifyListeners();
    } catch (e) {
      // Handle error
      debugPrint("Error fetching user data: $e");
    }
  }

  void setData() {
    RegisterController.fullname.text = userData['full_name'];
    RegisterController.nickname.text = userData['nick_name'];
    RegisterController.country.text = userData['country'];
    RegisterController.city.text = userData['city'];
    RegisterController.gender = userData['gender'];
    RegisterController.dateOfBirth = DateTime.parse(userData['dob']);
    RegisterController.timeOfBirth = userData['birth_time'];
    RegisterController.placeOfBirth.text = userData['birth_place'];
    RegisterController.locality.text = userData['locality'];
    RegisterController.community.text = userData['community'];
    RegisterController.medical.text = userData['medical_history'];
    RegisterController.whatsappNumber.text = userData['whatsapp_number'];
    RegisterController.heightFeet = userData['height'].split(".")[0];
    RegisterController.heightInch = userData['height'].split(".")[1];
    RegisterController.nationality = userData['nationality'];
    RegisterController.religious = userData['religion'];
    RegisterController.weight.text = userData['weight'].split(" ")[0];
    RegisterController.weightUnit = userData['weight'].split(" ")[1];
    RegisterController.maritalStatus = userData['marital_status'] ?? "";
    RegisterController.fromMaritalStatusYear = userData['marital_status_from_year']?.toString() ?? "";
    RegisterController.toMaritalStatusYear = userData['marital_status_to_year']?.toString() ?? "";
    RegisterController.doYouHaveKids = userData['do_have_kids'];
    RegisterController.showWeightOnProfile = userData['should_weight_display_on_profile'];

    RegisterController.eatingPref = userData['eating_preferences'];
    RegisterController.fathername.text = userData['father_name'];
    RegisterController.mothername.text = userData['mother_name'];
    RegisterController.hometown.text = userData['hometown'];
    RegisterController.familyDescription.text = userData['family_description'];
    RegisterController.fatherOccupation = userData['father_occupation'];
    RegisterController.motherOccupation = userData['mother_occupation'];
    RegisterController.noOfSibling = userData['no_of_siblings'];
    RegisterController.familyBackground = userData['family_background'];
    RegisterController.familyAnualIncome = userData['family_anual_income'];

    RegisterController.qualification = userData['highest_qualification'];
    RegisterController.schoolName.text = userData['school_name'];
    RegisterController.ugCollegeName.text = userData['ug_college_name'];
    RegisterController.pgCollegeName.text = userData['pg_college_name'];
    RegisterController.phdCollegeName.text = userData['phd_college_name'];
    RegisterController.otherDetails.text =
        userData['other_qualification_details'];
    RegisterController.highestDegree.text = userData['highest_degree'];

    RegisterController.profession = userData['nature_of_work'];
    RegisterController.industry.text = userData['industry'];
    RegisterController.orgnization.text = userData['organization'];
    RegisterController.designation.text = userData['designation'];
    RegisterController.turnover.text = userData['business_turnover'];
    RegisterController.website.text = userData['business_website'];
    RegisterController.anualIncome = userData['personal_anual_income'];

    RegisterController.drink = userData['how_often_you_drink'];
    RegisterController.smoker = userData['are_you_a_smoker'];
    RegisterController.workout = userData['how_often_you_workout'];
    RegisterController.weekendActivites = List<String>.from(userData['favourite_weekend_activities']);
    RegisterController.interest = List<String>.from(userData['interests']);
    RegisterController.holidays = List<String>.from(userData['holidays_prefrences']);
    RegisterController.eatOut = userData['how_often_you_eat_out'];
    RegisterController.travle = userData['how_often_you_travel'];
    RegisterController.socialise = userData['prefered_social_event'];
    RegisterController.goOut = userData['whom_do_you_like_going_out_with'];
    RegisterController.spritual = userData['how_spiritual_are_you'];
    RegisterController.howReligious = userData['how_religious_are_you'];

    RegisterController.introduction.text = userData['about_yourself'];

    // Uploaded images;
    PhotouploadController.uploadedImages = userData['image'] ?? {};

    notifyListeners();
  }
}
