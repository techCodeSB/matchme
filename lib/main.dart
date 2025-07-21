import 'package:flutter/material.dart';
import '../controller/interest_controller.dart';
import '../controller/mainpage_controller.dart';
// import 'package:matchme/screen/dashboard.dart';
import 'package:provider/provider.dart';
import '../controller/photoupload_controller.dart';
import '../controller/preferance_controller.dart';
import './controller/login_controller.dart';
import './controller/register_controller.dart';
// import 'package:matchme/screen/opening.dart';
// import './screen/login.dart';
// import './screen/otp.dart';
// import './screen/get_started.dart';
// import './screen/family_details.dart';
// import './screen/qualification_details.dart';
// import './screen/work_details.dart';
// import './screen/more_question_next.dart';
// import './screen/chat_question.dart';
// import './screen/personal_fst_details.dart';
// import 'screen/personal_sec_details.dart';
// import './screen/personal_trd_details.dart';
// import './screen/interest.dart';
// import './screen/goto_profile.dart';
// import './screen/photo_upload.dart';
// import './screen/profile.dart';
// import './screen/splash.dart';
// import './screen/lifestyle_5.dart';
// import './screen/introduction.dart';
// import './screen/notification.dart';
// import './screen/interest.dart';
import '../screen/main_page.dart';

// :::::::::: JAY JAGANNATH 0!0 ::::::::::/
//  :::::::::::::::::::::::::::::::::::::
void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => LoginController()),
      ChangeNotifierProvider(create: (context) => RegisterController()),
      ChangeNotifierProvider(create: (context) => PreferanceController()),
      ChangeNotifierProvider(create: (context) => PhotouploadController()),
      ChangeNotifierProvider(create: (context)=> MainpageController()),
      ChangeNotifierProvider(create: (context)=>InterestController()),
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
      home: const MainPage(),
    );
  }
}
