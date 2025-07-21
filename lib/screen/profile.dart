import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controller/mainpage_controller.dart';
import '../widgets/slider.dart';
import '../constant.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  List<Map<String, dynamic>> interest = [
    {"name": "Movie", "color": Colors.green},
    {"name": "Photography", "color": Colors.blueAccent},
    {"name": "Reading Book", "color": Colors.blueAccent},
    {"name": "Design", "color": Colors.lightBlue},
    {"name": "Singing", "color": const Color.fromARGB(255, 29, 245, 108)},
    {"name": "Music", "color": const Color.fromARGB(255, 237, 188, 75)}
  ];

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: double.infinity,
          height: double.infinity,
          color: const Color(0xFFF5F7F7),
          child: ListView(
            padding: const EdgeInsets.only(bottom: 20.0),
            children: [
              SizedBox(
                width: double.infinity,
                height: size.height * 0.9 / 2,
                child: Stack(
                  children: [
                    const ProfileSlider(
                      imgs: [
                        "assets/images/Photo.png",
                        "assets/images/Photo.png",
                        "assets/images/Photo.png"
                      ],
                    ),
                    Positioned(
                      left: 20.0,
                      right: 20.0,
                      top: 20.0,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                            onTap: () {
                              Provider.of<MainpageController>(
                                context,
                                listen: false,
                              ).updatePosition("home");
                              Provider.of<MainpageController>(
                                context,
                                listen: false,
                              ).setBottomIndex(0);
                            },
                            child: const CircleAvatar(
                              backgroundColor: Colors.white,
                              child: Icon(Icons.arrow_back_ios_sharp),
                            ),
                          ),
                          const CircleAvatar(
                            backgroundColor: Colors.white,
                            child: Icon(Icons.edit_square),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20.0),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text.rich(
                      TextSpan(
                        text: "Reza E Prasetyo, 26",
                        style: TextStyle(
                          fontSize: 25.0,
                          fontFamily: Constant.haddingFont,
                          color: const Color(0xFF033A44),
                          fontWeight: FontWeight.bold,
                        ),
                        children: const [
                          WidgetSpan(
                            child: Padding(
                              padding: EdgeInsets.only(left: 10.0),
                              child: Icon(
                                Icons.check_circle,
                                color: Color(0xFF84BA2B),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Text.rich(
                      TextSpan(
                        children: [
                          const WidgetSpan(
                            child: Icon(
                              Icons.location_on_rounded,
                              color: Color(0xFFFD397F),
                              size: 18.0,
                            ),
                          ),
                          TextSpan(
                            text: "Jakarta, Indonesia",
                            style: TextStyle(
                              fontSize: 16.0,
                              fontFamily: Constant.subHadding,
                              color: const Color(0xFF1690A7),
                            ),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(height: 25.0),
                    Text(
                      "About",
                      style: TextStyle(
                        fontFamily: Constant.haddingFont,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF033A44),
                        fontSize: 18.0,
                      ),
                    ),
                    Text(
                      "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Curabitur tempus lacus in quam laoreet, eget finibus orci pharetra. Sed molestie leo eget urna egestas tristique. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Donec nec luctus tortor, at sagittis orci.",
                      style: TextStyle(
                        fontFamily: Constant.subHadding,
                        fontSize: 15.0,
                        color: Colors.black,
                        overflow: TextOverflow.clip,
                      ),
                    ),
                    const SizedBox(height: 25.0),
                    Text(
                      "Interset",
                      style: TextStyle(
                        fontFamily: Constant.haddingFont,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF033A44),
                        fontSize: 18.0,
                      ),
                    ),
                    const SizedBox(height: 5.0),
                    Wrap(
                      spacing: 10.0,
                      runSpacing: 10.0,
                      children: interest.map((e) {
                        return Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20.0, vertical: 5.0),
                          decoration: BoxDecoration(
                            color: e['color'],
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          child: Text(
                            e['name'],
                            style: const TextStyle(
                              color: Colors.white,
                            ), // optional styling
                          ),
                        );
                      }).toList(),
                    )
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
