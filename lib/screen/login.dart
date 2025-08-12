import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../controller/login_controller.dart';
import '../widgets/error_text.dart';
import 'package:provider/provider.dart';
// import 'package:match_me/screen/otp.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minHeight: size.height,
          ),
          child: IntrinsicHeight(
            child: Container(
              width: double.infinity,
              height: double.infinity,
              color: const Color(0xFFE4F3FF),
              child: Column(
                children: [
                  SizedBox(
                    height: size.height * 0.7 / 2,
                    child: Stack(
                      children: [
                        // Top left circle
                        Positioned(
                          top: -size.height * 0.12,
                          left: -size.width * 0.05,
                          child: createCircle(
                            0xFF1690A7,
                            size.width * 0.6,
                            size.height * 0.3,
                            true,
                          ),
                        ),
                        // Top right circle with image inside
                        Positioned(
                          top: -size.height * 0.13,
                          right: -size.width * 0.3,
                          child: createCircle(
                            0xFF0C5461,
                            size.width,
                            size.height * 0.9 / 2,
                            true,
                            Padding(
                              padding:
                                  const EdgeInsets.only(right: 50.0, top: 90.0),
                              child: Center(
                                child: Image.asset(
                                  'assets/images/matchme-logo-white.png',
                                  width: 120,
                                  height: 120,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(horizontal: 30.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "LOGIN",
                          style: TextStyle(
                            fontSize: 30.0,
                            fontFamily: GoogleFonts.nunito().fontFamily,
                            color: const Color(0xFF0C5461),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Container(
                          width: 90.0,
                          height: 3.0,
                          margin: const EdgeInsets.only(top: 0.0, bottom: 20.0),
                          decoration: BoxDecoration(
                            color: const Color(0xFF0C5461),
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                        ),
                        // *************** Start Input field ******************
                        // ****************************************************
                        SizedBox(height: size.height * 0.02),
                        TextField(
                          controller: LoginController.username,
                          onTap: () {
                            Provider.of<LoginController>(context, listen: false)
                                .setErrorMsg({"user": false});
                          },
                          style: TextStyle(
                            color: const Color(0xFF0C5461),
                            fontFamily: GoogleFonts.nunito().fontFamily,
                          ),
                          decoration: const InputDecoration(
                            floatingLabelStyle: TextStyle(
                              color: Color(0xFF0C5461),
                            ),
                            labelText: 'Username',
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(30.0)),
                              borderSide: BorderSide(color: Color(0xFF1690A7)),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(30.0)),
                              borderSide: BorderSide(color: Color(0xFF0C5461)),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(30.0)),
                              borderSide: BorderSide(color: Color(0xFF0C5461)),
                            ),
                            prefixIcon: Icon(Icons.account_circle_outlined),
                            contentPadding: EdgeInsets.all(10.0),
                            alignLabelWithHint: true,
                          ),
                        ),
                        ErrorText(
                          text: "Username can't be blank",
                          visible: Provider.of<LoginController>(context,
                                  listen: true)
                              .errMsg['user']!,
                        ),
                        SizedBox(height: size.height * 0.02),
                        TextField(
                          controller: LoginController.password,
                          onTap: () {
                            Provider.of<LoginController>(context, listen: false)
                                .setErrorMsg({"pass": false});
                          },
                          style: TextStyle(
                            color: const Color(0xFF0C5461),
                            fontFamily: GoogleFonts.nunito().fontFamily,
                          ),
                          obscureText: true,
                          decoration: const InputDecoration(
                            labelText: 'Password',
                            floatingLabelStyle: TextStyle(
                              color: Color(0xFF0C5461),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(30.0),
                              ),
                              borderSide: BorderSide(color: Color(0xFF1690A7)),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(30.0)),
                              borderSide: BorderSide(color: Color(0xFF0C5461)),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(30.0)),
                              borderSide: BorderSide(color: Color(0xFF0C5461)),
                            ),
                            prefixIcon: Icon(Icons.lock_outline_rounded),
                            contentPadding: EdgeInsets.all(10.0),
                            alignLabelWithHint: true,
                          ),
                        ),
                        ErrorText(
                          text: "Password can't be blank",
                          visible: Provider.of<LoginController>(context,
                                  listen: true)
                              .errMsg['pass']!,
                        ),
                        SizedBox(height: size.height * 0.02),
                        InkWell(
                          onTap: () {
                            Provider.of<LoginController>(context, listen: false)
                                .login(context)
                                .then((v) {
                              Provider.of<LoginController>(
                                context,
                                listen: false,
                              ).addFcmToken(context);
                            });

                            // Navigator.push(
                            //   context,
                            //   MaterialPageRoute(
                            //     builder: (context) => const Otp(),
                            //   ),
                            // );
                          },
                          child: Container(
                            width: double.infinity,
                            height: 50.0,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30.0),
                              color: const Color(0xFF0C5461),
                            ),
                            child: Center(
                              child: Text(
                                "Login",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: GoogleFonts.nunito().fontFamily,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: size.height * 0.02),
                        InkWell(
                          onTap: () {
                            // Navigator.push(
                            //   context,
                            //   MaterialPageRoute(
                            //     builder: (context) => const Otp(),
                            //   ),
                            // );
                          },
                          child: Container(
                            width: double.infinity,
                            height: 50.0,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30.0),
                              color: const Color(0xFF1690A7),
                            ),
                            child: Center(
                              child: Text(
                                "Login with OTP",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: GoogleFonts.nunito().fontFamily,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Stack(
                      children: [
                        Positioned(
                          bottom: -size.height * 0.3 / 2,
                          left: -size.width * 0.5 / 2,
                          child: createCircle(
                            0xFF0C5461,
                            size.width * 0.6,
                            size.height * 0.3,
                            false,
                          ),
                        ),
                        Positioned(
                          bottom: size.height * 0.1,
                          left: size.width * 0.5 / 2,
                          child: createCircle(0xFF1690A7, 60, 60, false),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

Widget createCircle(int color, double width, double height, bool isShadow,
    [Widget? child]) {
  return Container(
    width: width,
    height: height,
    decoration: BoxDecoration(
      color: Color(color),
      shape: BoxShape.circle,
      boxShadow: isShadow
          ? const <BoxShadow>[
              BoxShadow(
                blurRadius: 8.0,
                color: Colors.black,
                spreadRadius: 0.07,
              )
            ]
          : null,
    ),
    child: child,
  );
}
