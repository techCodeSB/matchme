import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:matchme/constant.dart';
import 'package:matchme/controller/register_controller.dart';

class DetailProfile extends StatefulWidget {
  const DetailProfile({super.key});

  @override
  State<DetailProfile> createState() => _DetailProfileState();
}

class _DetailProfileState extends State<DetailProfile> {
  String formattedDate = "";

  

  @override
  Widget build(BuildContext context) {
    DateTime? dob = RegisterController.dateOfBirth;
    formattedDate =
        dob != null ? DateFormat('dd MMM yyyy').format(dob.toLocal()) : '';

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
          subtitle: subTitle(RegisterController.fullname.text),
        ),
        ListTile(
          title: profileTitle("Gender"),
          subtitle: subTitle(RegisterController.gender),
        ),
        ListTile(
          title: profileTitle("Height"),
          subtitle: subTitle(
              "${RegisterController.heightFeet}'${RegisterController.heightInch}"),
        ),
        ListTile(
          title: profileTitle("Date of Birth"),
          subtitle: subTitle(formattedDate),
        ),
        ListTile(
          title: profileTitle("Place of Birth"),
          subtitle: subTitle(RegisterController.placeOfBirth.text),
        ),
        ListTile(
          title: profileTitle("Marital Status"),
          subtitle: subTitle(RegisterController.maritalStatus),
        ),
        ListTile(
          title: profileTitle("Address"),
          subtitle: subTitle(
              "${RegisterController.country.text}, ${RegisterController.city.text}"),
        ),
        ListTile(
          title: profileTitle("Hometown"),
          subtitle: subTitle(RegisterController.hometown.text),
        ),
        ListTile(
          title: profileTitle("Nationality"),
          subtitle: subTitle(RegisterController.nationality),
        ),
        RegisterController.showWeightOnProfile != true
            ? ListTile(
                title: profileTitle("Weight"),
                subtitle: subTitle(
                    "${RegisterController.weight.text} ${RegisterController.weightUnit}"),
              )
            : const SizedBox.shrink(),
        ListTile(
          title: profileTitle("Relegion"),
          subtitle: subTitle(RegisterController.religious),
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
          subtitle: subTitle(RegisterController.designation.text),
        ),
        ListTile(
          title: profileTitle("Organization"),
          subtitle: subTitle(RegisterController.orgnization.text),
        ),
        ListTile(
          title: profileTitle("Personal Anua Income"),
          subtitle: subTitle(RegisterController.anualIncome),
        ),
        RegisterController.turnover.text != ""
            ? ListTile(
                title: profileTitle("Business Turnover"),
                subtitle: subTitle(RegisterController.turnover.text),
              )
            : const SizedBox.shrink(),
        ListTile(
          title: profileTitle("Indusry"),
          subtitle: subTitle(RegisterController.industry.text),
        ),
        RegisterController.website.text != ""
            ? ListTile(
                title: profileTitle("Business Website"),
                subtitle: subTitle(RegisterController.website.text),
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
          subtitle: subTitle(RegisterController.qualification),
        ),
        ListTile(
          title: profileTitle("School Name"),
          subtitle: subTitle(RegisterController.schoolName.text),
        ),
        RegisterController.ugCollegeName.text != ""
            ? ListTile(
                title: profileTitle("UG College Name"),
                subtitle: subTitle(RegisterController.ugCollegeName.text),
              )
            : const SizedBox.shrink(),
        RegisterController.pgCollegeName.text != ""
            ? ListTile(
                title: profileTitle("PG College Name"),
                subtitle: subTitle(RegisterController.pgCollegeName.text),
              )
            : const SizedBox.shrink(),
        RegisterController.phdCollegeName.text != ""
            ? ListTile(
                title: profileTitle("PHD College Name"),
                subtitle: subTitle(RegisterController.phdCollegeName.text),
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
          subtitle: subTitle(RegisterController.fathername.text),
        ),
        ListTile(
          title: profileTitle("Mother's Name"),
          subtitle: subTitle(RegisterController.mothername.text),
        ),
        ListTile(
          title: profileTitle("Father Occupation"),
          subtitle: subTitle(RegisterController.fatherOccupation),
        ),
        ListTile(
          title: profileTitle("Mother Occupation"),
          subtitle: subTitle(RegisterController.motherOccupation),
        ),
        ListTile(
          title: profileTitle("Number of Siblings"),
          subtitle: subTitle(RegisterController.noOfSibling),
        ),
        ListTile(
          title: profileTitle("Family Annual Income"),
          subtitle: subTitle(RegisterController.familyAnualIncome),
        ),
        ListTile(
          title: profileTitle("Nature of Occupation"),
          subtitle: subTitle(RegisterController.familyBackground),
        ),
        ListTile(
          title: profileTitle("Family Description"),
          subtitle: subTitle(RegisterController.familyDescription.text),
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
          subtitle: subTitle(RegisterController.eatingPref),
        ),
        ListTile(
          title: profileTitle("Do you Drink?"),
          subtitle: subTitle(RegisterController.drink),
        ),
        ListTile(
          title: profileTitle("Do you Smoker?"),
          subtitle: subTitle(RegisterController.smoker),
        ),
        ListTile(
          title: profileTitle("How spiritual are you?"),
          subtitle: subTitle(RegisterController.spritual),
        ),
        ListTile(
          title: profileTitle("How religious are You?"),
          subtitle: subTitle(RegisterController.religious),
        ),
        ListTile(
          title: profileTitle("How often do you eat out?"),
          subtitle: subTitle(RegisterController.eatOut),
        ),
        ListTile(
          title: profileTitle("How often do you work out?"),
          subtitle: subTitle(RegisterController.workout),
        ),
        ListTile(
          title: profileTitle("What type of holidays you prefer"),
          subtitle: subTitle(RegisterController.holidays.join(",\t")),
        ),
        ListTile(
          title: profileTitle("How often do you travel? (For leisure)"),
          subtitle: subTitle(RegisterController.travle),
        ),
        // ListTile(
        //   title: profileTitle("Your preferred social events"),
        //   subtitle: subTitle(RegisterController.socialise),
        // ),
        ListTile(
          title: profileTitle("Interests"),
          subtitle: subTitle(RegisterController.interest.join(",\t")),
        ),
      ],
    );
  }
}
