import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/percent_indicator.dart';
import '../constant.dart';
import '../widgets/age_selector.dart';

class Preference extends StatefulWidget {
  const Preference({super.key});

  @override
  State<Preference> createState() => _PreferenceState();
}

class _PreferenceState extends State<Preference> {
  List<Map<String, dynamic>> chatQuestionAnswer = [
    {
      "content":
          "Let’s get to know about your preferences for a suitable match !",
      "type": "system",
    },
    {
      "content": "What is the age you preferred ?",
      "type": "system",
    },
    {
      "content": const AgeSelector(),
      "type": "user",
    }
  ];

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        body: SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: ListView(
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(
                  horizontal: 20.0,
                  vertical: 10.0,
                ),
                decoration: const BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: Color(0xFFECECEC),
                    ),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Constant.backIcon,
                    ),
                    const CircleAvatar(
                      backgroundImage:
                          AssetImage("assets/images/match_me_admin.png"),
                    ),
                    const SizedBox(width: 10.0),
                    Text(
                      "MISHI",
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF033A44),
                        fontFamily: GoogleFonts.nunito().fontFamily,
                      ),
                    ),
                    const Spacer(),
                    CircularPercentIndicator(
                      radius: 30.0, //size
                      lineWidth: 10.0,
                      percent: 0.7,
                      center: Text(
                        "70%",
                        style: TextStyle(
                          color: const Color(0xFF033A44),
                          fontFamily: Constant.haddingFont,
                          fontWeight: FontWeight.bold,
                          fontSize: 16.0,
                        ),
                      ),
                      linearGradient: const LinearGradient(
                        colors: [Color(0xFF1690A7), Color(0xFF033A44)],
                        begin: Alignment.topRight,
                        end: Alignment.bottomLeft,
                      ),
                      backgroundColor: const Color(0xFFD9D9D9),
                    ),
                  ],
                ),
              ),
              // ::::::::::::::::::::::: APPBAR CLOSE HERE :::::::::::::::::::::::::
              const SizedBox(height: 20.0),
              ...chatQuestionAnswer.map(
                (chat) {
                  if (chat['type'] == "system") {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Container(
                            width: 33.0,
                            height: 33.0,
                            margin: EdgeInsets.only(
                              bottom: size.height * 0.05 / 2,
                            ),
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white,
                              boxShadow: <BoxShadow>[
                                BoxShadow(
                                  blurRadius: 1.0,
                                  color: Color.fromARGB(255, 205, 203, 203),
                                  spreadRadius: 2.0,
                                ),
                              ],
                              image: DecorationImage(
                                image: AssetImage(
                                  "assets/images/match_me_admin.png",
                                ),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          const SizedBox(width: 10.0),
                          Expanded(
                            child: Container(
                              margin: const EdgeInsets.only(bottom: 20.0),
                              padding: const EdgeInsets.all(20.0),
                              decoration: const BoxDecoration(
                                color: Color(0xFFD8F9FF),
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(30.0),
                                  topRight: Radius.circular(30.0),
                                  bottomRight: Radius.circular(30.0),
                                ),
                              ),
                              child: Text(
                                chat['content'] ?? '',
                                style: TextStyle(
                                    fontSize: 16.0,
                                    color: const Color(0xFF033A44),
                                    fontFamily: Constant.subHadding),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  } else {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30.0),
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: chat['content'],
                      ),
                    );
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
