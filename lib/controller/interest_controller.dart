import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:matchme/constant.dart';
import 'package:matchme/controller/match_controller.dart';
import 'package:matchme/widgets/my_snackbar.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class InterestController extends ChangeNotifier {
  Map<String, dynamic>? allInterest;
  List<dynamic>? receiveInterese;
  List<dynamic>? allConnections;
  int? activeMatchProfileIndex;

  void setProfileDetails(index, ctx, type) {
    if (type == "receive") {
      Provider.of<MatchController>(ctx, listen: false).profileDetails =
          receiveInterese?[index]['sender_user'];
    } 
    else if(type== "connection"){
      Provider.of<MatchController>(ctx, listen: false).profileDetails =
          allConnections?[index];
    }
    else {
      Provider.of<MatchController>(ctx, listen: false).profileDetails =
          allInterest?['matches'][index];
    }
    notifyListeners();
  }

  Future<void> getInterestData(type) async {
    Uri url = Uri.parse("${Constant.api}interest/get");
    final SharedPreferences pref = await SharedPreferences.getInstance();
    final token = pref.getString("token");

    try {
      var req = await http.post(
        url,
        headers: {"Content-Type": 'application/json'},
        body: jsonEncode({
          "token": token,
          "type": type,
        }),
      );

      var res = jsonDecode(req.body);
      if (req.statusCode == 200) {
        if (type == 1) {
          allInterest = res;
        } else if (type == 2) {
          receiveInterese = res;
        }
      } else {
        allInterest = {};
        receiveInterese = [];
      }
      notifyListeners();
    } catch (e) {
      debugPrint("Error fetching user data: $e");
    }
  }

  Future<void> sendInterest(interestUserId, type, ctx) async {
    Uri url = Uri.parse("${Constant.api}interest/send");
    final SharedPreferences pref = await SharedPreferences.getInstance();
    final token = pref.getString("token");

    try {
      var req = await http.post(
        url,
        headers: {"Content-Type": 'application/json'},
        body: jsonEncode({
          "token": token,
          "type": type,
          "matchUserId": interestUserId,
        }),
      );

      if (req.statusCode == 200) {
        Provider.of<MatchController>(ctx, listen: false).getMatches();
      } else {
        allInterest = {};
      }
      notifyListeners();
    } catch (e) {
      debugPrint("Error fetching user data: $e");
    }
  }

  Future<void> sendConnection(connectionUserId, type, ctx) async {
    Uri url = Uri.parse("${Constant.api}connection/accept");
    final SharedPreferences pref = await SharedPreferences.getInstance();
    final token = pref.getString("token");

    try {
      var req = await http.post(
        url,
        headers: {"Content-Type": 'application/json'},
        body: jsonEncode({
          "token": token,
          "type": type,
          "connectionUserId": connectionUserId,
        }),
      );

      if (req.statusCode == 200) {
        receiveInterese!
            .removeWhere((ri) => ri["sender_user"]['_id'] == connectionUserId);
        mySnackBar(ctx, "You are now connect");
      } else {
        mySnackBar(ctx, "Connection not send");
        allInterest = {};
      }
      notifyListeners();
    } catch (e) {
      mySnackBar(ctx, "Someting went wrong");
      debugPrint("Error fetching user data: $e");
    }
  }

  Future<void> getConnection() async {
    Uri url = Uri.parse("${Constant.api}connection/get");
    final SharedPreferences pref = await SharedPreferences.getInstance();
    final token = pref.getString("token");

    try {
      var req = await http.get(
        url,
        headers: {
          "Content-Type": 'application/json',
          "Authorization": "Bearer $token",
        },
      );

      var res = jsonDecode(req.body);
      if (req.statusCode == 200) {
        allConnections = res;
      } else {
        allConnections = [];
      }
      notifyListeners();
    } catch (e) {
      debugPrint("Error fetching user data: $e");
    }
  }
}
