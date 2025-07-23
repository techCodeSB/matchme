import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../screen/personal_fst_details.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:provider/provider.dart';
import '../controller/register_controller.dart';
import '../widgets/error_text.dart';
import '../constant.dart';
import '../widgets/dropdown.dart';
import '../widgets/details_hero.dart';
import '../widgets/details_textfield.dart';

class PersonalSecDetails extends StatefulWidget {
  const PersonalSecDetails({super.key});

  @override
  State<PersonalSecDetails> createState() => _PersonalSecDetailsState();
}

class _PersonalSecDetailsState extends State<PersonalSecDetails> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
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
                          "Personal Details",
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
                          percent: 0.07, // 7% progress
                          center: Text(
                            "7%",
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
                          animationDuration: 700,
                        ),
                      ],
                    ),
                    const SizedBox(height: 20.0),
                    DetailsTextfield(
                      onTap: () {
                        Provider.of<RegisterController>(context, listen: false)
                            .setErrorMsg({"country": false});
                      },
                      controller: RegisterController.country,
                      hintText: "Enter Country (current residence)",
                      icon: Icons.person_outline,
                    ),
                    ErrorText(
                      text: "Residence can't be blank",
                      visible: Provider.of<RegisterController>(
                        context,
                        listen: true,
                      ).errMsg['country']!,
                    ),
                    const SizedBox(height: 20.0),
                    DetailsTextfield(
                      onTap: () {
                        Provider.of<RegisterController>(context, listen: false)
                            .setErrorMsg({"city": false});
                      },
                      controller: RegisterController.city,
                      hintText: "Your City",
                      icon: Icons.person_pin_circle_outlined,
                    ),
                    ErrorText(
                      text: "City can't be blank",
                      visible: Provider.of<RegisterController>(
                        context,
                        listen: true,
                      ).errMsg['city']!,
                    ),
                    const SizedBox(height: 20.0),
                    DetailsTextfield(
                      onTap: () {
                        Provider.of<RegisterController>(context, listen: false)
                            .setErrorMsg({"locality": false});
                      },
                      controller: RegisterController.locality,
                      hintText: "Your Locality",
                      icon: CupertinoIcons.building_2_fill,
                    ),
                    ErrorText(
                      text: "Locality can't be blank",
                      visible: Provider.of<RegisterController>(
                        context,
                        listen: true,
                      ).errMsg['locality']!,
                    ),
                    const SizedBox(height: 20.0),
                    Dropdown(
                      hint: "Your Nationality",
                      onChanged: (v) {
                        RegisterController.nationality = v!;
                        Provider.of<RegisterController>(context, listen: false)
                            .setErrorMsg({"nationality": false});
                      },
                      items: const [
                        "INDIAN",
                        "NRI",
                      ],
                      icon: Icons.flag_outlined,
                      defaultValue:
                          RegisterController.nationality.toUpperCase(),
                    ),
                    ErrorText(
                      text: "Nationality can't be blank",
                      visible: Provider.of<RegisterController>(
                        context,
                        listen: true,
                      ).errMsg['nationality']!,
                    ),
                    const SizedBox(height: 20.0),
                    Dropdown(
                      hint: "Your Religious",
                      onChanged: (v) {
                        RegisterController.religious = v!;
                        Provider.of<RegisterController>(context, listen: false)
                            .setErrorMsg({"religious": false});
                      },
                      items: const ["HINDU", "MUSLIM", "CHRISTIAN", "SIKH"],
                      icon: Icons.temple_hindu_outlined,
                      defaultValue: RegisterController.religious.toUpperCase(),
                    ),
                    ErrorText(
                      text: "Religious can't be blank",
                      visible: Provider.of<RegisterController>(
                        context,
                        listen: true,
                      ).errMsg['religious']!,
                    ),
                    const SizedBox(height: 20.0),
                    DetailsTextfield(
                      controller: RegisterController.community,
                      hintText: "Your Community Name ( Optional )",
                      icon: Icons.groups_sharp,
                    ),
                    const SizedBox(height: 20.0),
                    DetailsTextfield(
                      controller: RegisterController.medical,
                      hintText: "Medical History",
                      icon: Icons.medical_services_outlined,
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
              // *********************** BUTTONS ***********************
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: size.width * 0.05,
                  vertical: size.height * 0.02,
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const PersonalFstDetails(),
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
                                fontSize: 16.0,
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
                          ).personalSecSubmit(context);
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
                                fontSize: 16.0,
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
