import 'package:flutter/material.dart';
import 'package:match_me/screen/family_details.dart';
import 'package:percent_indicator/percent_indicator.dart';
import '../constant.dart';
import '../widgets/details_textfield.dart';
import '../widgets/dropdown.dart';
import '../widgets/details_hero.dart';
import './work_details.dart';

class QualificationDetails extends StatefulWidget {
  const QualificationDetails({super.key});

  @override
  State<QualificationDetails> createState() => _QualificationDetailsState();
}

class _QualificationDetailsState extends State<QualificationDetails> {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: double.infinity,
          height: double.infinity,
          color: Colors.white,
          child: ListView(
            children: [
              DetailsHero(size: size),
              // *********************** TOP BAR CLOSE ***********************

              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: size.width * 0.05,
                  vertical: size.height * 0.01,
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Qualification Details",
                          style: TextStyle(
                            color: const Color(0XFF033A44),
                            fontSize: size.width * 0.06,
                            fontWeight: FontWeight.bold,
                            fontFamily: Constant.haddingFont,
                          ),
                        ),
                        CircularPercentIndicator(
                          radius: 40.0, //size
                          lineWidth: 13.0,
                          percent: 0.4,
                          center: Text(
                            "40%",
                            style: TextStyle(
                              color: const Color(0xFF033A44),
                              fontFamily: Constant.haddingFont,
                              fontWeight: FontWeight.bold,
                              fontSize: 18.0,
                            ),
                          ),
                          linearGradient: const LinearGradient(
                            colors: [Color(0xFF1690A7), Color(0xFF033A44)],
                            begin: Alignment.topRight,
                            end: Alignment.bottomLeft,
                          ),
                          backgroundColor: const Color(0xFFD9D9D9),
                          animation: true,
                          animateFromLastPercent: true,
                        ),
                      ],
                    ),
                    const SizedBox(height: 20.0),
                    Dropdown(
                      hint: "Your Highest Qualification",
                      onChanged: (v) {},
                      items: const [
                        "School",
                        "Graduation",
                        "Post-Grad",
                        "Pd.D"
                      ],
                      icon: Icons.school_outlined,
                    ),

                    const SizedBox(height: 20.0),
                    DetailsTextfield(
                      controller: TextEditingController(),
                      hintText: "Your School",
                      icon: Icons.school_outlined,
                    ),

                    const SizedBox(height: 20.0),
                    DetailsTextfield(
                      controller: TextEditingController(),
                      hintText: "our University",
                      icon: Icons.school_outlined,
                    ),

                    const SizedBox(height: 20.0),
                    DetailsTextfield(
                      controller: TextEditingController(),
                      hintText: "University Address",
                      icon: Icons.location_on_outlined,
                    ),

                    const SizedBox(height: 20.0),
                    DetailsTextfield(
                      controller: TextEditingController(),
                      hintText: "University Subjects",
                      icon: Icons.school_outlined,
                    ),
                    SizedBox(height: size.height * 0.07),
                    // *********************** BUTTONS ***********************
                    Row(
                      children: [
                        Expanded(
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const FamilyDetails(),
                                ),
                              );
                            },
                            child: Container(
                              height: 50.0,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30.0),
                                border: Border.all(
                                  color: const Color(0xFF033A44),
                                  width: 2.0,
                                ),
                              ),
                              child: Center(
                                child: Text(
                                  "Back",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: Constant.subHadding,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 20.0),
                        Expanded(
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const WorkDetails(),
                                ),
                              );
                            },
                            child: Container(
                              height: 50.0,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30.0),
                                color: const Color(0xFF033A44),
                              ),
                              child: Center(
                                child: Text(
                                  "Submit",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: Constant.subHadding,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
