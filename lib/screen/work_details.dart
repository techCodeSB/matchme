import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:matchme/widgets/registration_bottom_buttons.dart';
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
  void initState() {
    super.initState();
    _profession = RegisterController.profession;
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(size.height * 0.3),
        child: DetailsHero(
          size: size,
        ),
      ),
      body: Container(
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
                  // ::::::::::::::::::::::::::::::::::::::::: FORM FIELDS ::::::::::::::::::::::::::::::::::::::::::
                  Dropdown(
                    hint: "Nature of Work",
                    onChanged: (v) {
                      setState(() {
                        _profession = v!;
                      });
                      RegisterController.profession = v!;
                      Provider.of<RegisterController>(context, listen: false)
                          .setErrorMsg({"profession": false});
                    },
                    items: const ["Business", "Service", "Profession"],
                    icon: Icons.business_center_outlined,
                    defaultValue: RegisterController.profession,
                    onClear: () {
                      RegisterController.profession = "";
                      setState(() {
                        _profession = "";
                      });
                    },
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
                      RegisterController.anualIncome = v!;
                      Provider.of<RegisterController>(context, listen: false)
                          .setErrorMsg({"anualIncome": false});
                    },
                    items: const [
                      "Under 10 Lakhs",
                      "10 Lakhs and Above",
                      "20 Lakhs and Above",
                      "30 Lakhs and Above",
                      "50 Lakhs and Above",
                      "60 Lakhs and Above",
                      "70 Lakhs and Above",
                      "80 Lakhs and Above",
                      "90 Lakhs and Above",
                      "1 Cr and Above",
                      "5 Cr and Above",
                    ],
                    icon: Icons.currency_rupee_sharp,
                    defaultValue: RegisterController.anualIncome,
                  ),
                  ErrorText(
                    text: "Select your personal income",
                    visible: Provider.of<RegisterController>(
                      context,
                      listen: true,
                    ).errMsg['anualIncome']!,
                  ),
                  Visibility(
                    visible: _profession == "Business" ? true : false,
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
                    visible: _profession == "Business" ? true : false,
                    child: Column(
                      children: [
                        const SizedBox(height: 20.0),
                        DetailsTextfield(
                          onTap: () {
                            Provider.of<RegisterController>(context,
                                    listen: false)
                                .setErrorMsg({"website": false});
                          },
                          controller: RegisterController.website,
                          hintText: "Buisness Website",
                          icon: CupertinoIcons.globe,
                        ),
                        ErrorText(
                          text: "Business website can't be blank",
                          visible: Provider.of<RegisterController>(
                            context,
                            listen: true,
                          ).errMsg['website']!,
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
            const SizedBox(height: 100.0),
          ],
        ),
      ),
      bottomSheet: RegistrationBottomButtons(
        onNextTap: () {
          Provider.of<RegisterController>(
            context,
            listen: false,
          ).workSubmit(context);
        },
        onBackTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const QualificationDetails(),
            ),
          );
        },
      ),
    );
  }
}
