import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../constant.dart';

class MoreQuestionNext extends StatefulWidget {
  const MoreQuestionNext({super.key});

  @override
  State<MoreQuestionNext> createState() => _MoreQuestionNextState();
}

class _MoreQuestionNextState extends State<MoreQuestionNext> {
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
            image: AssetImage("assets/images/partner_hand.png"),
            fit: BoxFit.cover,
            opacity: 0.7,
          ),
        ),
        child: Column(
          children: [
            const Spacer(),
            Image.asset("assets/images/matchme-logo-white.png"),
            const Spacer(),
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 20.0,
                vertical: 30.0,
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
                    "Few more Questions to find your perfect match . . . .",
                    style: TextStyle(
                      fontSize: size.height * 0.04,
                      fontWeight: FontWeight.bold,
                      fontFamily: Constant.haddingFont ?? 'josefinSans',
                      color: const Color(0xFF0C5461),
                      overflow: TextOverflow.clip,
                    ),
                  ),
                  const Spacer(),
                  Container(
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
                            "Next",
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
                  )
                ],
              ),
            )
                .animate()
                .slide(
                  begin: const Offset(0, 1), // From bottom
                  end: Offset.zero,
                  curve: Curves.easeIn,
                  duration: 400.ms,
                )
                .fadeIn(duration: 300.ms),
          ],
        ),
      ),
    );
  }
}
