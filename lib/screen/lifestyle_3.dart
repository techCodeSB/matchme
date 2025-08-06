import 'package:flutter/material.dart';
import 'package:matchme/screen/lifestyle_2.dart';
import 'package:provider/provider.dart';
import 'package:percent_indicator/percent_indicator.dart';
import '../widgets/details_hero.dart';
import '../constant.dart';
import '../widgets/interest_button.dart';
import 'package:icons_plus/icons_plus.dart';
import '../widgets/error_text.dart';
import '../controller/register_controller.dart';
import 'package:matchme/widgets/registration_bottom_buttons.dart';

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
  void initState() {
    super.initState();
    // Initialize the selected interests from the provider
    _selectedInterest.addAll(RegisterController.interest);
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
          color: const Color(0xFFF5F7F7),
          width: double.infinity,
          height: double.infinity,
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
                      percent: 0.56,
                      center: Text(
                        "56%",
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
                child: Expanded(
                  // previous this is container
                  // width: double.infinity,
                  // height: size.height * 0.6,
                  // color: Colors.white,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
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
                        "What are your interests",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: Constant.subHadding,
                          fontSize: 18.0,
                          color: const Color(0xFF333333),
                        ),
                      ),
                      ErrorText(
                        text: "Select an option",
                        visible: Provider.of<RegisterController>(context,
                                listen: true)
                            .errMsg['interest']!,
                      ),
                      const SizedBox(height: 30.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          InterestButton(
                            icons: Icons.music_note,
                            text: "Music",
                            onChanged: (v) {
                              setInterest("Music");
                            },
                            isSelected: _selectedInterest.contains("Music"),
                          ),
                          const SizedBox(width: 15.0),
                          InterestButton(
                            icons: Icons.menu_book_sharp,
                            text: "Literature",
                            onChanged: (v) {
                              setInterest("Literature");
                            },
                            isSelected:
                                _selectedInterest.contains("Literature"),
                          )
                        ],
                      ),
                      const SizedBox(height: 15.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          InterestButton(
                            icons: Icons.sports_esports_outlined,
                            text: "Art",
                            onChanged: (v) {
                              setInterest("Art");
                            },
                            isSelected: _selectedInterest.contains("Art"),
                          ),
                          InterestButton(
                            onChanged: (v) {
                              setInterest("Adventure");
                            },
                            icons: Icons.music_note,
                            text: "Adventure",
                            isSelected: _selectedInterest.contains("Adventure"),
                          ),
                          InterestButton(
                            onChanged: (v) {
                              setInterest("Sports");
                            },
                            icons: Icons.sports_basketball,
                            text: "Sports",
                            isSelected: _selectedInterest.contains("Sports"),
                          ),
                        ],
                      ),
                      const SizedBox(height: 15.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          InterestButton(
                            onChanged: (v) {
                              setInterest("Dance");
                            },
                            icons: Bootstrap.people_fill,
                            text: "Dance",
                            isSelected: _selectedInterest.contains("Dance"),
                          ),
                          const SizedBox(width: 15.0),
                          InterestButton(
                            onChanged: (v) {
                              setInterest("Fitness & Welness");
                            },
                            icons: Icons.fitness_center_outlined,
                            text: "Fitness & Welness",
                            isSelected:
                                _selectedInterest.contains("Fitness & Welness"),
                          ),
                        ],
                      ),
                      const SizedBox(height: 15.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          InterestButton(
                            onChanged: (v) {
                              setInterest("Travel");
                            },
                            icons: FontAwesome.paintbrush_solid,
                            text: "Travel",
                            isSelected: _selectedInterest.contains("Travel"),
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
                          const SizedBox(width: 15.0),
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
                              setInterest("Foods");
                            },
                            icons: Icons.food_bank_outlined,
                            text: "Foods",
                            isSelected: _selectedInterest.contains("Foods"),
                          ),
                          const SizedBox(width: 15.0),
                          InterestButton(
                            onChanged: (v) {
                              setInterest("Cooking");
                            },
                            icons: FontAwesome.spoon_solid,
                            text: "Cooking",
                            isSelected: _selectedInterest.contains("Cooking"),
                          ),
                        ],
                      ),
                      const SizedBox(height: 15.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          InterestButton(
                            onChanged: (v) {
                              setInterest("Photography");
                            },
                            icons: FontAwesome.book_atlas_solid,
                            text: "Photography",
                            isSelected:
                                _selectedInterest.contains("Photography"),
                          ),
                          const SizedBox(width: 15.0),
                          InterestButton(
                            onChanged: (v) {
                              setInterest("Theatre");
                            },
                            icons: FontAwesome.mound_solid,
                            text: "Theatre",
                            isSelected: _selectedInterest.contains("Theatre"),
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
                            icons: Icons.nature,
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
                      const SizedBox(height: 15.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          InterestButton(
                            onChanged: (v) {
                              setInterest("Movie");
                            },
                            icons: FontAwesome.baby_solid,
                            text: "Movie",
                            isSelected: _selectedInterest.contains("Movie"),
                          ),
                          const SizedBox(width: 15.0),
                          InterestButton(
                            onChanged: (v) {
                              setInterest("Gaming");
                            },
                            icons: Icons.sports_esports_outlined,
                            text: "Gaming",
                            isSelected:
                                _selectedInterest.contains("Gaming"),
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
          ).lifeStyle3Submit(context, _selectedInterest);
        },
        onBackTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const Lifestyle2(),
            ),
          );
        },
      ),
    );
  }
}

