import 'package:flutter/material.dart';
import 'package:matchme/constant.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:matchme/controller/interest_controller.dart';
import 'package:provider/provider.dart';

class ProfileCard extends StatefulWidget {
  final List<String> profilePhotos;
  const ProfileCard({
    super.key,
    required this.profilePhotos,
  });

  @override
  State<ProfileCard> createState() => _ProfileCardState();
}

class _ProfileCardState extends State<ProfileCard> {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    var getSnap = Provider.of<InterestController>(context, listen: true).snap;
    var direction =
        Provider.of<InterestController>(context, listen: true).swipeDirection;

    return Container(
      width: double.infinity,
      height: size.height * 1.3 / 2,
      padding: const EdgeInsets.all(35.0),
      child: Center(
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            for (int i = 0; i < widget.profilePhotos.length; i++)
              // ::::::::: Profile Image :::::::
              Positioned(
                right: (i == 0
                    ? 30.0
                    : i == 1
                        ? 20.0
                        : i == 2
                            ? 10.0
                            : i == 3
                                ? 0.0
                                : 0.0),
                left: (i == 0
                    ? 30.0
                    : i == 1
                        ? 20.0
                        : i == 2
                            ? 10.0
                            : i == 3
                                ? 0.0
                                : 0.0),
                top: (i == 1
                    ? 20.0
                    : i == 2
                        ? 40.0
                        : i == 3
                            ? 60.0
                            : 0.0),
                bottom: 0.0,
                child: Container(
                  height: double.infinity,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30.0),
                    boxShadow: const [
                      BoxShadow(
                        color: Color.fromARGB(255, 91, 87, 87),
                        blurRadius: 5.0,
                      )
                    ],
                    image: DecorationImage(
                      image: NetworkImage(widget.profilePhotos[i]),
                      fit: BoxFit.cover,
                    ),
                  ),
                  // ::::::::::: Details Card Here ::::::::
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 10.0, vertical: 10.0),
                        padding: const EdgeInsets.all(10.0),
                        width: double.infinity,
                        height: size.height * 0.3 / 2,
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(156, 0, 0, 0),
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "John, 27",
                              style: TextStyle(
                                fontSize: 23.0,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 3.0),
                            const Text.rich(
                              style: TextStyle(
                                  color: Colors.white, fontSize: 12.0),
                              TextSpan(
                                children: [
                                  WidgetSpan(
                                    child: Icon(
                                      Icons.location_on_outlined,
                                      size: 12.0,
                                      color: Colors.white,
                                    ),
                                  ),
                                  TextSpan(
                                      text: "\tSan Francisco • 20 kms away")
                                ],
                              ),
                            ),
                            const Spacer(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Container(
                                  width: 10.0,
                                  height: 10.0,
                                  decoration: BoxDecoration(
                                    color: const Color.fromARGB(255, 90, 206, 94),
                                    borderRadius: BorderRadius.circular(100.0),
                                    boxShadow: const [
                                      BoxShadow(
                                        color: Color.fromARGB(255, 172, 230, 106),
                                        blurRadius: 5.0,
                                        spreadRadius: 3.0,
                                      )
                                    ],
                                  ),
                                ),
                                const SizedBox(width: 15.0,),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 30.0,
                                    vertical: 7.0,
                                  ),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: const Color.fromARGB(
                                          255, 153, 149, 149),
                                    ),
                                    borderRadius: BorderRadius.circular(30.0),
                                  ),
                                  child: Text(
                                    "Active Now",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: Constant.subHadding,
                                      fontSize: 14.0,
                                    ),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              )
                  .animate(
                    target:
                        i == widget.profilePhotos.length - 1 && getSnap ? 1 : 0,
                  )
                  .slide(
                    duration: 2000.ms,
                    begin: Offset.zero,
                    end: direction == 'left'
                        ? const Offset(-1.5, -0.2)
                        : direction == 'right'
                            ? const Offset(1.5, -0.2)
                            : const Offset(0.0, -2.0), // up
                    curve: Curves.easeOutBack,
                  )
                  .rotate(
                    duration: 800.ms,
                    delay: 100.ms,
                    end: direction == 'left'
                        ? -0.09
                        : direction == 'right'
                            ? 0.09
                            : 0.0, // no rotation for up
                    alignment: direction == 'left'
                        ? Alignment.bottomRight
                        : direction == 'right'
                            ? Alignment.bottomLeft
                            : Alignment.center,
                    curve: Curves.easeOut,
                  )
                  .scale(
                    duration: 800.ms,
                    begin: const Offset(1.0, 1.0),
                    end: const Offset(0.8, 0.8),
                    curve: Curves.easeOut,
                  )
                  .fadeOut(
                    duration: 400.ms,
                    delay: 200.ms, // starts mid-swipe
                    curve: Curves.easeOut,
                  )
                  .blur(
                    duration: 400.ms,
                    delay: 300.ms,
                    curve: Curves.easeOut,
                  ),
          ],
        ),
      ),
    );
  }
}
