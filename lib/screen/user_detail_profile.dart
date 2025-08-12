import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:matchme/constant.dart';
import 'package:matchme/controller/interest_controller.dart';
import 'package:matchme/controller/match_controller.dart';
import 'package:matchme/controller/register_controller.dart';
import 'package:matchme/widgets/match_bottomsheet.dart';
import 'package:matchme/widgets/profile_details_tile.dart';
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
          bottom: TabBar(
            labelStyle: const TextStyle(fontSize: 18.0),
            labelColor: Constant.highlightColor,
            indicatorColor: Constant.highlightColor,
            tabs: const [
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
                    height: size.height * 0.10,
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
      ),
    );
  }


// :::::::::::::::::::::::::::::::::: ALL DETAILS SCREENS ::::::::::::::::::::::::::::
  Widget personalDetail() {
    return ListView(
      children: [
        buildBorderedTile("Name", userData['full_name']),
        buildBorderedTile("Gender", userData['gender']),
        buildBorderedTile(
          "Height",
          "${userData['height'].split(".")[0]}'${userData['height'].split(".")[1]}",
        ),
        buildBorderedTile("Date of Birth", formattedDate),
        buildBorderedTile("Place of Birth", userData['birth_place']),
        buildBorderedTile("Marital Status", userData['marital_status']),
        buildBorderedTile(
            "Address", "${userData['country']}, ${userData['city']}"),
        buildBorderedTile("Hometown", userData['hometown']),
        buildBorderedTile("Nationality", userData['nationality']),
        if (userData['should_weight_display_on_profile'] != true)
          buildBorderedTile(
            "Weight",
            "${userData['weight'].split(" ")[0]} ${userData['weight'].split(" ")[1]}",
          ),
        buildBorderedTile("Religion", userData['religion']),
        const SizedBox(height: 100.0),
      ],
    );
  }

  Widget workDetails() {
    return ListView(
      padding: const EdgeInsets.all(10.0),
      children: [
        const SizedBox(height: 10.0),

        // Business Section
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.0),
          child: Text(
            "Business",
            style: TextStyle(
              fontSize: 23.0,
              color: Color(0xFF033A44),
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        buildBorderedTile("Designation", userData['designation']),
        buildBorderedTile("Organization", userData['organization']),
        buildBorderedTile(
            "Personal Annual Income", userData['personal_anual_income']),

        if (RegisterController.turnover.text.isNotEmpty)
          buildBorderedTile("Business Turnover", userData['business_turnover']),

        buildBorderedTile("Industry", userData['industry']),

        if (RegisterController.website.text.isNotEmpty)
          buildBorderedTile("Business Website", userData['business_website']),

        // Education Section
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 3.0),
          child: Text(
            "Education",
            style: TextStyle(
              fontSize: 23.0,
              color: Color(0xFF033A44),
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        buildBorderedTile("Highest Degree", userData['highest_degree']),
        buildBorderedTile("School Name", userData['school_name']),

        if (userData['ug_college_name'].isNotEmpty)
          buildBorderedTile("UG College Name", userData['ug_college_name']),

        if (userData['pg_college_name'].isNotEmpty)
          buildBorderedTile("PG College Name", userData['pg_college_name']),

        if (userData['phd_college_name'].isNotEmpty)
          buildBorderedTile("PHD College Name", userData['phd_college_name']),

        const SizedBox(height: 100.0),
      ],
    );
  }

  Widget familyDetails() {
    return ListView(
      padding: const EdgeInsets.all(10.0),
      children: [
        buildBorderedTile("Father's Name", userData['father_name']),
        buildBorderedTile("Mother's Name", userData['mother_name']),
        buildBorderedTile("Father Occupation", userData['father_occupation']),
        buildBorderedTile("Mother Occupation", userData['mother_occupation']),
        buildBorderedTile("Number of Siblings", userData['no_of_siblings']),
        buildBorderedTile(
            "Family Annual Income", userData['family_anual_income']),
        buildBorderedTile(
            "Nature of Occupation", userData['family_background']),
        buildBorderedTile("Family Description", userData['family_description']),
        const SizedBox(height: 100.0),
      ],
    );
  }

  Widget lifeStyleDetails() {
    return ListView(
      padding: const EdgeInsets.all(10.0),
      children: [
        buildBorderedTile("Eating Preference", userData['eating_preferences']),
        buildBorderedTile("Do you Drink?", userData['how_often_you_drink']),
        buildBorderedTile("Do you Smoke?", userData['are_you_a_smoker']),
        buildBorderedTile(
            "How spiritual are you?", userData['how_spiritual_are_you']),
        buildBorderedTile(
            "How religious are you?", userData['how_religious_are_you']),
        buildBorderedTile(
            "How often do you eat out?", userData['how_often_you_eat_out']),
        buildBorderedTile(
            "How often do you work out?", userData['how_often_you_workout']),
        buildBorderedTile("What type of holidays you prefer",
            userData['holidays_prefrences'].join(", ")),
        buildBorderedTile("How often do you travel? (For leisure)",
            userData['how_often_you_travel']),
        buildBorderedTile("Interests", interest.join(", ")),
        const SizedBox(height: 100.0),
      ],
    );
  }
}
