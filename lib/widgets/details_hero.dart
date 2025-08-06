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
      height: size!.height * 0.25,
      decoration: const BoxDecoration(
        color: Color(0xFFF3FAFF),
      ),
      child: Stack(
        children: [
          Positioned(
            left: 20.0,
            right: 20.0,
            top: 30.0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: const CircleAvatar(
                    backgroundColor: Colors.white,
                    child: Icon(Icons.arrow_back_ios_sharp),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            top: size!.height * 0.05,
            child: Image.asset(
              "assets/images/matchme-logo 2.png",
              height: size!.height * 0.1,
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
