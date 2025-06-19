import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:percent_indicator/percent_indicator.dart';
import '../widgets/details_hero.dart';
import '../constant.dart';
import '../widgets/interest_button.dart';
import 'package:icons_plus/icons_plus.dart';
import '../widgets/error_text.dart';
import '../controller/register_controller.dart';

class Lifestyle3 extends StatefulWidget {
  const Lifestyle3({super.key});

  @override
  State<Lifestyle3> createState() => _Lifestyle3State();
}

class _Lifestyle3State extends State<Lifestyle3> {
  final List<String> _selectedInterest = [];

  void setInterest(i) {
    setState(() {
      if (_selectedInterest.length > 4) {
        if (_selectedInterest.contains(i)) {
          _selectedInterest.remove(i);
        } else {
          // use index counting 0-4 = 5
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: const Text("You can select only 5 item"),
                icon: const Align(
                  alignment: Alignment.topLeft,
                  child: Icon(
                    Icons.warning_amber_rounded,
                    size: 30.0,
                    color: Colors.amber,
                  ),
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text("OK"),
                  )
                ],
              );
            },
          );
        }

        return;
      }
      if (_selectedInterest.contains(i)) {
        _selectedInterest.remove(i);
      } else {
        _selectedInterest.add(i);
      }
    });

    Provider.of<RegisterController>(context, listen: false)
        .setErrorMsg({"interest": false});
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Container(
          color: const Color(0xFFF5F7F7),
          width: double.infinity,
          height: double.infinity,
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
              ),
              const SizedBox(height: 20.0),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Expanded( // previous this is container
                  // width: double.infinity,
                  // height: size.height * 0.6,
                  // color: Colors.white,
                  child: Column(
                    children: [
                      Text(
                        'Select up to 5 interest',
                        style: TextStyle(
                          color: Colors.black,
                          fontFamily: Constant.haddingFont,
                          fontSize: 25.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "Tell us what piques your curiosity and\npassions",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: Constant.subHadding,
                          fontSize: 15.0,
                          color: const Color(0xFF333333),
                        ),
                      ),
                      ErrorText(
                        text: "Select an option",
                        visible: Provider.of<RegisterController>(context,
                                listen: true)
                            .errMsg['interest']!,
                      ),
                      const SizedBox(height: 15.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          InterestButton(
                            icons: Icons.menu_book_outlined,
                            text: "Reading",
                            onChanged: (v) {
                              setInterest("Reading");
                            },
                            isSelected: _selectedInterest.contains("Reading"),
                          ),
                          const SizedBox(width: 15.0),
                          InterestButton(
                            icons: Icons.camera,
                            text: "Photography",
                            onChanged: (v) {
                              setInterest("Photography");
                            },
                            isSelected:
                                _selectedInterest.contains("Photography"),
                          )
                        ],
                      ),
                      const SizedBox(height: 15.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          InterestButton(
                            icons: Icons.sports_esports_outlined,
                            text: "Gaming",
                            onChanged: (v) {
                              setInterest("Gaming");
                            },
                            isSelected: _selectedInterest.contains("Gaming"),
                          ),
                          InterestButton(
                            onChanged: (v) {
                              setInterest("Music");
                            },
                            icons: Icons.music_note,
                            text: "Music",
                            isSelected: _selectedInterest.contains("Music"),
                          ),
                          InterestButton(
                            onChanged: (v) {
                              setInterest("Travel");
                            },
                            icons: Icons.travel_explore,
                            text: "Travel",
                            isSelected: _selectedInterest.contains("Travel"),
                          ),
                        ],
                      ),
                      const SizedBox(height: 15.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          InterestButton(
                            onChanged: (v) {
                              setInterest("Painting");
                            },
                            icons: FontAwesome.paintbrush_solid,
                            text: "Painting",
                            isSelected: _selectedInterest.contains("Painting"),
                          ),
                          const SizedBox(width: 15.0),
                          InterestButton(
                            onChanged: (v) {
                              setInterest("Politics");
                            },
                            icons: Icons.man,
                            text: "Politics",
                            isSelected: _selectedInterest.contains("Politics"),
                          ),
                        ],
                      ),
                      const SizedBox(height: 15.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          InterestButton(
                            onChanged: (v) {
                              setInterest("Charity");
                            },
                            icons: Bootstrap.people_fill,
                            text: "Charity",
                            isSelected: _selectedInterest.contains("Charity"),
                          ),
                          InterestButton(
                            onChanged: (v) {
                              setInterest("Cooking");
                            },
                            icons: FontAwesome.spoon_solid,
                            text: "Cooking",
                            isSelected: _selectedInterest.contains("Cooking"),
                          ),
                          InterestButton(
                            onChanged: (v) {
                              setInterest("Pets");
                            },
                            icons: Icons.pets,
                            text: "Pets",
                            isSelected: _selectedInterest.contains("Pets"),
                          ),
                        ],
                      ),
                      const SizedBox(height: 15.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          InterestButton(
                            onChanged: (v) {
                              setInterest("Sports");
                            },
                            icons: Icons.sports_basketball,
                            text: "Sports",
                            isSelected: _selectedInterest.contains("Sports"),
                          ),
                          const SizedBox(width: 15.0),
                          InterestButton(
                            onChanged: (v) {
                              setInterest("Sports");
                            },
                            icons: FontAwesome.shirt_solid,
                            text: "Sports",
                            isSelected: _selectedInterest.contains("Sports"),
                          ),
                        ],
                      ),
                      const SizedBox(height: 15.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          InterestButton(
                            onChanged: (v) {
                              setInterest("Literature");
                            },
                            icons: FontAwesome.book_atlas_solid,
                            text: "Literature",
                            isSelected:
                                _selectedInterest.contains("Literature"),
                          ),
                          InterestButton(
                            onChanged: (v) {
                              setInterest("Travle");
                            },
                            icons: FontAwesome.mound_solid,
                            text: "Travle",
                            isSelected: _selectedInterest.contains("Travle"),
                          ),
                          InterestButton(
                            onChanged: (v) {
                              setInterest("Dance");
                            },
                            icons: FontAwesome.baby_solid,
                            text: "Dance",
                            isSelected: _selectedInterest.contains("Dance"),
                          ),
                        ],
                      ),
                      const SizedBox(height: 15.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          InterestButton(
                            onChanged: (v) {
                              setInterest("Nature");
                            },
                            icons: Icons.sports_basketball,
                            text: "Nature",
                            isSelected: _selectedInterest.contains("Nature"),
                          ),
                          const SizedBox(width: 15.0),
                          InterestButton(
                            onChanged: (v) {
                              setInterest("Sprituality");
                            },
                            icons: FontAwesome.shirt_solid,
                            text: "Sprituality",
                            isSelected:
                                _selectedInterest.contains("Sprituality"),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              // const Spacer(),
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
                          Provider.of<RegisterController>(
                            context,
                            listen: false,
                          ).lifeStyle3Submit(context, _selectedInterest);
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
      ),
    );
  }
}
