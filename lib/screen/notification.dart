import 'package:flutter/material.dart';
import 'package:matchme/controller/mainpage_controller.dart';
import 'package:provider/provider.dart';
import '../constant.dart';
import "package:flutter_svg/flutter_svg.dart";

class MyNotification extends StatefulWidget {
  const MyNotification({super.key});

  @override
  State<MyNotification> createState() => _MyNotificationState();
}

class _MyNotificationState extends State<MyNotification> {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (!didPop) {
          Provider.of<MainpageController>(
            context,
            listen: false,
          ).updatePosition("home");
          Provider.of<MainpageController>(
            context,
            listen: false,
          ).setBottomIndex(0);
        }
      },
      child: Scaffold(
        body: Stack(
          children: [
            PreferredSize(
              preferredSize: const Size.fromHeight(50.0),
              child: AppBar(
                title: Text(
                  "Notification",
                  style: TextStyle(
                    fontFamily: Constant.haddingFont,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                centerTitle: true,
                toolbarHeight: 80.0,
                leading: IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.arrow_back),
                ),
              ),
            ),
            Positioned(
              right: -5.0,
              child: SvgPicture.asset("assets/images/Frame 2951.svg"),
            ),
            Positioned.fill(
              top: size.height * 0.1,
              child: ListView(
                padding: const EdgeInsets.all(18.0),
                children: [
                  ListTile(
                    title: Text(
                      "Lorem Ipsum is simply dummy text of the printing and typesetting",
                      style: TextStyle(
                        fontSize: 13.0,
                        fontFamily: Constant.subHadding,
                      ),
                    ),
                    subtitle: Text(
                      "1 min Ago",
                      style: TextStyle(
                        fontSize: 10.0,
                        fontFamily: Constant.subHadding,
                      ),
                    ),
                    leading: const CircleAvatar(
                      backgroundImage: NetworkImage(
                        'https://t3.ftcdn.net/jpg/02/43/12/34/360_F_243123463_zTooub557xEWABDLk0jJklDyLSGl2jrr.webp',
                      ),
                      radius: 20.0,
                    ),
                  ),
                  ListTile(
                    title: Text(
                      "Lorem Ipsum is simply dummy text of the printing and typesetting",
                      style: TextStyle(
                        fontSize: 13.0,
                        fontFamily: Constant.subHadding,
                      ),
                    ),
                    subtitle: Text(
                      "1 min Ago",
                      style: TextStyle(
                        fontSize: 10.0,
                        fontFamily: Constant.subHadding,
                      ),
                    ),
                    leading: const CircleAvatar(
                      backgroundImage: NetworkImage(
                        'https://t3.ftcdn.net/jpg/02/43/12/34/360_F_243123463_zTooub557xEWABDLk0jJklDyLSGl2jrr.webp',
                      ),
                      radius: 20.0,
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
