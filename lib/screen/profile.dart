import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:matchme/controller/profile_controller.dart';
import 'package:matchme/controller/register_controller.dart';
import 'package:matchme/helper/get_age_from_dob.dart';
import 'package:matchme/screen/detail_profile.dart';
import 'package:matchme/screen/personal_fst_details.dart';
import 'package:matchme/screen/photo_upload.dart';
import 'package:provider/provider.dart';
import '../controller/mainpage_controller.dart';
import '../widgets/slider.dart';
import '../constant.dart';

// ::::::::::::::::::::::::::::::::::::::::::::::::::::
// :::::::::::::: LOGIN USER PROFILE ::::::::::::::::::
// ::::::::::::::::::::::::::::::::::::::::::::::::::::

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    DateTime? dob = RegisterController.dateOfBirth;
    String formattedDate =
        dob != null ? DateFormat('dd MMM yyyy').format(dob.toLocal()) : '';
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
      child: RefreshIndicator(
        key: const PageStorageKey<String>('main_refresh'),
        color: const Color.fromARGB(255, 15, 85, 102),
        backgroundColor: Colors.white,
        displacement: 60.0,
        strokeWidth: 2.5,
        onRefresh: () async {
          HapticFeedback.mediumImpact(); //vibrate on pull

          await Future.delayed(const Duration(milliseconds: 500)); // UX delay

          await Future.microtask(() => MainpageController.reload(context));
        },
        child: Scaffold(
          body: SafeArea(
            child: Container(
              width: double.infinity,
              height: double.infinity,
              color: const Color(0xFFF5F7F7),
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
                            Provider.of<ProfileController>(context,
                                        listen: true)
                                    .userData["image"]?["one"] ??
                                "",
                            Provider.of<ProfileController>(context,
                                        listen: true)
                                    .userData["image"]?["two"] ??
                                "",
                            Provider.of<ProfileController>(context,
                                        listen: true)
                                    .userData["image"]?["three"] ??
                                "",
                          ],
                        ),
                        // ::::::::::::::::: TOP BUTTON ::::::::::::::::::
                        Positioned(
                          left: 20.0,
                          right: 20.0,
                          top: 20.0,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              InkWell(
                                onTap: () {
                                  Provider.of<MainpageController>(
                                    context,
                                    listen: false,
                                  ).updatePosition("home");
                                  Provider.of<MainpageController>(
                                    context,
                                    listen: false,
                                  ).setBottomIndex(0);
                                },
                                child: const CircleAvatar(
                                  backgroundColor: Colors.white,
                                  child: Icon(Icons.arrow_back_ios_sharp),
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (context) {
                                    return const PhotoUpload();
                                  })).then((v) {
                                    Provider.of<ProfileController>(
                                      context,
                                      listen: false,
                                    ).getUserData(context);
                                  });
                                },
                                child: const CircleAvatar(
                                  backgroundColor: Colors.white,
                                  child: Icon(Icons.edit_square),
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
                                "${RegisterController.fullname.text}, ${getAgeFromYMD(RegisterController.dateOfBirth.toString())}",
                            style: TextStyle(
                              fontSize: 25.0,
                              fontFamily: Constant.haddingFont,
                              color: const Color(0xFF033A44),
                              fontWeight: FontWeight.bold,
                            ),
                            children: [
                              WidgetSpan(
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 10.0),
                                  child: InkWell(
                                    onTap: () {
                                      Navigator.push(context,
                                          MaterialPageRoute(builder: (context) {
                                        return const PersonalFstDetails();
                                      }));
                                    },
                                    child: CircleAvatar(
                                      radius: 15.0,
                                      child: Icon(
                                        Icons.edit_square,
                                        size: 17.0,
                                        color: Constant.highlightColor,
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            ],
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
                                text:
                                    "${RegisterController.locality.text}, ${RegisterController.country.text}",
                                style: TextStyle(
                                  fontSize: 17.0,
                                  fontFamily: Constant.subHadding,
                                  color: const Color(0xFF1690A7),
                                ),
                              )
                            ],
                          ),
                        ),
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
                                text:
                                    "\t$formattedDate, ${RegisterController.timeOfBirth}",
                                style: TextStyle(
                                  fontSize: 17.0,
                                  fontFamily: Constant.subHadding,
                                  color: Colors.black,
                                ),
                              )
                            ],
                          ),
                        ),
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
                                    "\t${RegisterController.heightFeet}'${RegisterController.heightInch}",
                                style: TextStyle(
                                  fontSize: 17.0,
                                  fontFamily: Constant.subHadding,
                                  color: Colors.black,
                                ),
                              )
                            ],
                          ),
                        ),
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
                                text: "\t${RegisterController.maritalStatus}",
                                style: TextStyle(
                                  fontSize: 16.0,
                                  fontFamily: Constant.subHadding,
                                  color: Colors.black,
                                ),
                              )
                            ],
                          ),
                        ),
                        const SizedBox(height: 25.0),
                        profileTitle("Something About Me"),
                        Text(
                          RegisterController.introduction.text,
                          style: TextStyle(
                            fontFamily: Constant.subHadding,
                            fontSize: 15.0,
                            color: Colors.black,
                            overflow: TextOverflow.clip,
                          ),
                        ),
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
                                text:
                                    "\t${RegisterController.designation.text}",
                                style: TextStyle(
                                  fontSize: 17.0,
                                  fontFamily: Constant.subHadding,
                                  color: Colors.black,
                                ),
                              )
                            ],
                          ),
                        ),
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
                                text: "\t${RegisterController.qualification}",
                                style: TextStyle(
                                  fontSize: 17.0,
                                  fontFamily: Constant.subHadding,
                                  color: Colors.black,
                                ),
                              )
                            ],
                          ),
                        ),
                        const SizedBox(height: 25.0),
                        profileTitle("Interset"),
                        const SizedBox(height: 5.0),
                        Wrap(
                          spacing: 10.0,
                          runSpacing: 10.0,
                          children: RegisterController.interest.map((e) {
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
                                text: "\t${RegisterController.travle}",
                                style: TextStyle(
                                  fontSize: 17.0,
                                  fontFamily: Constant.subHadding,
                                  color: Colors.black,
                                ),
                              )
                            ],
                          ),
                        ),
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
                                text: "\t${RegisterController.socialise}",
                                style: TextStyle(
                                  fontSize: 17.0,
                                  fontFamily: Constant.subHadding,
                                  color: Colors.black,
                                ),
                              )
                            ],
                          ),
                        ),
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
                                text: "\t${RegisterController.eatOut}",
                                style: TextStyle(
                                  fontSize: 17.0,
                                  fontFamily: Constant.subHadding,
                                  color: Colors.black,
                                ),
                              )
                            ],
                          ),
                        ),
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
                                text: "\t${RegisterController.goOut}",
                                style: TextStyle(
                                  fontSize: 17.0,
                                  fontFamily: Constant.subHadding,
                                  color: Colors.black,
                                ),
                              )
                            ],
                          ),
                        ),
                        const SizedBox(height: 20.0),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 20.0),
                          child: MaterialButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const DetailProfile(),
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
                              'My Detail Profile',
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
                  )
                ],
              ),
            ),
          ),
        ),
      ),
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
        fontSize: 18.0,
      ),
    );
  }
}
