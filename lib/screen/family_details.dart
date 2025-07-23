import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:provider/provider.dart';
import '../controller/register_controller.dart';
import '../screen/personal_sec_details.dart';
import '../widgets/error_text.dart';
import '../constant.dart';
import '../widgets/details_textfield.dart';
import '../widgets/dropdown.dart';
import '../widgets/details_hero.dart';

class FamilyDetails extends StatefulWidget {
  const FamilyDetails({super.key});

  @override
  State<FamilyDetails> createState() => _FamilyDetailsState();
}

class _FamilyDetailsState extends State<FamilyDetails> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Container(
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
                          "Family Details",
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
                          percent: 0.21,
                          center: Text(
                            "21%",
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
                    // ::::::::::::::::::::::::::::::::::::: FORM FIELDS :::::::::::::::::::::::::::::::::::::::
                    const SizedBox(height: 20.0),
                    DetailsTextfield(
                      onTap: () {
                        Provider.of<RegisterController>(context, listen: false)
                            .setErrorMsg({"fathername": false});
                      },
                      controller: RegisterController.fathername,
                      hintText: "Father's name",
                      icon: Icons.person_outline,
                    ),
                    ErrorText(
                      text: "Father's name can't be blank",
                      visible: Provider.of<RegisterController>(
                        context,
                        listen: true,
                      ).errMsg['fathername']!,
                    ),
                    const SizedBox(height: 20.0),
                    Dropdown(
                      hint: "Father's Occupation",
                      onChanged: (v) {
                        RegisterController.fatherOccupation = v!;
                      },
                      items: const [
                        "Business",
                        "Service",
                        "Profession",
                        "N.a."
                      ],
                      icon: Icons.work_outline,
                      defaultValue: RegisterController.fatherOccupation,
                    ),
                    const SizedBox(height: 20.0),
                    DetailsTextfield(
                      onTap: () {
                        Provider.of<RegisterController>(context, listen: false)
                            .setErrorMsg({"mothername": false});
                      },
                      controller: RegisterController.mothername,
                      hintText: "Mother's name",
                      icon: Icons.person_outline,
                    ),
                    ErrorText(
                      text: "Mother's name can't be blank",
                      visible: Provider.of<RegisterController>(
                        context,
                        listen: true,
                      ).errMsg['mothername']!,
                    ),
                    const SizedBox(height: 20.0),
                    Dropdown(
                      hint: "Mother's Occupation",
                      onChanged: (v) {
                        RegisterController.motherOccupation = v!;
                      },
                      items: const [
                        "Business",
                        "Service",
                        "Profession",
                        "Homemaker",
                        "N.a."
                      ],
                      icon: Icons.work_outline,
                      defaultValue: RegisterController.motherOccupation,
                    ),
                    const SizedBox(height: 20.0),
                    Dropdown(
                      hint: "No of Siblings",
                      onChanged: (v) {
                        RegisterController.noOfSibling = v!;
                      },
                      items: const ["0", "1", "2", "3", "3+"],
                      icon: Icons.people_outline,
                      defaultValue: RegisterController.noOfSibling,
                    ),
                    const SizedBox(height: 20.0),
                    Dropdown(
                      hint: "Family Background",
                      onChanged: (v) {
                        RegisterController.familyBackground = v!;
                      },
                      items: const [
                        "Business owners",
                        "Goverment employees",
                        "Private employees",
                        "Self-employed",
                        "Retired",
                        "Others"
                      ],
                      icon: Icons.business_center_outlined,
                      defaultValue: RegisterController.familyBackground,
                    ),
                    const SizedBox(height: 20.0),
                    DetailsTextfield(
                      onTap: () {
                        Provider.of<RegisterController>(context, listen: false)
                            .setErrorMsg({"hometown": false});
                      },
                      controller: RegisterController.hometown,
                      hintText: "Home Town",
                      icon: Icons.location_on_outlined,
                    ),
                    ErrorText(
                      text: "Home Town can't be blank",
                      visible: Provider.of<RegisterController>(
                        context,
                        listen: true,
                      ).errMsg['hometown']!,
                    ),
                    const SizedBox(height: 20.0),
                    Dropdown(
                      hint: "Family Anual Income",
                      onChanged: (v) {
                        RegisterController.familyAnualIncome = v!;
                      },
                      items: const [
                        "> 10L",
                        "> 25L",
                        "> 50L",
                        "> 1Cr",
                        "> 5Cr",
                        "> 10Cr",
                      ],
                      icon: Icons.currency_rupee_sharp,
                      defaultValue: RegisterController.familyAnualIncome,
                    ),
                    const SizedBox(height: 20.0),
                    TextField(
                      controller: RegisterController.familyDescription,
                      onTap: () {
                        Provider.of<RegisterController>(context, listen: false)
                            .setErrorMsg({"description": false});
                      },
                      decoration: InputDecoration(
                        hintText: "Describe your family in your words",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30.0),
                          borderSide: const BorderSide(
                            color: Color(0xFF1690A7),
                            width: 1.0,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30.0),
                          borderSide: const BorderSide(
                            color: Color(0xFF1690A7),
                            width: 1.0,
                          ),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 20.0,
                          vertical: 15.0,
                        ),
                      ),
                      maxLines: 3,
                    ),
                    ErrorText(
                      text: "Description can't be blank",
                      visible: Provider.of<RegisterController>(
                        context,
                        listen: true,
                      ).errMsg['description']!,
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
                // ::::::::::::::::::::::::::::::::::::::::: BUTTONS :::::::::::::::::::::::::::::::::::::::::
                child: Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    const PersonalSecDetails(),
                              ));
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
                                fontSize: 16.0,
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
                          Provider.of<RegisterController>(context,
                                  listen: false)
                              .familySubmit(context);
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
                                fontSize: 16.0,
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
