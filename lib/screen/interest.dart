import 'package:flutter/material.dart';
import 'package:match_me/widgets/container_button.dart';
import '../constant.dart';
import '../widgets/interest_button.dart';
import 'package:icons_plus/icons_plus.dart';

class Interest extends StatefulWidget {
  const Interest({super.key});

  @override
  State<Interest> createState() => _InterestState();
}

class _InterestState extends State<Interest> {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Container(
          color: const Color(0xFFF5F7F7),
          width: double.infinity,
          height: double.infinity,
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(10.0),
                width: double.infinity,
                height: size.height * 0.08,
                child: Stack(
                  children: [
                    IconButton(
                      onPressed: () {},
                      icon: Constant.backIcon,
                    ),
                    Center(
                      child: Container(
                        width: size.width * 0.5,
                        height: 10.0,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30.0),
                          color: const Color(0xFFD2F8FF),
                        ),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Container(
                            width: size.width * 0.05,
                            height: 10.0,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30.0),
                              color: const Color(0xFF033A44),
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 20.0),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: SizedBox(
                  width: double.infinity,
                  height: size.height * 0.5,
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
                      const SizedBox(height: 15.0),
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          InterestButton(
                            icons: Icons.menu_book_outlined,
                            text: "Reading",
                          ),
                          SizedBox(width: 15.0),
                          InterestButton(
                            icons: Icons.camera,
                            text: "Photography",
                          )
                        ],
                      ),
                      const SizedBox(height: 15.0),
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          InterestButton(
                            icons: Icons.sports_esports_outlined,
                            text: "Gaming",
                          ),
                          InterestButton(
                            icons: Icons.music_note,
                            text: "Music",
                          ),
                          InterestButton(
                            icons: Icons.travel_explore,
                            text: "Travel",
                          ),
                        ],
                      ),
                      const SizedBox(height: 15.0),
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          InterestButton(
                            icons: FontAwesome.paintbrush_solid,
                            text: "Painting",
                          ),
                          SizedBox(width: 15.0),
                          InterestButton(
                            icons: Icons.man,
                            text: "Politics",
                          ),
                        ],
                      ),
                      const SizedBox(height: 15.0),
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          InterestButton(
                            icons: Bootstrap.people_fill,
                            text: "Charity",
                          ),
                          InterestButton(
                            icons: FontAwesome.spoon_solid,
                            text: "Cooking",
                          ),
                          InterestButton(
                            icons: Icons.pets,
                            text: "Pets",
                          ),
                        ],
                      ),
                      const SizedBox(height: 15.0),
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          InterestButton(
                            icons: Icons.sports_basketball,
                            text: "Sports",
                          ),
                          SizedBox(width: 15.0),
                          InterestButton(
                            icons: FontAwesome.shirt_solid,
                            text: "Fashion",
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const Spacer(),
              SizedBox(
                width: double.infinity,
                child: Image.asset(
                  "assets/images/Vector 1.png",
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 30.0),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: ContainerButton(
                  text: "Continue",
                  color: Color(0xFF033A44),
                  textColor: Colors.white,
                ),
              ),
              const SizedBox(height: 30.0),
            ],
          ),
        ),
      ),
    );
  }
}
