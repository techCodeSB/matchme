import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:matchme/constant.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class MatchController extends ChangeNotifier {
  Map<String, dynamic>? allMatches;
  Map<String, dynamic> profileDetails = {};

  void setProfileDetails(index) {
    profileDetails = allMatches?['matches'][index]['match_user_id'];
    notifyListeners();
  }

  void removeMatch(id) {
    final matches = allMatches!['matches'] as List<dynamic>;

    matches.removeWhere((v) {
      final matchId = v['match_user_id']['_id'].toString();
      return matchId == id.toString();
    });

    allMatches!['matches'] = matches; // Update map after removal
    notifyListeners();
  }

  void getMatches() async {
    Uri url = Uri.parse("${Constant.api}match/get");
    final SharedPreferences pref = await SharedPreferences.getInstance();
    final token = pref.getString("token");

    try {
      var req = await http.get(url, headers: {
        "Content-Type": 'application/json',
        "Authorization": "Bearer $token"
      });

      var res = jsonDecode(req.body);
      if (req.statusCode == 200) {
        allMatches = res;
      } else {
        allMatches = {};
      }
      notifyListeners();
    } catch (e) {
      debugPrint("Error fetching user data: $e");
    }
  }
}
