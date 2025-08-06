import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:matchme/constant.dart';
import 'package:matchme/controller/interest_controller.dart';
import 'package:matchme/controller/match_controller.dart';
import 'package:matchme/controller/register_controller.dart';
import 'package:matchme/widgets/match_bottomsheet.dart';
import 'package:provider/provider.dart';

class UserDetailProfile extends StatefulWidget {
  final String page;
  const UserDetailProfile({super.key, required this.page});

  @override
  State<UserDetailProfile> createState() => _UserDetailProfileState();
}

class _UserDetailProfileState extends State<UserDetailProfile> {
  String formattedDate = "";
  List<dynamic> interest = [];
  Map<String, dynamic> userData = {};

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    userData =
        Provider.of<MatchController>(context, listen: true).profileDetails;

    DateTime? dob = DateTime.parse(userData['dob']);
    formattedDate = DateFormat('dd MMM yyyy').format(dob.toLocal());
    interest = userData['interests'];

    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 80.0,
          title: Image.asset(
            "assets/images/matchme-logo 2.png",
            height: 40.0,
          ),
          centerTitle: true,
          bottom: const TabBar(
            labelStyle: TextStyle(fontSize: 18.0),
            tabs: [
              Tab(text: 'Personal'),
              Tab(text: 'Work'),
              Tab(text: 'Family'),
              Tab(text: 'Lifestyle'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            personalDetail(),
            workDetails(),
            familyDetails(),
            lifeStyleDetails()
          ],
        ),
        bottomSheet: widget.page == "match"
            ? MatchBottomsheet(
                id: userData['_id'],
                isDetail: true,
              )
            : widget.page == "interestreceive"
                ? Container(
                    width: double.infinity,
                    height: size.height * 0.085,
                    decoration: const BoxDecoration(
                      // color: Constant.highlightColor,
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(80.0),
                        topRight: Radius.circular(80.0),
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
                            Navigator.pop(context);
                          },
                          child: Container(
                            height: 50.0,
                            width: 50.0,
                            decoration: BoxDecoration(
                              color: Constant.highlightColor,
                              borderRadius: BorderRadius.circular(50.0),
                            ),
                            child: const Icon(
                              Icons.close,
                              color: Colors.black,
                              size: 30.0,
                            ),
                          ),
                        ),
                        const SizedBox(width: 50.0),
                        // Favorite button;
                        InkWell(
                          onTap: () async {
                            await Provider.of<InterestController>(
                              context,
                              listen: false,
                            ).sendConnection(userData['_id'], 1, context);

                            Navigator.pop(context);
                            Navigator.pop(context);
                          },
                          child: Container(
                            height: 50.0,
                            width: 50.0,
                            decoration: BoxDecoration(
                              color: const Color(0xFF0C5461),
                              borderRadius: BorderRadius.circular(50.0),
                            ),
                            child: const Icon(Icons.favorite_rounded,
                                color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  )
                : const SizedBox.shrink(),
      ),
    );
  }

  Widget profileTitle(String title) {
    return Text(
      title,
      style: TextStyle(
        fontFamily: Constant.haddingFont,
        color: Constant.highlightColor,
        fontSize: 19.0,
      ),
    );
  }

  Widget subTitle(String title) {
    return Text(
      title,
      style: TextStyle(
        fontFamily: Constant.subHadding,
        fontWeight: FontWeight.bold,
        color: const Color(0xFF033A44),
        fontSize: 17.0,
      ),
    );
  }

// :::::::::::::::::::::::::::::::::: ALL DETAILS SCREENS ::::::::::::::::::::::::::::
  Widget personalDetail() {
    return ListView(
      children: [
        ListTile(
          title: profileTitle("Name"),
          subtitle: subTitle(userData['full_name']),
        ),
        ListTile(
          title: profileTitle("Gender"),
          subtitle: subTitle(userData['gender']),
        ),
        ListTile(
          title: profileTitle("Height"),
          subtitle: subTitle(
              "${userData['height'].split(".")[0]}'${userData['height'].split(".")[1]}"),
        ),
        ListTile(
          title: profileTitle("Date of Birth"),
          subtitle: subTitle(formattedDate),
        ),
        ListTile(
          title: profileTitle("Place of Birth"),
          subtitle: subTitle(userData['birth_place']),
        ),
        ListTile(
          title: profileTitle("Marital Status"),
          subtitle: subTitle(userData['marital_status']),
        ),
        ListTile(
          title: profileTitle("Address"),
          subtitle: subTitle("${userData['country']}, ${userData['city']}"),
        ),
        ListTile(
          title: profileTitle("Hometown"),
          subtitle: subTitle(userData['hometown']),
        ),
        ListTile(
          title: profileTitle("Nationality"),
          subtitle: subTitle(userData['nationality']),
        ),
        userData['should_weight_display_on_profile'] != true
            ? ListTile(
                title: profileTitle("Weight"),
                subtitle: subTitle(
                    "${userData['weight'].split(" ")[0]} ${userData['weight'].split(" ")[1]}"),
              )
            : const SizedBox.shrink(),
        ListTile(
          title: profileTitle("Relegion"),
          subtitle: subTitle(userData['religion']),
        ),
      ],
    );
  }

  Widget workDetails() {
    return ListView(
      padding: const EdgeInsets.all(10.0),
      children: [
        const SizedBox(height: 10.0),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: Text(
            "Business",
            style: TextStyle(
              fontSize: 25.0,
              color: Color(0xFF033A44),
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        ListTile(
          title: profileTitle("Designation"),
          subtitle: subTitle(userData['designation']),
        ),
        ListTile(
          title: profileTitle("Organization"),
          subtitle: subTitle(userData['organization']),
        ),
        ListTile(
          title: profileTitle("Personal Anua Income"),
          subtitle: subTitle(userData['personal_anual_income']),
        ),
        RegisterController.turnover.text != ""
            ? ListTile(
                title: profileTitle("Business Turnover"),
                subtitle: subTitle(userData['business_turnover']),
              )
            : const SizedBox.shrink(),
        ListTile(
          title: profileTitle("Indusry"),
          subtitle: subTitle(userData['industry']),
        ),
        RegisterController.website.text != ""
            ? ListTile(
                title: profileTitle("Business Website"),
                subtitle: subTitle(userData['business_website']),
              )
            : const SizedBox.shrink(),
        const Padding(
          padding: EdgeInsets.all(20.0),
          child: Text(
            "Education",
            style: TextStyle(
              fontSize: 25.0,
              color: Color(0xFF033A44),
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        ListTile(
          title: profileTitle("Highest Degree"),
          subtitle: subTitle(userData['highest_degree']),
        ),
        ListTile(
          title: profileTitle("School Name"),
          subtitle: subTitle(userData['school_name']),
        ),
        userData['ug_college_name'] != ""
            ? ListTile(
                title: profileTitle("UG College Name"),
                subtitle: subTitle(userData['ug_college_name']),
              )
            : const SizedBox.shrink(),
        userData['pg_college_name'] != ""
            ? ListTile(
                title: profileTitle("PG College Name"),
                subtitle: subTitle(userData['pg_college_name']),
              )
            : const SizedBox.shrink(),
        userData['phd_college_name'] != ""
            ? ListTile(
                title: profileTitle("PHD College Name"),
                subtitle: subTitle(userData['phd_college_name']),
              )
            : const SizedBox.shrink(),
      ],
    );
  }

  Widget familyDetails() {
    return ListView(
      padding: const EdgeInsets.all(10.0),
      children: [
        ListTile(
          title: profileTitle("Father's Name"),
          subtitle: subTitle(userData['father_name']),
        ),
        ListTile(
          title: profileTitle("Mother's Name"),
          subtitle: subTitle(userData['mother_name']),
        ),
        ListTile(
          title: profileTitle("Father Occupation"),
          subtitle: subTitle(userData['father_occupation']),
        ),
        ListTile(
          title: profileTitle("Mother Occupation"),
          subtitle: subTitle(userData['mother_occupation']),
        ),
        ListTile(
          title: profileTitle("Number of Siblings"),
          subtitle: subTitle(userData['no_of_siblings']),
        ),
        ListTile(
          title: profileTitle("Family Annual Income"),
          subtitle: subTitle(userData['family_anual_income']),
        ),
        ListTile(
          title: profileTitle("Nature of Occupation"),
          subtitle: subTitle(userData['family_background']),
        ),
        ListTile(
          title: profileTitle("Family Description"),
          subtitle: subTitle(userData['family_description']),
        )
      ],
    );
  }

  Widget lifeStyleDetails() {
    return ListView(
      padding: const EdgeInsets.all(10.0),
      children: [
        ListTile(
          title: profileTitle("Eating Preference"),
          subtitle: subTitle(userData['eating_preferences']),
        ),
        ListTile(
          title: profileTitle("Do you Drink?"),
          subtitle: subTitle(userData['how_often_you_drink']),
        ),
        ListTile(
          title: profileTitle("Do you Smoker?"),
          subtitle: subTitle(userData['are_you_a_smoker']),
        ),
        ListTile(
          title: profileTitle("How spiritual are you?"),
          subtitle: subTitle(userData['how_spiritual_are_you']),
        ),
        ListTile(
          title: profileTitle("How religious are You?"),
          subtitle: subTitle(userData['how_religious_are_you']),
        ),
        ListTile(
          title: profileTitle("How often do you eat out?"),
          subtitle: subTitle(userData['how_often_you_eat_out']),
        ),
        ListTile(
          title: profileTitle("How often do you work out?"),
          subtitle: subTitle(userData['how_often_you_workout']),
        ),
        ListTile(
          title: profileTitle("What type of holidays you prefer"),
          subtitle: subTitle(userData['holidays_prefrences'].join(",\t")),
        ),
        ListTile(
          title: profileTitle("How often do you travel? (For leisure)"),
          subtitle: subTitle(userData['how_often_you_travel']),
        ),
        // ListTile(
        //   title: profileTitle("Your preferred social events"),
        //   subtitle: subTitle(RegisterController.socialise),
        // ),
        ListTile(
          title: profileTitle("Interests"),
          subtitle: subTitle(interest.join(",\t")),
        ),
      ],
    );
  }
}
