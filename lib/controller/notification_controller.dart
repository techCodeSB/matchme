import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:matchme/constant.dart';
import 'package:matchme/services/notification_services.dart';
import 'package:permission_handler/permission_handler.dart';
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


  static void setupFirebaseMessaging() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;

    // 🔵 Handle foreground messages
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      debugPrint('📬 Foreground notification: ${message.notification?.title}');
      NotificationService.showNotification(message);
    });

    // 🔙 Handle messages when the app is opened from background
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      debugPrint('🔄 App opened from background: ${message.notification?.title}');
      // navigate to specific screen if needed
    });

    // 🔴 Handle messages when the app is opened from a terminated state
    RemoteMessage? initialMessage = await messaging.getInitialMessage();
    if (initialMessage != null) {
      debugPrint('🚨 App launched from terminated state by notification');
      // handle navigation or logic
    }
  }

}
