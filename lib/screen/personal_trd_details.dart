import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import '../controller/register_controller.dart';
import 'package:provider/provider.dart';
import '../constant.dart';
import '../widgets/dropdown.dart';
import '../widgets/details_hero.dart';
import '../widgets/details_textfield.dart';
import '../widgets/radio.dart' as my_radio;
import '../widgets/error_text.dart';
import 'package:icons_plus/icons_plus.dart';

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
                          percent: 0.14,
                          center: Text(
                            "14%",
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
                      type: TextInputType.phone,
                      controller: RegisterController.whatsappNumber,
                      hintText: "Add WhatsApp Number",
                      icon: FontAwesome.whatsapp_brand,
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
                    Row(
                      children: [
                        Expanded(
                          child: DetailsTextfield(
                            type: TextInputType.number,
                            controller: RegisterController.heightFeet,
                            hintText: "Height (feet)",
                            icon: Icons.height_rounded,
                            onTap: () {
                              Provider.of<RegisterController>(context,
                                      listen: false)
                                  .setErrorMsg({'height': false});
                            },
                          ),
                        ),
                        const SizedBox(width: 20.0),
                        Expanded(
                          child: DetailsTextfield(
                            type: TextInputType.number,
                            controller: RegisterController.heightInch,
                            hintText: "Height (inches)",
                            icon: Icons.height_rounded,
                            onTap: () {
                              Provider.of<RegisterController>(context,
                                      listen: false)
                                  .setErrorMsg({'height': false});
                            },
                          ),
                        ),
                      ],
                    ),
                    ErrorText(
                      text: "Height can't be blank",
                      visible:
                          Provider.of<RegisterController>(context, listen: true)
                              .errMsg['height']!,
                    ),
                    const SizedBox(height: 20.0),
                    DetailsTextfield(
                      type: TextInputType.number,
                      controller: RegisterController.weight,
                      hintText: "Weight",
                      icon: FontAwesome.weight_scale_solid,
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
                        RegisterController.maritalStatus = v!;
                        Provider.of<RegisterController>(context, listen: false)
                            .setErrorMsg({'maritalStatus': false});
                      },
                      items: const [
                        "NEVER MARRIED",
                        "DIVORCED",
                        "WIDOWED",
                      ],
                      icon: Icons.person_outline,
                      defaultValue:
                          RegisterController.maritalStatus.toUpperCase(),
                    ),
                    ErrorText(
                      text: "Marital Status can't be blank",
                      visible:
                          Provider.of<RegisterController>(context, listen: true)
                              .errMsg['maritalStatus']!,
                    ),
                    const SizedBox(height: 15.0),
                    my_radio.Radio(
                      title: "Tell us about your eating preferences?",
                      items: const ["VEG", "NON-VEG", "VEGAN"],
                      onChanged: (v) {
                        RegisterController.eatingPref = v!;
                        Provider.of<RegisterController>(context, listen: false)
                            .setErrorMsg({"eatingPref": false});
                      },
                      defaultValue: RegisterController.eatingPref.toUpperCase(),
                    ),
                    ErrorText(
                      text: "Eating Preferance can't be blank",
                      visible:
                          Provider.of<RegisterController>(context, listen: true)
                              .errMsg['eatingPref']!,
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
                // ::::::::::::::::::::::::::::::::::::::::::: BUTTONS :::::::::::::::::::::::::::::::::::::::::::
                child: Row(
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
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
