import 'package:flutter/material.dart';
import "package:flutter_svg/flutter_svg.dart";
import 'package:flutter_animate/flutter_animate.dart';
import 'package:matchme/controller/login_controller.dart';
import 'package:matchme/controller/match_controller.dart';
import 'package:matchme/controller/notification_controller.dart';
import 'package:matchme/controller/preferance_controller.dart';
import 'package:matchme/controller/profile_controller.dart';
import 'package:matchme/controller/psychometric_controller.dart';
import 'package:matchme/helper/get_age_from_dob.dart';
import 'package:matchme/screen/connection.dart';
import 'package:matchme/screen/interest_received.dart';
import 'package:matchme/screen/interest_send.dart';
import 'package:matchme/screen/personal_fst_details.dart';
import 'package:matchme/screen/preference.dart';
import 'package:matchme/screen/psychometric.dart';
import 'package:matchme/screen/support.dart';
import 'package:matchme/screen/user_profile.dart';
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
  int currentIndex = 0;
  List<dynamic>? matchData;
  bool isNotification = true;

  @override
  void initState() {
    super.initState();

    // Setup Firebase message
    NotificationController.setupFirebaseMessaging();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      // var fcm = await FirebaseMessaging.instance.getToken();
      // print(fcm);
      // Call Get userdata function ::::::::
      await Provider.of<ProfileController>(context, listen: false)
          .getUserData(context);

      if (!mounted) return;
      Provider.of<ProfileController>(context, listen: false).setData();

      await Provider.of<PreferanceController>(context, listen: false)
          .getData(context);

      if (!mounted) return;

      Provider.of<MatchController>(context, listen: false).getMatches();
      isNotification =
          await NotificationController.isNotificationPermissionGranted();
    });
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    final matches = Provider.of<MatchController>(context, listen: true)
            .allMatches?['matches'] ??
        [];

    matchData = matches.sublist(0, matches.length >= 3 ? 3 : matches.length);

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
                Visibility(
                  visible: isNotification != true ? true : false,
                  child: const NotificationPopup().animate().slide(
                        begin: const Offset(0, -1), // from top
                        end: Offset.zero, // to its normal position
                        curve: Curves.easeOut,
                        duration: 400.ms,
                      ),
                ),
                const SizedBox(height: 30.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "New Matches",
                      style: TextStyle(
                        fontFamily: Constant.haddingFont,
                        color: const Color(0xFF033A44),
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    PopupMenuButton(
                      icon: const CircleAvatar(
                        child: Icon(Icons.more_vert),
                      ),
                      itemBuilder: (context) {
                        return [
                          const PopupMenuItem(child: Text("My Profile")),
                          PopupMenuItem(
                            onTap: () {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                return const Support();
                              }));
                            },
                            child: const Text("Inbox"),
                          ),
                          PopupMenuItem(
                            onTap: () {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                return const PersonalFstDetails();
                              }));
                            },
                            child: const Text("Edit Profile"),
                          ),
                          PopupMenuItem(
                            onTap: () {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                return const Preference();
                              }));
                            },
                            child: const Text("Edit Preferences"),
                          ),
                          PopupMenuItem(
                            onTap: () {
                              Provider.of<MainpageController>(
                                context,
                                listen: false,
                              ).updatePosition("heart");
                              Provider.of<MainpageController>(
                                context,
                                listen: false,
                              ).setBottomIndex(1);
                            },
                            child: const Text("Matches"),
                          ),
                          PopupMenuItem(
                            onTap: () {
                              showInterestSheet(size);
                            },
                            child: const Text("Interest"),
                          ),
                          PopupMenuItem(
                              onTap: () {
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) {
                                  return const Connection();
                                }));
                              },
                              child: const Text("Connection")),
                          PopupMenuItem(
                            onTap: () {
                              Provider.of<LoginController>(
                                context,
                                listen: false,
                              ).logout(context);
                            },
                            child: const Text("Logout"),
                          ),
                        ];
                      },
                    )
                  ],
                ),

                // ::::::::::::::::::::::::::::::::::::::::::: SLIDER HERE :::::::::::::::::::::::::::::::::::::
                matchData!.isNotEmpty
                    ? Stack(
                        clipBehavior: Clip.none,
                        children: [
                          Container(
                            margin: const EdgeInsets.only(top: 10.0),
                            width: double.infinity,
                            height: size.height * 0.5 / 2,
                            child: PageView.builder(
                              itemCount: matchData!.length,
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

                                        //  Color.fromARGB(255, 234, 222, 190),
                                        //  Color.fromARGB(255, 233, 215, 171),
                                        //  Color(0xFFc6b27f)
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
                                            "${Constant.imageUrl}${matchData![index]['match_user_id']['image']['one']}",
                                            fit: BoxFit.cover,
                                            height: double.infinity,
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 10.0),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                "${matchData![index]['match_user_id']['full_name']}",
                                                overflow: TextOverflow.clip,
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  fontFamily:
                                                      Constant.haddingFont,
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 26.0,
                                                  color: const Color.fromARGB(
                                                      255, 234, 222, 190),
                                                ),
                                              ),
                                              Text(
                                                "${matchData![index]['match_user_id']['designation']} , Age ${getAgeFromYMD(matchData![index]['match_user_id']['dob'])}",
                                                style: TextStyle(
                                                  fontSize: 15.0,
                                                  color: const Color.fromARGB(
                                                      255, 234, 222, 190),
                                                  fontFamily:
                                                      Constant.subHadding,
                                                ),
                                              ),
                                              const SizedBox(height: 10.0),
                                              MaterialButton(
                                                onPressed: () {
                                                  Provider.of<MatchController>(
                                                          context,
                                                          listen: false)
                                                      .setProfileDetails(index);
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              const UserProfile(
                                                                  page:
                                                                      "match")));
                                                },
                                                color: const Color(0xFF033A44),
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                ),
                                                child: Text.rich(
                                                  TextSpan(
                                                    style: TextStyle(
                                                      fontFamily:
                                                          Constant.haddingFont,
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
                                        ),
                                      )
                                    ],
                                  ),
                                );
                              },
                            ),
                          ),
                          Positioned(
                            bottom: -20.0,
                            right: 0.0,
                            left: 0.0,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                for (int i = 0; i < matchData!.length; i++)
                                  AnimatedContainer(
                                    duration: const Duration(milliseconds: 300),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(40.0),
                                      color: currentIndex == i
                                          ? Colors.black
                                          : const Color(0xFF0C5461),
                                    ),
                                    width: currentIndex == i ? 30 : 15.0,
                                    height: 4.0,
                                    margin: const EdgeInsets.only(right: 10.0),
                                  ),
                              ],
                            ),
                          )
                        ],
                      )
                    : SizedBox(
                        width: double.infinity,
                        height: size.height * 0.5 / 2,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.person_search_outlined,
                              size: 70.0,
                              color: Color.fromARGB(255, 223, 221, 221),
                            ),
                            const SizedBox(height: 20.0),
                            Text(
                              "No new matches available",
                              style: TextStyle(
                                fontSize: 20.0,
                                fontFamily: Constant.subHadding,
                              ),
                            ),
                          ],
                        ),
                      ),
                // ::::::::::::::::::::::::::::::::::::::::::: BUTTONS START HERE ::::::::::::::::::::::::::::::::::::
                const SizedBox(height: 60.0),
                Provider.of<ProfileController>(context, listen: true)
                            .isPsycho !=
                        true
                    ? InkWell(
                        onTap: () {
                          Provider.of<PsychometricController>(
                            context,
                            listen: false,
                          ).getQuestions();
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return const Psychometric();
                          }));
                        },
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10.0, vertical: 15.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            gradient: const LinearGradient(
                              colors: [
                                Color.fromARGB(255, 80, 137, 147),
                                Color(0xFF245C66)
                              ],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                            ),
                          ),
                          child: Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(
                                  Icons.psychology_alt_sharp,
                                  color: Colors.white,
                                  size: 33.0,
                                ),
                                const SizedBox(width: 10.0),
                                Text(
                                  "Psychometric Test",
                                  style: TextStyle(
                                    fontFamily: Constant.haddingFont,
                                    color: Colors.white,
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                    : const Text(""),
                SizedBox(
                  height: Provider.of<ProfileController>(context, listen: true)
                              .isPsycho !=
                          true
                      ? 15.0
                      : 0.0,
                ),
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
                      icon: Icons.chat_rounded,
                      text: "Inbox",
                      onChange: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => const Support()),
                        );
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
                      onChange: () {
                        Provider.of<MainpageController>(context, listen: false)
                            .updatePosition("heart");
                        Provider.of<MainpageController>(context, listen: false)
                            .setBottomIndex(1);
                      },
                    ),
                    const SizedBox(width: 15.0),
                    DashboardButton(
                      icon: Icons.join_inner,
                      text: "Interest",
                      onChange: () {
                        showInterestSheet(size);
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 15.0),
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const Connection(),
                      ),
                    );
                  },
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10.0, vertical: 10.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      gradient: const LinearGradient(
                        colors: [
                          Color.fromARGB(255, 80, 137, 147),
                          Color(0xFF245C66)
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                    ),
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            "assets/icons/connection.png",
                            height: 35.0,
                          ),
                          const SizedBox(width: 10.0),
                          Text(
                            "Connection",
                            style: TextStyle(
                              fontFamily: Constant.haddingFont,
                              color: Colors.white,
                              fontSize: 20.0,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  showInterestSheet(Size size) {
    return showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
      backgroundColor: const Color(0xFF81979B),
      builder: (context) {
        return SafeArea(
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 10.0,
            ),
            height: size.height * 0.170,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 8),
                const Icon(
                  Icons.horizontal_rule_outlined,
                  size: 35.0,
                  color: Colors.white70,
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: MaterialButton(
                        height: 60.0,
                        onPressed: () {
                          Navigator.pop(context);
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const InterestReceived(),
                              ));
                        },
                        color: Colors.white,
                        textColor: Colors.black,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.favorite_border),
                            SizedBox(width: 5),
                            Text(
                              "Interest Received",
                              style: TextStyle(fontSize: 14.0),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 10.0),
                    Expanded(
                      child: MaterialButton(
                        height: 60.0,
                        onPressed: () {
                          Navigator.pop(context);
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const InterestSend(),
                              ));
                        },
                        color: Colors.white,
                        textColor: Colors.black,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.send),
                            SizedBox(width: 5),
                            Text(
                              "Interest Sent",
                              style: TextStyle(fontSize: 14.0),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
