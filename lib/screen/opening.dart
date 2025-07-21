import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../controller/splash_controller.dart';
import '../constant.dart';

class Opening extends StatefulWidget {
  const Opening({super.key});

  @override
  State<Opening> createState() => _OpeningState();
}

class _OpeningState extends State<Opening> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          color: Color.fromARGB(255, 0, 0, 0),
          image: DecorationImage(
            image: AssetImage("assets/images/opening.png"),
            fit: BoxFit.cover,
            opacity: 0.4,
          ),
        ),
        child: Column(
          children: [
            SizedBox(height: size.height * 0.2),
            Image.asset(
              "assets/images/matchme-logo-white.png",
              width: size.width * 0.5,
              height: size.height * 0.3,
            ).animate().fadeIn(
              duration: const Duration(milliseconds: 1500),
            ),
          ],
        ),
      ),
      bottomSheet: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 20.0,
          vertical: 10.0,
        ),
        width: double.infinity,
        height: size.height * 0.7 / 2,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(60.0),
            topRight: Radius.circular(60.0),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 10.0),
            Text(
              "Find your perfect match",
              style: TextStyle(
                fontSize: size.height * 0.04,
                fontWeight: FontWeight.bold,
                fontFamily: Constant.haddingFont ?? 'josefinSans',
                color: const Color(0xFF0C5461),
                overflow: TextOverflow.clip,
              ),
            ),
            const SizedBox(height: 10.0),
            Text(
              "with our community you can find your perfect dating partner",
              style: TextStyle(
                fontSize: size.height * 0.025,
                fontFamily: Constant.haddingFont ?? 'josefinSans',
                color: const Color(0xFF0C5461),
                overflow: TextOverflow.clip,
              ),
            ),
            const SizedBox(height: 30.0),
            InkWell(
              onTap: () {
                SplashController.setOpeningStatus(context);
              },
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                width: double.infinity,
                height: size.height * 0.07,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30.0),
                  color: const Color(0xFF033A44),
                ),
                child: Center(
                  child: Row(
                    children: [
                      Text(
                        "Discover",
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: Constant.haddingFont ?? 'josefinSans',
                          fontSize: 22.0,
                        ),
                      ),
                      const Spacer(),
                      const Icon(
                        Icons.arrow_right_alt_outlined,
                        color: Colors.white,
                        size: 40.0,
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
