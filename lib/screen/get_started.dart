import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../controller/register_controller.dart';
import '../constant.dart';

class GetStarted extends StatefulWidget {
  const GetStarted({super.key});

  @override
  State<GetStarted> createState() => _GetStartedState();
}

class _GetStartedState extends State<GetStarted> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: const Color(0xFF0C5461),
        child: Column(
          children: [
            ClipPath(
              clipper: BottomCurveClipper(),
              child: Container(
                width: 850,
                height: size.height * 0.5,
                decoration: const BoxDecoration(
                  color: Color(0xFF1690A7),
                ),
                child: Center(
                  child: Image.asset(
                    'assets/images/get-startd-img.png',
                    width: 350,
                    height: 350,
                  ),
                ),
              ),
            ),
            const Spacer(),
            Container(
              padding: EdgeInsets.symmetric(horizontal: size.width * 0.09 / 2),
              child: Column(
                children: [
                  Text(
                    "Let’s Build You Profile to Know Your Better",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: Constant.haddingFont,
                      fontWeight: FontWeight.bold,
                      fontSize: size.width * 0.07,
                    ),
                  ),
                  const SizedBox(height: 15.0),
                  Text(
                    "Ut enim ad minima veniam, quis nostrum exercitationem ullam corpori",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: Constant.subHadding,
                      fontSize: size.width * 0.05,
                      fontWeight: FontWeight.normal,
                    ),
                  )
                ],
              ),
            )
                .animate()
                .slide(
                  begin: const Offset(0, -5),
                  end: Offset.zero,
                  duration: 600.ms,
                  curve: Curves.easeOut,
                )
                .fadeIn(duration: 300.ms),
            const Spacer(),
            InkWell(
              onTap: () {
                RegisterController.getStarted(context);
              },
              child: Container(
                margin: const EdgeInsets.symmetric(
                  horizontal: 20.0,
                  vertical: 30.0,
                ),
                width: double.infinity,
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Center(
                  child: Text.rich(
                    TextSpan(
                      text: '',
                      style: TextStyle(
                        color: Colors.black,
                        fontFamily: Constant.subHadding,
                        fontWeight: FontWeight.bold,
                        fontSize: 18.0,
                      ),
                      children: [
                        WidgetSpan(
                          child: Image.asset(
                            'assets/images/hand.png',
                            width: 30,
                            height: 30,
                          ),
                        ),
                        const TextSpan(text: '\tGet Started'),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class BottomCurveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, size.height - 100); // Start point from bottom

    // Smooth curve
    path.quadraticBezierTo(
      size.width / 2,
      size.height + 40, // Control point for the curve
      size.width,
      size.height - 100,
    );

    path.lineTo(size.width, 0); // Right side up to top
    path.close(); // Close the path

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
