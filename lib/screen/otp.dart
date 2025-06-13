import 'package:flutter/material.dart';
import '../constant.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'get_started.dart';

class Otp extends StatefulWidget {
  const Otp({super.key});

  @override
  State<Otp> createState() => _OtpState();
}

class _OtpState extends State<Otp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: ListView(
          children: [
            Container(
              padding: const EdgeInsets.only(top: 30.0, left: 20.0, right: 0.0),
              width: double.infinity,
              height: 90.0,
              alignment: Alignment.topLeft,
              child: InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: const Icon(
                  Icons.arrow_back_ios_new,
                  color: Colors.black,
                ),
              ),
            ),
            Container(
              width: double.infinity,
              margin: const EdgeInsets.only(top: 50.0),
              child: Column(
                children: [
                  Container(
                    width: 120.0,
                    height: 120.0,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(0xFF033A44),
                    ),
                    child: Stack(
                      children: [
                        Positioned(
                          top: 10.0,
                          left: 10.0,
                          child: Container(
                            width: 100.0,
                            height: 100.0,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Color(0xFF1690A7),
                            ),
                          ),
                        ),
                        Positioned(
                          left: 10.0,
                          child: Image.asset(
                            'assets/images/otp-icon.png',
                            width: 100.0,
                            height: 100.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    child: Text(
                      "Verification Code",
                      style: TextStyle(
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontFamily: Constant.haddingFont,
                      ),
                    ),
                  ),
                  Text(
                    "Enter the 5-digit code we’ve sent to ******97",
                    style: TextStyle(
                      fontSize: 16.0,
                      color: const Color(0xFF676666),
                      fontFamily: Constant.subHadding,
                    ),
                  ),
                  const SizedBox(height: 40.0),
                  OtpTextField(
                    numberOfFields: 5,
                    borderColor: const Color(0xFF1690A7),
                    showFieldAsBox: true,
                    borderWidth: 2.0,
                    focusedBorderColor: const Color(0xFF1690A7),
                    enabledBorderColor: const Color(0xFF1690A7),
                    textStyle: TextStyle(
                      fontSize: 20.0,
                      color: Colors.black,
                      fontFamily: Constant.haddingFont,
                    ),
                    onSubmit: (String verificationCode) {
                      // Handle the verification code submission
                      // print("Verification Code: $verificationCode");
                    },
                    fieldHeight: 50.0,
                    fieldWidth: 50.0,
                    contentPadding: const EdgeInsets.only(bottom: 10.0),
                  ),
                  const SizedBox(height: 20.0),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 65.0),
                    child: Row(
                      children: [
                        Text(
                          "Didn’t receive the OTP?",
                          style: TextStyle(
                            fontSize: 15.0,
                            color: const Color(0xFF888888),
                            fontFamily: Constant.subHadding,
                          ),
                        ),
                        const Spacer(),
                        Column(
                          children: [
                            InkWell(
                              child: Text(
                                "Resend",
                                style: TextStyle(
                                  fontSize: 16.0,
                                  color: const Color(0xFF033A44),
                                  fontFamily: Constant.subHadding,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Container(
                              width: 55.0,
                              height: 2.0,
                              decoration: BoxDecoration(
                                color: const Color(0xFF033A44),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  const SizedBox(height: 30.0),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 60.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: Container(
                            height: 40.0,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30.0),
                              border: Border.all(
                                color: const Color(0xFF033A44),
                                width: 2.0,
                              ),
                            ),
                            child: Center(
                              child: Text(
                                "Cancel",
                                style: TextStyle(
                                  fontFamily: Constant.subHadding,
                                  fontSize: 16.0,
                                  color: const Color(0xFF033A44),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 20.0),
                        Expanded(
                          child: InkWell(
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(
                                builder: (context) {
                                  return const GetStarted();
                                },
                              ));
                            },
                            child: Container(
                              height: 40.0,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30.0),
                                color: const Color(0xFF033A44),
                              ),
                              child: Center(
                                child: Text(
                                  "Verfiy",
                                  style: TextStyle(
                                    fontFamily: Constant.haddingFont,
                                    fontSize: 16.0,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
