import 'package:flutter/material.dart';
import "package:flutter_svg/flutter_svg.dart";
import 'package:flutter_animate/flutter_animate.dart';
import 'package:matchme/controller/login_controller.dart';
import 'package:matchme/controller/profile_controller.dart';
import 'package:matchme/screen/personal_fst_details.dart';
import 'package:matchme/screen/preference.dart';
import 'package:provider/provider.dart';
import '../controller/mainpage_controller.dart';
import '../widgets/dashboard_button.dart';
import '../widgets/notification_popup.dart';
import '../constant.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  List<String> img = [
    "http://13.203.218.134:1337/uploads/Cancer_Care_F_Image_a80443046f.jpg",
    "http://13.203.218.134:1337/uploads/Cancer_Care_F_Image_a80443046f.jpg",
    "http://13.203.218.134:1337/uploads/Cancer_Care_F_Image_a80443046f.jpg"
  ];
  int currentIndex = 0;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      // Call Get userdata function ::::::::
      await Provider.of<ProfileController>(context, listen: false)
          .getUserData(context);

      Provider.of<ProfileController>(context, listen: false).setData();
    });
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            right: -5.0,
            child: SvgPicture.asset("assets/images/Frame 2951.svg"),
          ),
          Positioned.fill(
            child: ListView(
              padding: const EdgeInsets.all(18.0),
              children: [
                const NotificationPopup().animate().slide(
                      begin: const Offset(0, -1), // from top
                      end: Offset.zero, // to its normal position
                      curve: Curves.easeOut,
                      duration: 400.ms,
                    ),
                const SizedBox(height: 30.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "New Interest",
                      style: TextStyle(
                        fontFamily: Constant.haddingFont,
                        color: const Color(0xFF033A44),
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    PopupMenuButton(
                      itemBuilder: (context) {
                        return [
                          const PopupMenuItem(child: Text("My Profile")),
                          const PopupMenuItem(child: Text("Edit Profile")),
                          const PopupMenuItem(child: Text("Psychometric Test")),
                          const PopupMenuItem(child: Text("Interest")),
                          const PopupMenuItem(child: Text("Inbox")),
                          const PopupMenuItem(child: Text("Edit Preferences")),
                          const PopupMenuItem(child: Text("Matches")),
                          const PopupMenuItem(child: Text("Logout")),
                        ];
                      },
                    )
                  ],
                ),

                // ::::::::::::::::::::::::::::::::::::::::::: SLIDER HERE :::::::::::::::::::::::::::::::::::::
                Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 10.0),
                      width: double.infinity,
                      height: size.height * 0.5 / 2,
                      child: PageView.builder(
                        itemCount: img.length,
                        onPageChanged: (value) {
                          setState(() {
                            currentIndex = value;
                          });
                        },
                        itemBuilder: (context, index) {
                          return Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15.0),
                              gradient: const LinearGradient(
                                colors: [
                                  Color(0xFF81979B),
                                  Color(0xFF81979B),
                                  Color(0xFF0C5461),
                                ],
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                              ),
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  child: ClipRRect(
                                    borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(15.0),
                                      bottomLeft: Radius.circular(15.0),
                                    ),
                                    child: Image.network(
                                      img[index],
                                      fit: BoxFit.cover,
                                      height: double.infinity,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "Rick Smith",
                                        style: TextStyle(
                                          fontFamily: Constant.haddingFont,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 24.0,
                                          color: Colors.white,
                                        ),
                                      ),
                                      Text(
                                        "Businessman , Age 24",
                                        style: TextStyle(
                                          fontSize: 11.0,
                                          color: Colors.white,
                                          fontFamily: Constant.subHadding,
                                        ),
                                      ),
                                      const SizedBox(height: 10.0),
                                      MaterialButton(
                                        onPressed: () {},
                                        color: const Color(0xFF033A44),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                        child: Text.rich(
                                          TextSpan(
                                            style: TextStyle(
                                              fontFamily: Constant.haddingFont,
                                              fontSize: 12.0,
                                              color: Colors.white,
                                            ),
                                            children: const [
                                              TextSpan(
                                                text: "View Now\t",
                                              ),
                                              WidgetSpan(
                                                child: Icon(
                                                  Icons.arrow_forward,
                                                  color: Colors.white,
                                                  size: 12.0,
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                    Positioned(
                      bottom: -25.0,
                      right: 0.0,
                      left: 0.0,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          for (int i = 0; i < img.length; i++)
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(40.0),
                                color: currentIndex == i
                                    ? Colors.black
                                    : const Color(0xFF0C5461),
                              ),
                              width: 30.0,
                              height: 4.0,
                              margin: const EdgeInsets.only(right: 10.0),
                            ),
                        ],
                      ),
                    )
                  ],
                ),
                // ::::::::::::::::::::::::::::::::::::::::::: BUTTONS START HERE ::::::::::::::::::::::::::::::::::::
                const SizedBox(height: 60.0),
                Row(
                  children: [
                    DashboardButton(
                      icon: Icons.account_circle,
                      text: "My Profile",
                      onChange: () {
                        Provider.of<MainpageController>(context, listen: false)
                            .updatePosition("profile");
                        Provider.of<MainpageController>(context, listen: false)
                            .setBottomIndex(3);
                      },
                    ),
                    const SizedBox(width: 15.0),
                    DashboardButton(
                      icon: Icons.edit_square,
                      text: "Edit Profile",
                      onChange: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return const PersonalFstDetails();
                        }));
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 15.0),
                Row(
                  children: [
                    DashboardButton(
                      icon: Icons.psychology_alt_sharp,
                      text: "Psychometric Test",
                      onChange: () {},
                    ),
                    const SizedBox(width: 15.0),
                    DashboardButton(
                      icon: Icons.favorite_rounded,
                      text: "Interest",
                      onChange: () {},
                    ),
                  ],
                ),
                const SizedBox(height: 15.0),
                Row(
                  children: [
                    DashboardButton(
                      icon: Icons.chat_rounded,
                      text: "Inbox",
                      onChange: () {},
                    ),
                    const SizedBox(width: 15.0),
                    DashboardButton(
                      icon: Icons.edit_note_outlined,
                      text: "Edit Preferences",
                      onChange: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return const Preference();
                        }));
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 15.0),
                Row(
                  children: [
                    DashboardButton(
                      icon: Icons.favorite_rounded,
                      text: "Matches",
                      onChange: () {},
                    ),
                    const SizedBox(width: 15.0),
                    DashboardButton(
                      icon: Icons.logout,
                      text: "Logout",
                      onChange: () {
                        Provider.of<LoginController>(context, listen: false).logout(context);
                      },
                    ),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
