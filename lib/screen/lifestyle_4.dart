import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:provider/provider.dart';
import '../widgets/details_hero.dart';
import '../constant.dart';
import '../widgets/interest_button.dart';
import '../widgets/radio.dart' as my_radio;
import '../widgets/error_text.dart';
import '../controller/register_controller.dart';

class Lifestyle4 extends StatefulWidget {
  const Lifestyle4({super.key});

  @override
  State<Lifestyle4> createState() => _Lifestyle4State();
}

class _Lifestyle4State extends State<Lifestyle4> {
  final List<String> _selectedHolidays = [];

  void setHolidays(i) {
    setState(() {
      if (_selectedHolidays.contains(i)) {
        _selectedHolidays.remove(i);
      } else {
        _selectedHolidays.add(i);
      }
    });

    Provider.of<RegisterController>(context, listen: false)
        .setErrorMsg({"holidays": false});
  }


  @override
  void initState() {
    super.initState();
    // Initialize the selected holidays from the provider
    _selectedHolidays.addAll(RegisterController.holidays);
  }

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
                    percent: 0.63,
                    center: Text(
                      "63%",
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
            // ::::::::::::::::::::::::::::::::::::::::::::::: FORM FIELDS ::::::::::::::::::::::::::::::::::::::::::::::::
            Padding(
              padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
              child: ErrorText(
                text: "Select an option",
                visible: Provider.of<RegisterController>(context, listen: true)
                    .errMsg['holidays']!,
              ),
            ),
            const SizedBox(height: 20.0),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
              child: Column(
                children: [
                  my_radio.Radio(
                    title: "How often do you eat out?",
                    items: const ["Occasionally", "Weekends", "Regularly"],
                    onChanged: (v) {
                      RegisterController.eatOut = v!;
                      Provider.of<RegisterController>(context, listen: false)
                          .setErrorMsg({"eatOut": false});
                    },
                    defaultValue: RegisterController.eatOut,
                  ),
                  ErrorText(
                    text: "Select an option",
                    visible:
                        Provider.of<RegisterController>(context, listen: true)
                            .errMsg['eatOut']!,
                  ),
                  const SizedBox(height: 15.0),
                  my_radio.Radio(
                    title: "How often do you travle? (For leisure)",
                    items: const [
                      "Often",
                      "Twice a year",
                      "Once a year",
                      "Never"
                    ],
                    onChanged: (v) {
                      RegisterController.travle = v!;
                      Provider.of<RegisterController>(context, listen: false)
                          .setErrorMsg({"travle": false});
                    },
                    defaultValue: RegisterController.travle,
                  ),
                  ErrorText(
                    text: "Select an option",
                    visible:
                        Provider.of<RegisterController>(context, listen: true)
                            .errMsg['travle']!,
                  ),
                  const SizedBox(height: 20.0),
                  Text(
                    "What kind of holidays do your prefer",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 15.0,
                      fontFamily: Constant.subHadding,
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InterestButton(
                        text: "Luxury",
                        onChanged: (v) {
                          setHolidays("Luxury");
                        },
                        isSelected: _selectedHolidays.contains("Luxury"),
                      ),
                      const SizedBox(width: 15.0),
                      InterestButton(
                        text: "Budget",
                        onChanged: (v) {
                          setHolidays("Budget");
                        },
                        isSelected: _selectedHolidays.contains("Budget"),
                      ),
                      const SizedBox(width: 15.0),
                      InterestButton(
                        text: "Well planned",
                        onChanged: (v) {
                          setHolidays("Well planned");
                        },
                        isSelected: _selectedHolidays.contains("Well planned"),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(width: 15.0),
                      InterestButton(
                        text: "Unplanned trips",
                        onChanged: (v) {
                          setHolidays("Unplanned trips");
                        },
                        isSelected:
                            _selectedHolidays.contains("Unplanned trips"),
                      )
                    ],
                  ),
                ],
              ),
            ),
            // ::::::::::::::::::::::::::::::::::::::::::::: BUTTONS ::::::::::::::::::::::::::::::::::::::::::::::::
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
                        // print(_selectedInterest);
                        Provider.of<RegisterController>(
                          context,
                          listen: false,
                        ).lifeStyle4Submit(context, _selectedHolidays);
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
            ),
            const SizedBox(height: 10.0),
          ],
        ),
      ),
    ));
  }
}
