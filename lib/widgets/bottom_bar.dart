import 'package:flutter/material.dart';
import 'package:matchme/constant.dart';
// import "package:flutter_svg/flutter_svg.dart";
import 'package:matchme/controller/mainpage_controller.dart';
import 'package:matchme/controller/profile_controller.dart';
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
      color: Colors.transparent,
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
          Container(
            height: 80.0,
            width: double.infinity,
            decoration: BoxDecoration(
              image: const DecorationImage(
                image: AssetImage("assets/icons/bottomnav.png"),
                fit: BoxFit.cover,
              ),
              borderRadius: BorderRadius.circular(30.0),
              boxShadow: [
                BoxShadow(
                  color:
                      const Color.fromARGB(255, 197, 193, 193).withOpacity(0.3),
                  spreadRadius: 2,
                  blurRadius: 6,
                  offset: Offset(0, 3),
                ),
              ],
            ),
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
                    // child: Icon(
                    //   Icons.join_inner_outlined,
                    //   size: 30.0,
                    //   color: activeIcon == "heart"? Colors.grey: Colors.black,
                    // ),
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
                    child: CircleAvatar(
                      radius: 15,
                      backgroundImage: Provider.of<ProfileController>(context,
                                      listen: true)
                                  .userData['image']?["one"] ==
                              null
                          ? const NetworkImage(
                              "https://tisindia.net/profile/profile-4.jpg")
                          : NetworkImage(
                              "${Constant.imageUrl}${Provider.of<ProfileController>(context, listen: true).userData['image']["one"]}"),
                      // child: const Text("S"),
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
