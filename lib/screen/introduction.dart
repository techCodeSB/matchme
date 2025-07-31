import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:percent_indicator/percent_indicator.dart';
import '../widgets/details_hero.dart';
import '../screen/lifestyle_5.dart';
import '../constant.dart';
import '../widgets/error_text.dart';
import '../controller/register_controller.dart';
import 'package:matchme/widgets/registration_bottom_buttons.dart';

class Introduction extends StatefulWidget {
  const Introduction({super.key});

  @override
  State<Introduction> createState() => _IntroductionState();
}

class _IntroductionState extends State<Introduction> {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(size.height * 0.3),
        child: DetailsHero(
          size: size,
        ),
      ),
      body: SafeArea(
        child: Container(
          width: double.infinity,
          height: double.infinity,
          color: Colors.white,
          child: ListView(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: size.width * 0.05,
                  vertical: size.height * 0.01,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Life Style",
                      style: TextStyle(
                        color: const Color(0XFF033A44),
                        fontSize: 30.0,
                        fontWeight: FontWeight.bold,
                        fontFamily: Constant.haddingFont,
                      ),
                    ),
                    CircularPercentIndicator(
                      radius: 40.0, //size
                      lineWidth: 13.0,
                      percent: 0.77,
                      center: Text(
                        "77%",
                        style: TextStyle(
                          color: const Color(0xFF033A44),
                          fontFamily: Constant.haddingFont,
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0,
                        ),
                      ),
                      linearGradient: const LinearGradient(
                        colors: [Color(0xFF1690A7), Color(0xFF033A44)],
                        begin: Alignment.topRight,
                        end: Alignment.bottomLeft,
                      ),
                      backgroundColor: const Color(0xFFD9D9D9),
                      animation: true,
                      animateFromLastPercent: true,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20.0),
              // ::::::::::::::::::::::::::::::::::::::::::::::: FORM FIELDS ::::::::::::::::::::::::::::::::::::::::::::::::
              Text(
                "Please write a bried introduction",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: const Color(0xFF033A44),
                  fontFamily: Constant.subHadding,
                  fontSize: 15.0,
                ),
              ),
              const SizedBox(height: 15.0),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
                child: TextField(
                  controller: RegisterController.introduction,
                  onTap: () {
                    Provider.of<RegisterController>(context, listen: false)
                        .setErrorMsg({"introduction": false});
                  },
                  maxLines: 5,
                  decoration: InputDecoration(
                    hintText:
                        "Please write 5-6 line about discribing your self, where you were born, brought up, personality etc.",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
                child: ErrorText(
                  text: "Introduction can't be blank",
                  visible:
                      Provider.of<RegisterController>(context, listen: true)
                          .errMsg['introduction']!,
                ),
              ),
              SizedBox(height: size.height * 0.08),
              SizedBox(
                width: double.infinity,
                child: Image.asset(
                  "assets/images/Vector 1.png",
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 100.0),
            ],
          ),
        ),
      ),
      bottomSheet: RegistrationBottomButtons(
        onNextTap: () {
          Provider.of<RegisterController>(
            context,
            listen: false,
          ).introductionSubmit(context);
        },
        onBackTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const Lifestyle5(),
            ),
          );
        },
      ),
    );
  }
}
