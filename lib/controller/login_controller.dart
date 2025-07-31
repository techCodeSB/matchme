import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:matchme/controller/profile_controller.dart';
import 'package:matchme/screen/login.dart';
import 'package:matchme/widgets/my_snackbar.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import './splash_controller.dart';
import '../constant.dart';

class LoginController extends ChangeNotifier {
  static TextEditingController username = TextEditingController();
  static TextEditingController password = TextEditingController();
  String isError = "";
  Map<String, bool> errMsg = {"user": false, "pass": false};

  void setError(msg) {
    isError = msg;
    notifyListeners();
  }

  void setErrorMsg(data) {
    errMsg = {...errMsg, ...data};
    notifyListeners();
  }

  void login(ctx) async {
    if (username.text == "" || password.text == "") {
      if (username.text.trim() == "") {
        setErrorMsg({"user": true});
      }
      if (password.text.trim() == "") {
        setErrorMsg({"pass": true});
      }
      return;
    }

    try {
      Map<String, dynamic> data = {
        "userid": username.text.trim(),
        "pass": password.text.trim()
      };
      Uri url = Uri.parse("${Constant.api}users/login");
      final SharedPreferences pref = await SharedPreferences.getInstance();

      var req = await http.post(
        url,
        body: jsonEncode(data),
        headers: {"Content-Type": "application/json"},
      );

      var res = jsonDecode(req.body);
      if (req.statusCode == 200) {
        // Set token in localdata
        pref.setString("token", res['token']);

        // remove value from fields;
        username.text = "";
        password.text = "";

        // Navigator.of(ctx).pushReplacement(MaterialPageRoute(builder: (ctx) {
        //   return const GetStarted();
        // }));
        SplashController.checkSteps(ctx);
      } else {
        mySnackBar(ctx, "Invalid username or password");
      }
    } catch (e) {
      setError("Someting went wrong");
      return;
    }
  }

  void logout(ctx) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    pref.remove("token");
    Provider.of<ProfileController>(ctx, listen: false).setUserData({}); // Clear userdata
    Navigator.of(ctx).pushReplacement(
      MaterialPageRoute(
        builder: (ctx) => const Login(),
      ),
    );
  }
}
