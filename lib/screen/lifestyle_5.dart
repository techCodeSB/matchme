import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:provider/provider.dart';
import '../screen/lifestyle_4.dart';
import '../widgets/details_hero.dart';
import '../constant.dart';
import '../widgets/radio.dart' as my_radio;
import '../widgets/error_text.dart';
import '../controller/register_controller.dart';

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
                      Provider.of<RegisterController>(context, listen: false)
                          .socialise = v!;
                    },
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
                      Provider.of<RegisterController>(context, listen: false)
                          .goOut = v!;
                    },
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
                      Provider.of<RegisterController>(context, listen: false)
                          .spritual = v!;
                    },
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
                      Provider.of<RegisterController>(context, listen: false)
                          .howReligious = v!;
                    },
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
                              builder: (context) => const Lifestyle4()),
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
                        Provider.of<RegisterController>(context, listen: false)
                            .lifeStyle5Submit(context);
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
