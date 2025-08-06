import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:provider/provider.dart';
import '../widgets/details_hero.dart';
import '../constant.dart';
import '../widgets/radio.dart' as my_radio;
import '../widgets/interest_button.dart';
import '../widgets/error_text.dart';
import '../controller/register_controller.dart';
import '../screen/lifestyle_1.dart';
import 'package:matchme/widgets/registration_bottom_buttons.dart';

class Lifestyle2 extends StatefulWidget {
  const Lifestyle2({super.key});

  @override
  State<Lifestyle2> createState() => _Lifestyle2State();
}

class _Lifestyle2State extends State<Lifestyle2> {
  final List<String> _selectedActivities = [];

  void setActivities(a) {
    setState(() {
      if (_selectedActivities.contains(a)) {
        _selectedActivities.remove(a);
      } else {
        _selectedActivities.add(a);
      }
    });

    Provider.of<RegisterController>(context, listen: false)
        .setErrorMsg({"weekendActivites": false});
  }

  @override
  void initState() {
    super.initState();
    // Initialize the selected activities based on the existing data
    _selectedActivities.addAll(RegisterController.weekendActivites);
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
                      percent: 0.49,
                      center: Text(
                        "49%",
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
              // :::::::::::::::::::::::::::::::::::::::::::::::: FORM FIELDS ::::::::::::::::::::::::::::::::::::::::::::
              Padding(
                padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    my_radio.Radio(
                      title: "How often do you workout",
                      items: const [
                        "Regularly",
                        "Sometimes",
                        "Few days a Week",
                        "Never"
                      ],
                      onChanged: (v) {
                        Provider.of<RegisterController>(context, listen: false)
                            .setErrorMsg({"workout": false});
                        RegisterController.workout = v!;
                      },
                      defaultValue: RegisterController.workout,
                    ),
                    ErrorText(
                      text: "Select an option",
                      visible:
                          Provider.of<RegisterController>(context, listen: true)
                              .errMsg['workout']!,
                    ),
                    const SizedBox(height: 30.0),
                    Text(
                      "Your favourite weekend activites",
                      style: TextStyle(
                        fontSize: 18.0,
                        fontFamily: Constant.subHadding,
                      ),
                    ),
                    const SizedBox(height: 20.0),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InterestButton(
                    text: "Outdoor Activity",
                    onChanged: (v) {
                      setActivities("Outdoor Activity");
                    },
                    isSelected:
                        _selectedActivities.contains("Outdoor Activity"),
                  ),
                  const SizedBox(width: 15.0),
                  InterestButton(
                    text: "Partying",
                    onChanged: (v) {
                      setActivities("Partying");
                    },
                    isSelected: _selectedActivities.contains("Partying"),
                  ),
                ],
              ),
              const SizedBox(height: 15.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InterestButton(
                    text: "Indoor activities(eg: playing music, reading, etc)",
                    onChanged: (v) {
                      setActivities(
                          "Indoor activities(eg: playing music, reading, etc)");
                    },
                    isSelected: _selectedActivities.contains(
                        "Indoor activities(eg: playing music, reading, etc)"),
                  ),
                ],
              ),
              const SizedBox(height: 15.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InterestButton(
                    text: "Netflix and chill",
                    onChanged: (v) {
                      setActivities("Netflix and chill");
                    },
                    isSelected:
                        _selectedActivities.contains("Netflix and chill"),
                  ),
                  const SizedBox(width: 15.0),
                  InterestButton(
                    text: "Family Time",
                    onChanged: (v) {
                      setActivities("Family Time");
                    },
                    isSelected: _selectedActivities.contains("Family Time"),
                  ),
                ],
              ),
              const SizedBox(height: 15.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InterestButton(
                    text: "Eat out with family/friends",
                    onChanged: (v) {
                      setActivities("Eat out with family/friends");
                    },
                    isSelected: _selectedActivities
                        .contains("Eat out with family/friends"),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
                child: ErrorText(
                  text: "Select an option",
                  visible:
                      Provider.of<RegisterController>(context, listen: true)
                          .errMsg['weekendActivites']!,
                ),
              ),
              SizedBox(
                width: double.infinity,
                child: Image.asset(
                  "assets/images/Vector 1.png",
                  fit: BoxFit.cover,
                ),
              ),
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
          ).lifeStyle2Submit(context, _selectedActivities);
        },
        onBackTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const Lifestyle1()),
          );
        },
      ),
    );
  }
}
