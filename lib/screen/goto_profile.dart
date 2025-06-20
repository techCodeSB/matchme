import 'package:flutter/material.dart';
import '../widgets/container_button.dart';
import '../constant.dart';

class GotoProfile extends StatefulWidget {
  const GotoProfile({super.key});

  @override
  State<GotoProfile> createState() => _GotoProfileState();
}

class _GotoProfileState extends State<GotoProfile> {
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
                    'assets/images/matchme-logo-white.png',
                    width: 350,
                    height: 350,
                  ),
                ),
              ),
            ),
            const Spacer(),
            Text.rich(
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontFamily: Constant.haddingFont,
                fontWeight: FontWeight.bold,
                fontSize: 30.0,
              ),
              const TextSpan(
                text: 'Lorem Ipsum is simply\n',
                children: [
                  TextSpan(text: "dummy text of the"),
                ],
              ),
            ),
            const SizedBox(height: 20.0),
            Text.rich(
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontFamily: Constant.subHadding,
                fontSize: 20.0,
              ),
              const TextSpan(
                text: 'Ut enim ad minima veniam, quis nostrum\n',
                children: [
                  TextSpan(text: "exercitationem ullam corporis"),
                ],
              ),
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: ContainerButton(
                text: "Go to Profile",
                color: Colors.white,
                textColor: Colors.black,
                onTap: () {},
              ),
            ),
            const SizedBox(height: 40.0),
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
