import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../controller/register_controller.dart';
import '../widgets/error_text.dart';
import '../constant.dart';
import '../widgets/dropdown.dart';
import '../widgets/details_hero.dart';
import '../widgets/details_textfield.dart';

class PersonalFstDetails extends StatefulWidget {
  const PersonalFstDetails({super.key});

  @override
  State<PersonalFstDetails> createState() => _PersonalFstDetailsState();
}

class _PersonalFstDetailsState extends State<PersonalFstDetails> {
  DateTime? selectedDate;

  void _openDatePicker(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),

    );

    if (pickedDate != null) {
      setState(() {
        selectedDate = pickedDate;
      });
      RegisterController.dateOfBirth = pickedDate;
    }
  }

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
                          "Personal Details",
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
                          percent: 0.0,
                          center: Text(
                            "0%",
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
                    // *********************** PERCENTAGE CLOSE ***********************

                    const SizedBox(height: 20.0),
                    DetailsTextfield(
                      controller: RegisterController.fullname,
                      hintText: "Full Name",
                      icon: Icons.person_outline,
                      onTap: () {
                        Provider.of<RegisterController>(context, listen: false)
                            .setErrorMsg({'fullname': false});
                      },
                    ),
                    ErrorText(
                      text: "Full Name can't be blank",
                      visible: Provider.of<RegisterController>(
                        context,
                        listen: true,
                      ).errMsg['fullname']!,
                    ),

                    const SizedBox(height: 20.0),
                    DetailsTextfield(
                      controller: RegisterController.nickname,
                      hintText: "Nickname",
                      icon: Icons.person_outline,
                    ),

                    const SizedBox(height: 20.0),
                    Dropdown(
                      hint: "Gender",
                      onChanged: (v) {
                        RegisterController.gender = v!.toLowerCase();
                        Provider.of<RegisterController>(context, listen: false)
                            .setErrorMsg({'gender': false});
                      },
                      items: const [
                        "Male",
                        "Female",
                      ],
                      icon: Icons.person_outline,
                    ),
                    ErrorText(
                      text: "Gender can't be blank",
                      visible: Provider.of<RegisterController>(
                        context,
                        listen: true,
                      ).errMsg['gender']!,
                    ),
                    const SizedBox(height: 20.0),
                    InkWell(
                      onTap: () => _openDatePicker(context),
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(10.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30.0),
                          border: Border.all(color: const Color(0xFF1690A7)),
                        ),
                        child: Row(
                          children: [
                            const Icon(Icons.date_range_outlined),
                            const SizedBox(width: 10.0),
                            Text(
                              selectedDate != null
                                  ? DateFormat("dd-MM-yyyy")
                                      .format(selectedDate!)
                                      .toString()
                                  : "Date of birth",
                              style: const TextStyle(
                                fontSize: 14.0,
                                fontWeight: FontWeight.w500,
                                color: Color(0xFF0C5461),
                              ),
                            )
                          ],
                        ),
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
              // *********************** BUTTONS ***********************
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: size.width * 0.05,
                  vertical: size.height * 0.02,
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 50.0,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30.0),
                          border: Border.all(
                            color: const Color(0xFF033A44),
                            width: 2.0,
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
                    const SizedBox(width: 20.0),
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          Provider.of<RegisterController>(
                            context,
                            listen: false,
                          ).personalFstSubmit(context);
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
              )
            ],
          ),
        ),
      ),
    );
  }
}
