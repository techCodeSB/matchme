import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:matchme/constant.dart';
import 'package:matchme/controller/mainpage_controller.dart';
import 'package:matchme/screen/connection.dart';
import 'package:matchme/screen/interest_received.dart';
import 'package:matchme/screen/main_page.dart';
import 'package:matchme/screen/support_chat.dart';
import 'package:matchme/services/notification_services.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NotificationController extends ChangeNotifier {
  List<dynamic>? notificationData;

  static Future<bool> isNotificationPermissionGranted() async {
    if (Platform.isAndroid) {
      if (await Permission.notification.isGranted) {
        return true;
      } else {
        return false;
      }
    } else if (Platform.isIOS) {
      NotificationSettings settings =
          await FirebaseMessaging.instance.getNotificationSettings();
      return settings.authorizationStatus == AuthorizationStatus.authorized;
    }

    return false;
  }

  Future<void> getAllNotification() async {
    Uri url = Uri.parse("${Constant.api}notification/get");
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
        notificationData = res;
      } else {
        notificationData = [];
      }

      notifyListeners();
    } catch (e) {
      debugPrint("Error fetching user data: $e");
      notificationData = [];
    }
  }

  static void setupFirebaseMessaging(ctx) async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;

    // Request permissions (iOS only)
    await messaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    // 🔵 Foreground messages
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      NotificationService.showNotification(message);
    });

    // 🔙 Background -> when tapped
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      _handleNavigation(message.data, ctx);
    });

    // 🔴 Terminated -> when launched by tap
    RemoteMessage? initialMessage = await messaging.getInitialMessage();
    if (initialMessage != null && initialMessage.data.isNotEmpty) {
      final screen = initialMessage.data['customKey'];
      if (screen != null && screen.isNotEmpty) {
        _handleNavigation(initialMessage.data, ctx);
      }
    }
  }

  static void _handleNavigation(Map<String, dynamic> data, ctx) {
    var screen = data['customKey'];

    if (screen == "match") {
      Navigator.push(ctx, MaterialPageRoute(
        builder: (ctx) {
          Provider.of<MainpageController>(ctx, listen: false)
              .updatePosition("heart");
          Provider.of<MainpageController>(ctx, listen: false).setBottomIndex(1);

          return const MainPage();
        },
      ));
    }
    //
    else if (screen == "interest") {
      Navigator.push(ctx, MaterialPageRoute(
        builder: (ctx) {
          return const InterestReceived();
        },
      ));
    }
    //
    else if (screen == "connection") {
      Navigator.push(ctx, MaterialPageRoute(
        builder: (ctx) {
          return const Connection();
        },
      ));
    }
    //
    else if (screen == "message") {
      Navigator.push(ctx, MaterialPageRoute(
        builder: (ctx) {
          return const SupportChat();
        },
      ));
    }
  }
}
