import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import '../controller/register_controller.dart';
import 'package:provider/provider.dart';
import '../constant.dart';
import '../widgets/dropdown.dart';
import '../widgets/details_hero.dart';
import '../widgets/details_textfield.dart';
import '../widgets/radio.dart' as MyRadio;
import '../widgets/error_text.dart';

class PersonalTrdDetails extends StatefulWidget {
  const PersonalTrdDetails({super.key});

  @override
  State<PersonalTrdDetails> createState() => _PersonalTrdDetailsState();
}

class _PersonalTrdDetailsState extends State<PersonalTrdDetails> {
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
                          "Personal Details",
                          style: TextStyle(
                            color: const Color(0XFF033A44),
                            fontSize: 30.0,
                            fontWeight: FontWeight.bold,
                            fontFamily: Constant.haddingFont,
                          ),
                        ),
                        CircularPercentIndicator(
                          radius: 40.0, //size
                          lineWidth: 13.0,
                          percent: 0.0,
                          center: Text(
                            "0%",
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
                    DetailsTextfield(
                      controller: RegisterController.whatsappNumber,
                      hintText: "Add WhatsApp Number",
                      icon: Icons.phone,
                      onTap: () {
                        Provider.of<RegisterController>(context, listen: false)
                            .setErrorMsg({'whatsappNumber': false});
                      },
                    ),
                    ErrorText(
                      text: "WhatsApp number can't be blank",
                      visible:
                          Provider.of<RegisterController>(context, listen: true)
                              .errMsg['whatsappNumber']!,
                    ),

                    const SizedBox(height: 20.0),
                    DetailsTextfield(
                      controller: RegisterController.height,
                      hintText: "Height",
                      icon: Icons.height_rounded,
                      onTap: () {
                        Provider.of<RegisterController>(context, listen: false)
                            .setErrorMsg({'height': false});
                      },
                    ),
                    ErrorText(
                      text: "Height can't be blank",
                      visible:
                          Provider.of<RegisterController>(context, listen: true)
                              .errMsg['height']!,
                    ),

                    const SizedBox(height: 20.0),
                    DetailsTextfield(
                      controller: RegisterController.weight,
                      hintText: "Weight",
                      icon: Icons.person,
                      onTap: () {
                        Provider.of<RegisterController>(context, listen: false)
                            .setErrorMsg({'weight': false});
                      },
                    ),
                    ErrorText(
                      text: "Weight can't be blank",
                      visible:
                          Provider.of<RegisterController>(context, listen: true)
                              .errMsg['weight']!,
                    ),

                    const SizedBox(height: 20.0),
                    Dropdown(
                      hint: "Marital Status",
                      onChanged: (v) {
                        Provider.of<RegisterController>(context, listen: false)
                            .maritalStatus = v!;
                        Provider.of<RegisterController>(context, listen: false)
                            .setErrorMsg({'maritalStatus': false});
                      },
                      items: const [
                        "Never Married",
                        "Divorced",
                        "Widowed",
                      ],
                      icon: Icons.person_outline,
                    ),
                    ErrorText(
                      text: "Marital Status can't be blank",
                      visible:
                          Provider.of<RegisterController>(context, listen: true)
                              .errMsg['maritalStatus']!,
                    ),

                    const SizedBox(height: 15.0),
                    MyRadio.Radio(
                      title: "Tell us about your eating preferences?",
                      items: const ["Veg", "Non-Veg", "Vegan"],
                      onChanged: (v) {
                        Provider.of<RegisterController>(context, listen: false)
                            .eatingPref = v!;
                        Provider.of<RegisterController>(context, listen: false)
                            .setErrorMsg({"eatingPref": false});
                      },
                    ),
                    ErrorText(
                      text: "Eating Preferance can't be blank",
                      visible:
                          Provider.of<RegisterController>(context, listen: true)
                              .errMsg['eatingPref']!,
                    ),

                    SizedBox(height: size.height * 0.05),
                    // *********************** BUTTONS ***********************
                    Row(
                      children: [
                        Expanded(
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
                        const SizedBox(width: 20.0),
                        Expanded(
                          child: InkWell(
                            onTap: () {
                              Provider.of<RegisterController>(
                                context,
                                listen: false,
                              ).personalTrdSubmit(context);
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
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
