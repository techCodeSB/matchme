import 'package:flutter/material.dart';

class DetailsHero extends StatelessWidget {
  final Size? size;
  const DetailsHero({
    super.key,
    this.size,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: size!.height * 0.3,
      decoration: const BoxDecoration(
        color: Color(0xFFF3FAFF),
      ),
      child: Stack(
        children: [
          Positioned(
            left: 0,
            right: 0,
            bottom: 0.0,
            child: Image.asset(
              "assets/images/matchme-logo 2.png",
              width: size!.width * 0.4,
            ),
          ),
          Positioned(
            bottom: size!.height * 0.03,
            left: 0.0,
            right: 0.0,
            child: Image.asset(
              "assets/images/Pattern.png",
              width: size!.width,
              fit: BoxFit.cover,
            ),
          ),
        ],
      ),
    );
  }
}
