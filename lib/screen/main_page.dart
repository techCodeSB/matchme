import 'package:flutter/material.dart';
import 'package:matchme/controller/mainpage_controller.dart';
import 'package:provider/provider.dart';
import '../screen/dashboard.dart';
import './match.dart';
import '../screen/notification.dart';
import '../screen/profile.dart';
import '../widgets/bottom_bar.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  // :::: Don't change the index ::::
  List<Widget> screens = const [
    Dashboard(),
    Match(),
    MyNotification(),
    Profile(),
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[Provider.of<MainpageController>(context, listen: true)
          .currentBottomBarIndex],
      bottomNavigationBar: const BottomBar(),
    );
  }
}
