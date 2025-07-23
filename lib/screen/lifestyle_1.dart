import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:percent_indicator/percent_indicator.dart';
import '../widgets/details_hero.dart';
import '../constant.dart';
import '../widgets/radio.dart' as my_radio;
import '../widgets/error_text.dart';
import '../controller/register_controller.dart';

class Lifestyle1 extends StatefulWidget {
  const Lifestyle1({super.key});

  @override
  State<Lifestyle1> createState() => _Lifestyle1State();
}

class _Lifestyle1State extends State<Lifestyle1> {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Container(
          height: double.infinity,
          width: double.infinity,
          color: Colors.white,
          child: ListView(
            children: [
              DetailsHero(size: size),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: size.width * 0.05,
                  vertical: size.height * 0.01,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Life Style",
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
                      percent: 0.42,
                      center: Text(
                        "42%",
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
              ),
              // :::::::::::::::::::::::::::::::::::::::::::::: FORM FIELDS ::::::::::::::::::::::::::::::::::::::::::::
              Padding(
                padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
                child: Column(
                  children: [
                    my_radio.Radio(
                      title: "How often do you drink",
                      items: const [
                        "Never",
                        "Occasionally",
                        "Weekends",
                        "Regularly"
                      ],
                      onChanged: (v) {
                        Provider.of<RegisterController>(context, listen: false)
                            .setErrorMsg({"drink": false});
                        RegisterController.drink = v!;
                      },
                      defaultValue: RegisterController.drink,
                    ),
                    ErrorText(
                      text: "Select an option",
                      visible:
                          Provider.of<RegisterController>(context, listen: true)
                              .errMsg['drink']!,
                    ),
                    const SizedBox(height: 30.0),
                    my_radio.Radio(
                      title: "Are you smoker?",
                      items: const ["Yes", "No", "Occasionally"],
                      onChanged: (v) {
                        Provider.of<RegisterController>(context, listen: false)
                            .setErrorMsg({"smoker": false});
                        RegisterController.smoker = v!;
                      },
                      defaultValue: RegisterController.smoker,
                    ),
                    ErrorText(
                      text: "Select an option",
                      visible:
                          Provider.of<RegisterController>(context, listen: true)
                              .errMsg['smoker']!,
                    ),
                  ],
                ),
              ),
              const Spacer(),
              // ::::::::::::::::::::::::::::::::::::::::::: BUTTONS :::::::::::::::::::::::::::::::::::::::::
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
                child: Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: () {},
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
                          ).lifeStyle1Submit(context);
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
