import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:provider/provider.dart';
import '../screen/lifestyle_4.dart';
import '../widgets/details_hero.dart';
import '../constant.dart';
import '../widgets/radio.dart' as my_radio;
import '../widgets/error_text.dart';
import '../controller/register_controller.dart';
import 'package:matchme/widgets/registration_bottom_buttons.dart';

class Lifestyle5 extends StatefulWidget {
  const Lifestyle5({super.key});

  @override
  State<Lifestyle5> createState() => _Lifestyle5State();
}

class _Lifestyle5State extends State<Lifestyle5> {
  final List<String> _selectedHolidays = [];

  void setHolidays(i) {
    setState(() {
      if (_selectedHolidays.contains(i)) {
        _selectedHolidays.remove(i);
      } else {
        _selectedHolidays.add(i);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(size.height * 0.3),
        child: DetailsHero(
          size: size,
        ),
      ),
      body: SafeArea(
        child: Container(
          width: double.infinity,
          height: double.infinity,
          color: Colors.white,
          child: ListView(
            children: [
              Padding(
                padding: EdgeInsets.only(
                  left: size.width * 0.05,
                  right: size.width * 0.05,
                  top: size.height * 0.01,
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
                      percent: 0.70,
                      center: Text(
                        "70%",
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
              const SizedBox(height: 20.0),
              // ::::::::::::::::::::::::::::::::::::::::::::::: FORM FIELDS ::::::::::::::::::::::::::::::::::::::::::::::::
              Padding(
                padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
                child: Column(
                  children: [
                    my_radio.Radio(
                      title: "Do you like socialise?",
                      items: const ["Yes", "Occasionally", "No"],
                      onChanged: (v) {
                        Provider.of<RegisterController>(context, listen: false)
                            .setErrorMsg({"socialise": false});
                        RegisterController.socialise = v!;
                      },
                      defaultValue: RegisterController.socialise,
                    ),
                    ErrorText(
                      text: "Select an option",
                      visible:
                          Provider.of<RegisterController>(context, listen: true)
                              .errMsg['socialise']!,
                    ),
                    const SizedBox(height: 15.0),
                    my_radio.Radio(
                      title: "Whom do you mostly go out with",
                      items: const ["With Family", "With Friends", "Solo"],
                      onChanged: (v) {
                        Provider.of<RegisterController>(context, listen: false)
                            .setErrorMsg({"goOut": false});
                        RegisterController.goOut = v!;
                      },
                      defaultValue: RegisterController.goOut,
                    ),
                    ErrorText(
                      text: "Select an option",
                      visible:
                          Provider.of<RegisterController>(context, listen: true)
                              .errMsg['goOut']!,
                    ),
                    const SizedBox(height: 15.0),
                    my_radio.Radio(
                      title: "How Spritual you are?",
                      items: const [
                        "Not all",
                        "Little",
                        "Moderate",
                        "Very Spritual"
                      ],
                      onChanged: (v) {
                        Provider.of<RegisterController>(context, listen: false)
                            .setErrorMsg({"spritual": false});
                        RegisterController.spritual = v!;
                      },
                      defaultValue: RegisterController.spritual,
                    ),
                    ErrorText(
                      text: "Select an option",
                      visible:
                          Provider.of<RegisterController>(context, listen: true)
                              .errMsg['spritual']!,
                    ),
                    const SizedBox(height: 15.0),
                    my_radio.Radio(
                      title: "How religious you are?",
                      items: const [
                        "Not all",
                        "Little",
                        "Moderate",
                        "Very Spritual"
                      ],
                      onChanged: (v) {
                        Provider.of<RegisterController>(context, listen: false)
                            .setErrorMsg({"howReligious": false});
                        RegisterController.howReligious = v!;
                      },
                      defaultValue: RegisterController.howReligious,
                    ),
                    ErrorText(
                      text: "Select an option",
                      visible:
                          Provider.of<RegisterController>(context, listen: true)
                              .errMsg['howReligious']!,
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
              // ::::::::::::::::::::::::::::::::::::::::: BUTTONS ::::::::::::::::::::::::::::::::::::::::::::::::

              const SizedBox(height: 100.0),
            ],
          ),
        ),
      ),
      bottomSheet: RegistrationBottomButtons(
        onNextTap: () {
          Provider.of<RegisterController>(
            context,
            listen: false,
          ).lifeStyle5Submit(context);
        },
        onBackTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const Lifestyle4(),
            ),
          );
        },
      ),
    );
  }
}
