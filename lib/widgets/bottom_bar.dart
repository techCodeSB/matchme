import 'package:flutter/material.dart';
// import "package:flutter_svg/flutter_svg.dart";
import 'package:matchme/controller/mainpage_controller.dart';
import 'package:provider/provider.dart';

class BottomBar extends StatefulWidget {
  const BottomBar({super.key});

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  String? activeIcon;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final size = MediaQuery.of(context).size;
      Map<String, double> position = {
        "profile": -8.0,
        "notification": size.width * 0.25,
        "heart": size.width * 0.52,
        "home": size.width * 0.79,
      };

      Provider.of<MainpageController>(context, listen: false)
          .setPosition(position);
      Provider.of<MainpageController>(context, listen: false)
          .updatePosition("home");
    });
  }

  @override
  Widget build(BuildContext context) {
    activeIcon =
        Provider.of<MainpageController>(context, listen: true).activeIcon;

    return Container(
      clipBehavior: Clip.none,
      padding: EdgeInsets.zero,
      width: double.infinity,
      height: 80.0,
      // decoration: const BoxDecoration(
      //   color: Colors.transparent,
      //   image: DecorationImage(
      //     image: AssetImage("assets/icons/bottomnav.png" ),
      //     fit: BoxFit.cover,
      //   ),
      // ),
      child: Stack(
        children: [
          Image.asset(
            "assets/icons/bottomnav.png",
            height: 80.0,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () {
                      Provider.of<MainpageController>(context, listen: false)
                          .updatePosition("home");
                      Provider.of<MainpageController>(context, listen: false)
                          .setBottomIndex(0);
                    },
                    child: Image.asset(
                        "assets/icons/Home${activeIcon == "home" ? "_active" : ""}.png"),
                  ),
                  InkWell(
                    onTap: () {
                      Provider.of<MainpageController>(context, listen: false)
                          .updatePosition("heart");
                      Provider.of<MainpageController>(context, listen: false)
                          .setBottomIndex(1);
                    },
                    child: Image.asset(
                      "assets/icons/Heart${activeIcon == "heart" ? "_active" : ""}.png",
                      height: 25.0,
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Provider.of<MainpageController>(context, listen: false)
                          .updatePosition("notification");
                      Provider.of<MainpageController>(context, listen: false)
                          .setBottomIndex(2);
                    },
                    child: Image.asset(
                      "assets/icons/bell${activeIcon == "notification" ? "_active" : ""}.png",
                      height: 25.0,
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Provider.of<MainpageController>(context, listen: false)
                          .updatePosition("profile");
                      Provider.of<MainpageController>(context, listen: false)
                          .setBottomIndex(3);
                    },
                    child: const CircleAvatar(
                      radius: 15,
                      child: Text("S"),
                    ),
                  ),
                ],
              ),
            ),
          ),
          AnimatedPositioned(
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeInOut,
            right: Provider.of<MainpageController>(
              context,
              listen: true,
            ).currentPosition,
            bottom: 0.0,
            child: Image.asset("assets/icons/Vector 2.png"),
          ),
        ],
      ),
    );
  }
}
