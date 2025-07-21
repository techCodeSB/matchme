import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:provider/provider.dart';
import '../screen/qualification_details.dart';
import '../constant.dart';
import '../widgets/details_textfield.dart';
import '../widgets/dropdown.dart';
import '../widgets/details_hero.dart';
import '../widgets/error_text.dart';
import '../controller/register_controller.dart';

class WorkDetails extends StatefulWidget {
  const WorkDetails({super.key});

  @override
  State<WorkDetails> createState() => _WorkDetailsState();
}

class _WorkDetailsState extends State<WorkDetails> {
  String _profession = "";

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.white,
        child: ListView(
          children: [
            DetailsHero(size: size),
            // *********************** TOP BAR CLOSE ***********************

            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: size.width * 0.05,
                vertical: size.height * 0.01,
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Work Details",
                        style: TextStyle(
                          color: const Color(0XFF033A44),
                          fontSize: size.width * 0.06,
                          fontWeight: FontWeight.bold,
                          fontFamily: Constant.haddingFont,
                        ),
                      ),
                      CircularPercentIndicator(
                        radius: 40.0, //size
                        lineWidth: 13.0,
                        percent: 0.35,
                        center: Text(
                          "35%",
                          style: TextStyle(
                            color: const Color(0xFF033A44),
                            fontFamily: Constant.haddingFont,
                            fontWeight: FontWeight.bold,
                            fontSize: 18.0,
                          ),
                        ),
                        // progressColor: const Color(0xFF1690A7),
                        backgroundColor: const Color(0xFFD9D9D9),
                        linearGradient: const LinearGradient(
                          colors: [Color(0xFF1690A7), Color(0xFF033A44)],
                          begin: Alignment.topRight,
                          end: Alignment.bottomLeft,
                        ),
                        animation: true,
                        animateFromLastPercent: true,
                      ),
                    ],
                  ),
                  const SizedBox(height: 20.0),
                  Dropdown(
                    hint: "Your Profession",
                    onChanged: (v) {
                      setState(() {
                        _profession = v!.toLowerCase();
                      });
                      Provider.of<RegisterController>(context, listen: false)
                          .profession = v!.toLowerCase();
                      Provider.of<RegisterController>(context, listen: false)
                          .setErrorMsg({"profession": false});
                    },
                    items: const [
                      "Business",
                      "Service",
                    ],
                    icon: Icons.business_center_outlined,
                  ),
                  ErrorText(
                    text: "Select your Profession",
                    visible: Provider.of<RegisterController>(
                      context,
                      listen: true,
                    ).errMsg['profession']!,
                  ),
                  const SizedBox(height: 20.0),
                  DetailsTextfield(
                    onTap: () {
                      Provider.of<RegisterController>(context, listen: false)
                          .setErrorMsg({"industry": false});
                    },
                    controller: RegisterController.industry,
                    hintText: "Industry",
                    icon: CupertinoIcons.building_2_fill,
                  ),
                  ErrorText(
                    text: "Industry can't be blank",
                    visible: Provider.of<RegisterController>(
                      context,
                      listen: true,
                    ).errMsg['industry']!,
                  ),
                  const SizedBox(height: 20.0),
                  DetailsTextfield(
                    onTap: () {
                      Provider.of<RegisterController>(context, listen: false)
                          .setErrorMsg({"orgnization": false});
                    },
                    controller: RegisterController.orgnization,
                    hintText: "Organization",
                    icon: CupertinoIcons.building_2_fill,
                  ),
                  ErrorText(
                    text: "Organization can't be blank",
                    visible: Provider.of<RegisterController>(
                      context,
                      listen: true,
                    ).errMsg['orgnization']!,
                  ),
                  const SizedBox(height: 20.0),
                  DetailsTextfield(
                    onTap: () {
                      Provider.of<RegisterController>(context, listen: false)
                          .setErrorMsg({"designation": false});
                    },
                    controller: RegisterController.designation,
                    hintText: "Your Designation",
                    icon: Icons.business_center_outlined,
                  ),
                  ErrorText(
                    text: "Designation can't be blank",
                    visible: Provider.of<RegisterController>(
                      context,
                      listen: true,
                    ).errMsg['designation']!,
                  ),
                  const SizedBox(height: 20.0),
                  Dropdown(
                    hint: "Personal Anual Income",
                    onChanged: (v) {
                      Provider.of<RegisterController>(context, listen: false)
                          .anualIncome = v!;
                      Provider.of<RegisterController>(context, listen: false)
                          .setErrorMsg({"anualIncome": false});
                    },
                    items: const [
                      "Under 10 Lakhs",
                      "10 Lakhs and Above",
                      "20 Lakhs and Above",
                      "30 Lakhs and Above",
                      "40 Lakhs and Above",
                    ],
                    icon: Icons.currency_rupee_sharp,
                  ),
                  ErrorText(
                    text: "Select your personal income",
                    visible: Provider.of<RegisterController>(
                      context,
                      listen: true,
                    ).errMsg['anualIncome']!,
                  ),
                  Visibility(
                    visible: _profession == "business" ? true : false,
                    child: Column(
                      children: [
                        const SizedBox(height: 20.0),
                        DetailsTextfield(
                          onTap: () {
                            Provider.of<RegisterController>(context,
                                    listen: false)
                                .setErrorMsg({"turnover": false});
                          },
                          controller: RegisterController.turnover,
                          hintText: "Buisness Turnover",
                          icon: Icons.account_balance_wallet_outlined,
                        ),
                        ErrorText(
                          text: "Business Turnover can't be blank",
                          visible: Provider.of<RegisterController>(
                            context,
                            listen: true,
                          ).errMsg['turnover']!,
                        ),
                      ],
                    ),
                  ),
                  Visibility(
                    visible: _profession == "business" ? true : false,
                    child: Column(
                      children: [
                        const SizedBox(height: 20.0),
                        DetailsTextfield(
                          controller: RegisterController.website,
                          hintText: "Buisness Website",
                          icon: CupertinoIcons.globe,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(
              width: double.infinity,
              child: Image.asset(
                "assets/images/Vector 1.png",
                fit: BoxFit.cover,
              ),
            ),

            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: size.width * 0.05,
                vertical: size.height * 0.02,
              ),
              child: // *********************** BUTTONS ***********************
                  Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const QualificationDetails(),
                          ),
                        );
                      },
                      child: Container(
                        height: 50.0,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30.0),
                          border: Border.all(
                            color: const Color(0xFF033A44),
                            width: 1.5,
                          ),
                        ),
                        child: Center(
                          child: Text(
                            "Back",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                              fontFamily: Constant.subHadding,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 20.0),
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        Provider.of<RegisterController>(
                          context,
                          listen: false,
                        ).workSubmit(context);
                      },
                      child: Container(
                        height: 50.0,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30.0),
                          color: const Color(0xFF033A44),
                        ),
                        child: Center(
                          child: Text(
                            "Submit",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                              fontFamily: Constant.subHadding,
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
    );
  }
}
