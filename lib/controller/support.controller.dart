import 'package:flutter/material.dart';
import 'package:matchme/widgets/my_snackbar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:matchme/constant.dart';

class SupportController extends ChangeNotifier {
  List<dynamic>? allTicketMsg;
  List<dynamic>? allChats;
  final TextEditingController supportMsg = TextEditingController();
  final TextEditingController chat = TextEditingController();
  final List<String> chips = [
    "Queries About app Functionality",
    "Astrology",
    "Other Services",
    "Coaching"
  ];

  Future<void> sendMessage(ctx, type) async {
    Uri url = Uri.parse("${Constant.api}admin-chat/add");
    final SharedPreferences pref = await SharedPreferences.getInstance();
    final token = pref.getString("token");

    if (type == "") {
      mySnackBar(ctx, "Select your message type");
      return;
    }
    if (supportMsg.text == "") {
      mySnackBar(ctx, "Write your message..");
      return;
    }

    try {
      var req = await http.post(
        url,
        headers: {"Content-Type": 'application/json'},
        body: jsonEncode({
          "token": token,
          "type": type,
          "msg": supportMsg.text,
        }),
      );
      var res = jsonDecode(req.body);

      if (req.statusCode == 200) {
        if (allTicketMsg != null || allTicketMsg!.isNotEmpty) {
          allTicketMsg = [res, ...allTicketMsg!];
        } else {
          allTicketMsg = [res];
        }

        mySnackBar(ctx, "Messag send successfully");
        supportMsg.clear();
      } else {
        mySnackBar(ctx, res['err']);
      }
      notifyListeners();
    } catch (e) {
      debugPrint("Error fetching user data: $e");
    }
  }

  Future<void> getAllTicketMsg() async {
    Uri url = Uri.parse("${Constant.api}admin-chat/get");
    final SharedPreferences pref = await SharedPreferences.getInstance();
    final token = pref.getString("token");

    try {
      var req = await http.get(
        url,
        headers: {
          "Content-Type": 'application/json',
          "Authorization": "Bearer $token"
        },
      );

      var res = jsonDecode(req.body);
      if (req.statusCode == 200) {
        allTicketMsg = res;
      } else {
        allTicketMsg = [];
      }

      notifyListeners();
    } catch (e) {
      debugPrint("Error fetching user data: $e");
      allTicketMsg = [];
    }
  }

  void changeReadStatus(msgId) async {
    Uri url = Uri.parse("${Constant.api}admin-chat/change-read-status");

    try {
      var req = await http.post(
        url,
        headers: {"Content-Type": 'application/json'},
        body: jsonEncode({
          "messageId": msgId,
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

  Future<void> getAllChats(msgId) async {
    Uri url = Uri.parse("${Constant.api}admin-chat/get-chat");

    try {
      var req = await http.post(url,
          headers: {"Content-Type": 'application/json'},
          body: jsonEncode({"msgId": msgId}));

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

  void addChat(msgId, ctx) async {
    Uri url = Uri.parse("${Constant.api}admin-chat/add-chat");
    if (chat.text.trim() == '') {
      return;
    }

    try {
      var req = await http.post(
        url,
        headers: {"Content-Type": 'application/json'},
        body: jsonEncode({
          "msgId": msgId,
          "msgBy": "user",
          "msg": chat.text,
        }),
      );

      var res = jsonDecode(req.body);
      if (req.statusCode == 200) {
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
