import 'package:flutter/material.dart';
import 'package:matchme/controller/notification_controller.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:matchme/controller/support.controller.dart';
import 'package:matchme/services/notification_services.dart';
import './controller/match_controller.dart';
import './controller/psychometric_controller.dart';
import 'package:provider/provider.dart';
import './controller/interest_controller.dart';
import 'controller/profile_controller.dart';
import './controller/mainpage_controller.dart';
import './controller/photoupload_controller.dart';
import './controller/preferance_controller.dart';
import './controller/login_controller.dart';
import './controller/register_controller.dart';
import './screen/splash.dart';
import 'package:firebase_messaging/firebase_messaging.dart';



// :::::::::: JAY JAGANNATH 0!0 ::::::::::/
//  :::::::::::::::::::::::::::::::::::::
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await NotificationService.initialize();

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => LoginController()),
      ChangeNotifierProvider(create: (context) => RegisterController()),
      ChangeNotifierProvider(create: (context) => PreferanceController()),
      ChangeNotifierProvider(create: (context) => PhotouploadController()),
      ChangeNotifierProvider(create: (context) => MainpageController()),
      ChangeNotifierProvider(create: (context) => InterestController()),
      ChangeNotifierProvider(create: (context) => ProfileController()),
      ChangeNotifierProvider(create: (context) => PsychometricController()),
      ChangeNotifierProvider(create: (context) => MatchController()),
      ChangeNotifierProvider(create: (context) => NotificationController()),
      ChangeNotifierProvider(create: (context) => SupportController()),
    ],
    child: const App(),
  ));
}

class App extends StatefulWidget {
  const App({super.key});

  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MatchMe',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        applyElevationOverlayColor: false,
      ),
      home: const Splash(),
    );
  }
}


@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  NotificationService.showNotification(message);
}

