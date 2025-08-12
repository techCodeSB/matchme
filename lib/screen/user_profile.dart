import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:matchme/controller/interest_controller.dart';
import 'package:matchme/controller/match_controller.dart';
import 'package:matchme/helper/get_age_from_dob.dart';
import 'package:matchme/screen/user_detail_profile.dart';
import 'package:matchme/widgets/line.dart';
import 'package:matchme/widgets/match_bottomsheet.dart';
import 'package:provider/provider.dart';
import '../widgets/slider.dart';
import '../constant.dart';

class UserProfile extends StatefulWidget {
  final String page;
  const UserProfile({
    super.key,
    required this.page,
  });

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  Map<String, dynamic> userData = {};

  @override
  Widget build(BuildContext context) {
    userData =
        Provider.of<MatchController>(context, listen: true).profileDetails;

    DateTime? dob = DateTime.parse(userData['dob']);
    String formattedDate = DateFormat('dd MMM yyyy').format(dob.toLocal());
    final Size size = MediaQuery.of(context).size;
    List<dynamic> interest = userData['interests'];

    return Scaffold(
      body: SafeArea(
        child: Container(
          width: double.infinity,
          height: double.infinity,
          color: Colors.white,
          child: ListView(
            padding: const EdgeInsets.only(bottom: 20.0),
            children: [
              SizedBox(
                width: double.infinity,
                height: size.height * 0.9 / 2,
                child: Stack(
                  children: [
                    ProfileSlider(
                      imgs: [
                        userData["image"]["one"],
                        userData["image"]["two"],
                        userData["image"]["three"],
                        userData["image"]["four"],
                      ],
                    ),
                    // ::::::::::::::::: TOP BUTTON ::::::::::::::::::
                    Positioned(
                      left: 20.0,
                      right: 20.0,
                      top: 10.0,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: const CircleAvatar(
                              backgroundColor: Colors.white,
                              child: Icon(Icons.arrow_back_ios_sharp),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20.0),
              // :::::::::::::::::::::::::::::::::::::::::::: PROFILE INFO ::::::::::::::::::::::::::::::::::::::::
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text.rich(
                      TextSpan(
                        text:
                            "${userData['full_name']}, ${getAgeFromYMD(userData['dob'])}",
                        style: TextStyle(
                          fontSize: 25.0,
                          fontFamily: Constant.haddingFont,
                          color: const Color(0xFF033A44),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Text.rich(
                      TextSpan(
                        children: [
                          WidgetSpan(
                            child: Icon(
                              Icons.location_on_rounded,
                              color: Constant.highlightColor,
                              size: 18.0,
                            ),
                          ),
                          TextSpan(
                            text: "${userData['country']}, ${userData['city']}",
                            style: TextStyle(
                              fontSize: 15.0,
                              fontFamily: Constant.subHadding,
                              color: const Color(0xFF1690A7),
                            ),
                          )
                        ],
                      ),
                    ),
                    const Line(),
                    const SizedBox(height: 25.0),
                    profileTitle("Birth Date and Time"),
                    Text.rich(
                      TextSpan(
                        children: [
                          WidgetSpan(
                            child: Icon(
                              Icons.date_range,
                              color: Constant.highlightColor,
                              size: 18.0,
                            ),
                          ),
                          TextSpan(
                            text: "\t$formattedDate, ${userData['birth_time']}",
                            style: TextStyle(
                              fontSize: 15.0,
                              fontFamily: Constant.subHadding,
                              color: Colors.black,
                            ),
                          )
                        ],
                      ),
                    ),
                    const Line(),
                    const SizedBox(height: 25.0),
                    profileTitle("Height"),
                    Text.rich(
                      TextSpan(
                        children: [
                          WidgetSpan(
                            child: Icon(
                              Icons.height,
                              color: Constant.highlightColor,
                              size: 18.0,
                            ),
                          ),
                          TextSpan(
                            text:
                                "\t${userData['height'].split(".")[0]}'${userData['height'].split(".")[1]}",
                            style: TextStyle(
                              fontSize: 15.0,
                              fontFamily: Constant.subHadding,
                              color: Colors.black,
                            ),
                          )
                        ],
                      ),
                    ),
                    const Line(),
                    const SizedBox(height: 25.0),
                    profileTitle("Marital Status"),
                    Text.rich(
                      TextSpan(
                        children: [
                          WidgetSpan(
                            child: Icon(
                              Icons.contact_emergency_outlined,
                              color: Constant.highlightColor,
                              size: 18.0,
                            ),
                          ),
                          TextSpan(
                            text: "\t${userData['marital_status']}",
                            style: TextStyle(
                              fontSize: 16.0,
                              fontFamily: Constant.subHadding,
                              color: Colors.black,
                            ),
                          )
                        ],
                      ),
                    ),
                    const Line(),
                    const SizedBox(height: 25.0),
                    profileTitle("Something About Me"),
                    Text(
                      userData['about_yourself'],
                      style: TextStyle(
                        fontFamily: Constant.subHadding,
                        fontSize: 15.0,
                        color: Colors.black,
                        overflow: TextOverflow.clip,
                      ),
                    ),
                    const Line(),
                    const SizedBox(height: 25.0),
                    Text.rich(
                      TextSpan(
                        children: [
                          WidgetSpan(
                            child: Icon(
                              Icons.work_outline_outlined,
                              color: Constant.highlightColor,
                              size: 18.0,
                            ),
                          ),
                          TextSpan(
                            text: "\t${userData['designation']}",
                            style: TextStyle(
                              fontSize: 15.0,
                              fontFamily: Constant.subHadding,
                              color: Colors.black,
                            ),
                          )
                        ],
                      ),
                    ),
                    const Line(),
                    const SizedBox(height: 25.0),
                    Text.rich(
                      TextSpan(
                        children: [
                          WidgetSpan(
                            child: Icon(
                              Icons.cast_for_education,
                              color: Constant.highlightColor,
                              size: 18.0,
                            ),
                          ),
                          TextSpan(
                            text: "\t${userData['highest_qualification']}",
                            style: TextStyle(
                              fontSize: 15.0,
                              fontFamily: Constant.subHadding,
                              color: Colors.black,
                            ),
                          )
                        ],
                      ),
                    ),
                    const Line(),
                    const SizedBox(height: 25.0),
                    profileTitle("Interset"),
                    const SizedBox(height: 5.0),
                    Wrap(
                      spacing: 10.0,
                      runSpacing: 10.0,
                      children: interest.map((e) {
                        return Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20.0, vertical: 5.0),
                          decoration: BoxDecoration(
                            color: Constant.highlightColor,
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          child: Text(
                            e,
                            style: const TextStyle(
                              color: Colors.white,
                            ), // optional styling
                          ),
                        );
                      }).toList(),
                    ),
                    const Line(),
                    const SizedBox(height: 25.0),
                    profileTitle("How Often Do You Travel?"),
                    Text.rich(
                      TextSpan(
                        children: [
                          WidgetSpan(
                            child: Icon(
                              Icons.travel_explore_outlined,
                              color: Constant.highlightColor,
                              size: 18.0,
                            ),
                          ),
                          TextSpan(
                            text: "\t${userData['how_often_you_travel']}",
                            style: TextStyle(
                              fontSize: 15.0,
                              fontFamily: Constant.subHadding,
                              color: Colors.black,
                            ),
                          )
                        ],
                      ),
                    ),
                    const Line(),
                    const SizedBox(height: 25.0),
                    profileTitle("Do You Socialise?"),
                    Text.rich(
                      TextSpan(
                        children: [
                          WidgetSpan(
                            child: Icon(
                              Icons.social_distance,
                              color: Constant.highlightColor,
                              size: 18.0,
                            ),
                          ),
                          TextSpan(
                            text: "\t${userData['prefered_social_event']}",
                            style: TextStyle(
                              fontSize: 15.0,
                              fontFamily: Constant.subHadding,
                              color: Colors.black,
                            ),
                          )
                        ],
                      ),
                    ),
                    const Line(),
                    const SizedBox(height: 25.0),
                    profileTitle("How Often Do You Eat Out?"),
                    Text.rich(
                      TextSpan(
                        children: [
                          WidgetSpan(
                            child: Icon(
                              Icons.dinner_dining,
                              color: Constant.highlightColor,
                              size: 18.0,
                            ),
                          ),
                          TextSpan(
                            text: "\t${userData['how_often_you_eat_out']}",
                            style: TextStyle(
                              fontSize: 15.0,
                              fontFamily: Constant.subHadding,
                              color: Colors.black,
                            ),
                          )
                        ],
                      ),
                    ),
                    const Line(),
                    const SizedBox(height: 25.0),
                    profileTitle("Whom Do You Mostly Go Out With?"),
                    Text.rich(
                      TextSpan(
                        children: [
                          WidgetSpan(
                            child: Icon(
                              Icons.people_outline_rounded,
                              color: Constant.highlightColor,
                              size: 18.0,
                            ),
                          ),
                          TextSpan(
                            text:
                                "\t${userData['whom_do_you_like_going_out_with']}",
                            style: TextStyle(
                              fontSize: 15.0,
                              fontFamily: Constant.subHadding,
                              color: Colors.black,
                            ),
                          )
                        ],
                      ),
                    ),
                    const Line(),
                    const SizedBox(height: 20.0),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20.0),
                      child: MaterialButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => UserDetailProfile(
                                page: widget.page,
                              ),
                            ),
                          );
                        },
                        color: const Color(0xFF033A44),
                        height: 50.0,
                        minWidth: double.infinity,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Text(
                          'Detailed Profile',
                          style: TextStyle(
                            fontFamily: Constant.haddingFont,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            letterSpacing: 1.0,
                            fontSize: 18.0,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                  height:
                      widget.page == "match" || widget.page == "interestreceive"
                          ? 60.0
                          : 0.0),
            ],
          ),
        ),
      ),
      bottomSheet: widget.page == "match"
          ? MatchBottomsheet(id: userData['_id'])
          : widget.page == "interestreceive"
              ? Container(
                  width: double.infinity,
                  height: size.height * 0.10,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40.0),
                      topRight: Radius.circular(40.0),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Color.fromARGB(255, 197, 193, 193),
                        blurRadius: 8.0,
                        spreadRadius: 5.0,
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Close || dislike Button;
                      InkWell(
                        onTap: () async {
                          await Provider.of<InterestController>(
                            context,
                            listen: false,
                          ).sendConnection(userData['_id'], 0, context);
                          Navigator.pop(context);
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              height: 50.0,
                              width: 50.0,
                              decoration: BoxDecoration(
                                color: Constant.highlightColor,
                                borderRadius: BorderRadius.circular(50.0),
                              ),
                              child: const Icon(
                                Icons.thumb_down_off_alt_outlined,
                                color: Colors.white,
                                size: 30.0,
                              ),
                            ),
                            const SizedBox(height: 5.0),
                            const Text(
                              "Reject",
                              style: TextStyle(fontSize: 13.0),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 70.0),
                      // Favorite button;
                      InkWell(
                        onTap: () async {
                          await Provider.of<InterestController>(
                            context,
                            listen: false,
                          ).sendConnection(userData['_id'], 1, context);

                          Navigator.pop(context);
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              height: 50.0,
                              width: 50.0,
                              decoration: BoxDecoration(
                                color: const Color(0xFF0C5461),
                                borderRadius: BorderRadius.circular(50.0),
                              ),
                              child: const Icon(Icons.favorite_rounded,
                                  color: Colors.white),
                            ),
                            const SizedBox(height: 5.0),
                            const Text(
                              "Accept",
                              style: TextStyle(fontSize: 13.0),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              : const SizedBox.shrink(),
    );
  }

  // :::::::::::::::::::::::::::::::::: PROFILE TITLE WIDGET ::::::::::::::::::::::
  Widget profileTitle(String title) {
    return Text(
      title,
      style: TextStyle(
        fontFamily: Constant.haddingFont,
        fontWeight: FontWeight.bold,
        color: const Color(0xFF033A44),
        fontSize: 16.0,
      ),
    );
  }
}
