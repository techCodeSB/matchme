import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:matchme/constant.dart';
import 'package:matchme/controller/register_controller.dart';
import 'package:matchme/widgets/profile_details_tile.dart';

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
      ),
    );
  }

// :::::::::::::::::::::::::::::::::: ALL DETAILS SCREENS ::::::::::::::::::::::::::::
  Widget personalDetail() {
    return ListView(
      children: [
        buildBorderedTile("Name", RegisterController.fullname.text),
        buildBorderedTile("Gender", RegisterController.gender),
        buildBorderedTile("Height",
            "${RegisterController.heightFeet}'${RegisterController.heightInch}"),
        buildBorderedTile("Date of Birth", formattedDate),
        buildBorderedTile(
            "Place of Birth", RegisterController.placeOfBirth.text),
        buildBorderedTile("Marital Status", RegisterController.maritalStatus),
        buildBorderedTile("Address",
            "${RegisterController.country.text}, ${RegisterController.city.text}"),
        buildBorderedTile("Hometown", RegisterController.hometown.text),
        buildBorderedTile("Nationality", RegisterController.nationality),
        if (RegisterController.showWeightOnProfile != true)
          buildBorderedTile("Weight",
              "${RegisterController.weight.text} ${RegisterController.weightUnit}"),
        buildBorderedTile("Religion", RegisterController.religious),
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
        buildBorderedTile("Designation", RegisterController.designation.text),
        buildBorderedTile("Organization", RegisterController.orgnization.text),
        buildBorderedTile(
            "Personal Annual Income", RegisterController.anualIncome),
        if (RegisterController.turnover.text.isNotEmpty)
          buildBorderedTile(
              "Business Turnover", RegisterController.turnover.text),
        buildBorderedTile("Industry", RegisterController.industry.text),
        if (RegisterController.website.text.isNotEmpty)
          buildBorderedTile(
              "Business Website", RegisterController.website.text),
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
        buildBorderedTile("Highest Degree", RegisterController.qualification),
        buildBorderedTile("School Name", RegisterController.schoolName.text),
        if (RegisterController.ugCollegeName.text.isNotEmpty)
          buildBorderedTile(
              "UG College Name", RegisterController.ugCollegeName.text),
        if (RegisterController.pgCollegeName.text.isNotEmpty)
          buildBorderedTile(
              "PG College Name", RegisterController.pgCollegeName.text),
        if (RegisterController.phdCollegeName.text.isNotEmpty)
          buildBorderedTile(
              "PHD College Name", RegisterController.phdCollegeName.text),
      ],
    );
  }

  Widget familyDetails() {
    return ListView(
      padding: const EdgeInsets.all(10.0),
      children: [
        buildBorderedTile("Father's Name", RegisterController.fathername.text),
        buildBorderedTile("Mother's Name", RegisterController.mothername.text),
        buildBorderedTile(
            "Father Occupation", RegisterController.fatherOccupation),
        buildBorderedTile(
            "Mother Occupation", RegisterController.motherOccupation),
        buildBorderedTile("Number of Siblings", RegisterController.noOfSibling),
        buildBorderedTile(
            "Family Annual Income", RegisterController.familyAnualIncome),
        buildBorderedTile(
            "Nature of Occupation", RegisterController.familyBackground),
        buildBorderedTile(
            "Family Description", RegisterController.familyDescription.text),
      ],
    );
  }

  Widget lifeStyleDetails() {
    return ListView(
      padding: const EdgeInsets.all(10.0),
      children: [
        buildBorderedTile("Eating Preference", RegisterController.eatingPref),
        buildBorderedTile("Do you Drink?", RegisterController.drink),
        buildBorderedTile("Do you Smoke?", RegisterController.smoker),
        buildBorderedTile(
            "How spiritual are you?", RegisterController.spritual),
        buildBorderedTile(
            "How religious are you?", RegisterController.religious),
        buildBorderedTile(
            "How often do you eat out?", RegisterController.eatOut),
        buildBorderedTile(
            "How often do you work out?", RegisterController.workout),
        buildBorderedTile("What type of holidays you prefer",
            RegisterController.holidays.join(",\t")),
        buildBorderedTile("How often do you travel? (For leisure)",
            RegisterController.travle),
        buildBorderedTile("Interests", RegisterController.interest.join(",\t")),
      ],
    );
  }
}
