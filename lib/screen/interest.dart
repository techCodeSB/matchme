import 'package:flutter/material.dart';
import 'package:matchme/controller/interest_controller.dart';
import 'package:matchme/widgets/profile_card.dart';
import 'package:provider/provider.dart';
import '../constant.dart';


class Interest extends StatefulWidget {
  const Interest({super.key});

  @override
  State<Interest> createState() => _InterestState();
}

class _InterestState extends State<Interest> {
  @override
  Widget build(BuildContext context) {
    // final size = MediaQuery.of(context).size;
    var profileImg = Provider.of<InterestController>(
      context,
      listen: true,
    ).stackData;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "Interested in You",
            style: TextStyle(
              fontFamily: Constant.haddingFont,
              fontSize: 22.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
          scrolledUnderElevation: 0.0,
          // toolbarHeight: 70.0,
        ),
        body: profileImg.isEmpty
            ? const Center(
                child: Text("No Proile"),
              )
            : ListView(
                children: [
                  ProfileCard(profilePhotos: profileImg),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Close || dislike Button;
                      InkWell(
                        onTap: () async {
                          await Provider.of<InterestController>(
                            context,
                            listen: false,
                          ).popStackData(direction: "left");
                        },
                        child: Container(
                          height: 60.0,
                          width: 60.0,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(50.0),
                            boxShadow: const [
                              BoxShadow(
                                color: Color.fromARGB(255, 105, 102, 102),
                                blurRadius: 20.0,
                              )
                            ],
                          ),
                          child: const Icon(
                            Icons.close,
                            color: Colors.black,
                            size: 30.0,
                          ),
                        ),
                      ),
                      const SizedBox(width: 40.0),

                      // Favorite button;
                      InkWell(
                        onTap: () async {
                          Provider.of<InterestController>(
                            context,
                            listen: false,
                          ).setIsLovesSymbolRed();

                          await Provider.of<InterestController>(
                            context,
                            listen: false,
                          ).popStackData(direction: "right");
                        },
                        child: Container(
                          height: 80.0,
                          width: 80.0,
                          decoration: BoxDecoration(
                            color: const Color(0xFF0C5461),
                            borderRadius: BorderRadius.circular(50.0),
                            boxShadow: const [
                              BoxShadow(
                                color: Color.fromARGB(255, 105, 102, 102),
                                blurRadius: 20.0,
                              )
                            ],
                          ),
                          child: Icon(
                            Icons.favorite_rounded,
                            color: Provider.of<InterestController>(
                              context,
                              listen: true,
                            ).isLovesSymbolRed
                                ? Colors.red
                                : Colors.white,
                            size: 35.0,
                          ),
                        ),
                      ),

                      const SizedBox(width: 40.0),

                      // Bookmark button
                      InkWell(
                        onTap: () async {
                          await Provider.of<InterestController>(
                            context,
                            listen: false,
                          ).popStackData(direction: "up");
                        },
                        child: Container(
                          height: 60.0,
                          width: 60.0,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(50.0),
                            boxShadow: const [
                              BoxShadow(
                                color: Color.fromARGB(255, 105, 102, 102),
                                blurRadius: 20.0,
                              )
                            ],
                          ),
                          child: const Icon(
                            Icons.bookmark_outline_rounded,
                            color: Colors.black,
                            size: 30.0,
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
      ),
    );
  }
}
