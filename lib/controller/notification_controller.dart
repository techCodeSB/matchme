import 'package:flutter/material.dart';
import 'dart:io';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:permission_handler/permission_handler.dart';

class NotificationController extends ChangeNotifier {
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

  
}
