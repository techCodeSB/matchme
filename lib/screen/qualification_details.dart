import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:provider/provider.dart';
import '../screen/family_details.dart';
import '../constant.dart';
import '../widgets/details_textfield.dart';
import '../widgets/dropdown.dart';
import '../widgets/details_hero.dart';
import '../controller/register_controller.dart';
import '../widgets/error_text.dart';
import 'package:icons_plus/icons_plus.dart';

class QualificationDetails extends StatefulWidget {
  const QualificationDetails({super.key});

  @override
  State<QualificationDetails> createState() => _QualificationDetailsState();
}

class _QualificationDetailsState extends State<QualificationDetails> {
  String _qualification = "school";

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
                          percent: 0.28,
                          center: Text(
                            "28%",
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
                      onChanged: (v) {
                        setState(() {
                          _qualification = v!.toLowerCase();
                        });

                        Provider.of<RegisterController>(context, listen: false)
                            .setErrorMsg({"qualification": false});

                        Provider.of<RegisterController>(context, listen: false)
                            .qualification = v!.toLowerCase();
                      },
                      items: const [
                        "School",
                        "Graduation",
                        "Post-Grad",
                        "Pd.D"
                      ],
                      icon: Icons.school_outlined,
                    ),
                    ErrorText(
                      text: "Select your qualification",
                      visible: Provider.of<RegisterController>(
                        context,
                        listen: true,
                      ).errMsg['qualification']!,
                    ),
                    const SizedBox(height: 20.0),
                    DetailsTextfield(
                      onTap: () {
                        Provider.of<RegisterController>(context, listen: false)
                            .setErrorMsg({"schoolName": false});
                      },
                      controller: RegisterController.schoolName,
                      hintText: "Your School",
                      icon: Icons.school_outlined,
                    ),
                    ErrorText(
                      text: "School name can't be blank",
                      visible: Provider.of<RegisterController>(
                        context,
                        listen: true,
                      ).errMsg['schoolName']!,
                    ),
                    Visibility(
                      visible: _qualification == "post-grad" ||
                              _qualification == "graduation" ||
                              _qualification == "pd.d"
                          ? true
                          : false,
                      child: Column(
                        children: [
                          const SizedBox(height: 20.0),
                          DetailsTextfield(
                            onTap: () {
                              Provider.of<RegisterController>(context,
                                      listen: false)
                                  .setErrorMsg({"ugCollegeName": false});
                            },
                            controller: RegisterController.ugCollegeName,
                            hintText: "UG College Name",
                            icon: Icons.school_outlined,
                          ),
                          ErrorText(
                            text: "UG College name can't be blank",
                            visible: Provider.of<RegisterController>(
                              context,
                              listen: true,
                            ).errMsg['ugCollegeName']!,
                          ),
                        ],
                      ),
                    ),
                    Visibility(
                      visible: _qualification == "post-grad" ||
                              _qualification == "pd.d"
                          ? true
                          : false,
                      child: Column(
                        children: [
                          const SizedBox(height: 20.0),
                          DetailsTextfield(
                            onTap: () {
                              Provider.of<RegisterController>(context,
                                      listen: false)
                                  .setErrorMsg({"pgCollegeName": false});
                            },
                            controller: RegisterController.pgCollegeName,
                            hintText: "PG College Name",
                            icon: Icons.school_outlined,
                          ),
                          ErrorText(
                            text: "PG College name can't be blank",
                            visible: Provider.of<RegisterController>(
                              context,
                              listen: true,
                            ).errMsg['pgCollegeName']!,
                          ),
                        ],
                      ),
                    ),
                    Visibility(
                      visible: _qualification == "pd.d" ? true : false,
                      child: Column(
                        children: [
                          const SizedBox(height: 20.0),
                          DetailsTextfield(
                            onTap: () {
                              Provider.of<RegisterController>(context,
                                      listen: false)
                                  .setErrorMsg({"phdCollegeName": false});
                            },
                            controller: RegisterController.phdCollegeName,
                            hintText: "Ph.D College Name",
                            icon: Icons.school_outlined,
                          ),
                          ErrorText(
                            text: "Ph.D College name can't be blank",
                            visible: Provider.of<RegisterController>(
                              context,
                              listen: true,
                            ).errMsg['phdCollegeName']!,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20.0),
                    DetailsTextfield(
                      onTap: () {
                        Provider.of<RegisterController>(context, listen: false)
                            .setErrorMsg({"highestDegree": false});
                      },
                      controller: RegisterController.highestDegree,
                      hintText: "Highest Degree",
                      icon: Clarity.certificate_solid,
                    ),
                    ErrorText(
                      text: "Highest degree can't be blank",
                      visible: Provider.of<RegisterController>(
                        context,
                        listen: true,
                      ).errMsg['highestDegree']!,
                    ),
                    const SizedBox(height: 20.0),
                    DetailsTextfield(
                      controller: TextEditingController(),
                      hintText: "Other Details",
                      icon: Icons.school_outlined,
                    ),
                  ],
                ),
              ),

              SizedBox(
                width: double.infinity,
                child: Image.asset(
                  "assets/images/Vector 1.png",
                  fit: BoxFit.cover,
                ),
              ),

              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: size.width * 0.05,
                  vertical: size.height * 0.02,
                ),
                child: // *********************** BUTTONS ***********************
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
                              width: 1.5,
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
                          Provider.of<RegisterController>(
                            context,
                            listen: false,
                          ).qualificationSubmit(context);
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
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
