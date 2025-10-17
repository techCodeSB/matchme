import 'package:flutter/material.dart';
import 'package:matchme/controller/socket_controller.dart';
import 'package:matchme/widgets/my_snackbar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:matchme/constant.dart';

class SupportController extends ChangeNotifier {
  List<dynamic>? allChats;
  final TextEditingController chat = TextEditingController();

  
  void manualChatInsert(data) {
    if (allChats == null) {
      allChats = [data];
    } else {
      allChats = [...allChats!, data];
    }
    notifyListeners();
  }

  void changeReadStatus() async {
    Uri url = Uri.parse("${Constant.api}admin-chat/change-read-status");
    final SharedPreferences pref = await SharedPreferences.getInstance();
    final token = pref.getString("token");

    try {
      var req = await http.post(
        url,
        headers: {"Content-Type": 'application/json'},
        body: jsonEncode({
          "token": token,
          "type": "admin",
        }),
      );

      if (req.statusCode == 200) {
        debugPrint("Read status change");
      } else {
        debugPrint("Read status not change");
      }

      notifyListeners();
    } catch (e) {
      debugPrint("Error fetching user data: $e");
    }
  }

  Future<void> getAllChats() async {
    Uri url = Uri.parse("${Constant.api}admin-chat/get-chat");
    final SharedPreferences pref = await SharedPreferences.getInstance();
    final token = pref.getString("token");

    try {
      var req = await http.post(
        url,
        headers: {"Content-Type": 'application/json'},
        body: jsonEncode({"token": token}),
      );

      var res = jsonDecode(req.body);
      if (req.statusCode == 200) {
        allChats = res;
      } else {
        allChats = [];
      }

      notifyListeners();
    } catch (e) {
      debugPrint("Error fetching user data: $e");
      allChats = [];
    }
  }

  void addChat(ctx) async {
    Uri url = Uri.parse("${Constant.api}admin-chat/add-chat");
    final SharedPreferences pref = await SharedPreferences.getInstance();
    final token = pref.getString("token");
    final userId = pref.getString("userId");

    if (chat.text.trim() == '') {
      return;
    }

    try {
      var req = await http.post(
        url,
        headers: {"Content-Type": 'application/json'},
        body: jsonEncode({"msgBy": "user", "msg": chat.text, "token": token}),
      );

      var res = jsonDecode(req.body);
      if (req.statusCode == 200) {
        var socketData = jsonEncode({
          "from": userId,
          "to": "admin",
          "msg": chat.text,
        });
        SocketController.socket.emit("message", socketData);

        allChats = res;
        chat.clear();
      } else {
        mySnackBar(ctx, "Message no send");
      }

      notifyListeners();
    } catch (e) {
      debugPrint("Error fetching user data: $e");
      mySnackBar(ctx, "Something went wrong");
    }
  }
}
