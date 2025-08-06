import 'package:flutter/material.dart';
import 'package:matchme/controller/notification_controller.dart';
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


// :::::::::: JAY JAGANNATH 0!0 ::::::::::/
//  :::::::::::::::::::::::::::::::::::::
void main() {
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
