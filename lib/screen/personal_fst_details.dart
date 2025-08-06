import 'package:flutter/material.dart';
import 'package:matchme/widgets/registration_bottom_buttons.dart';
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
  TimeOfDay? selectedTime;

  String formatTime(TimeOfDay time) {
    final now = DateTime.now(); // today's date
    final dt = DateTime(now.year, now.month, now.day, time.hour, time.minute);
    return DateFormat('hh:mm a').format(dt); // e.g., 04:30 PM
  }

  void _openDatePicker(BuildContext context) async {
    final DateTime now = DateTime.now();
    final DateTime maxDate = DateTime(now.year - 18); // youngest: 18 years old
    final DateTime minDate = DateTime(now.year - 54); // oldest: 54 years old

    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedDate != null
          ? selectedDate!
          : maxDate, // default to max eligible age
      firstDate: minDate,
      lastDate: maxDate,
    );

    if (pickedDate != null) {
      setState(() {
        selectedDate = pickedDate;
      });
      RegisterController.dateOfBirth = pickedDate;
    }
  }

  Future<void> _openTimePicker(BuildContext context) async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: selectedTime ?? TimeOfDay.now(),
    );

    if (pickedTime != null && pickedTime != selectedTime) {
      final now = DateTime.now();
      final dt = DateTime(
          now.year, now.month, now.day, pickedTime.hour, pickedTime.minute);
      final time = DateFormat('HH:mm').format(dt);
      RegisterController.timeOfBirth = time;

      setState(() {
        selectedTime = pickedTime;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    selectedDate = RegisterController.dateOfBirth;

    if (selectedDate != null) {
      int hour = int.parse(RegisterController.timeOfBirth!.split(":")[0]);
      int minute = int.parse(RegisterController.timeOfBirth!.split(":")[1]);
      selectedTime = TimeOfDay(hour: hour, minute: minute);
    }
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
      body: SafeArea(
        child: Container(
          width: double.infinity,
          height: double.infinity,
          color: Colors.white,
          child: ListView(
            children: [
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
                      text: "Full name can't be blank",
                      visible: Provider.of<RegisterController>(
                        context,
                        listen: true,
                      ).errMsg['fullname']!,
                    ),

                    const SizedBox(height: 20.0),
                    DetailsTextfield(
                      controller: RegisterController.nickname,
                      hintText: "Your Nickname",
                      icon: Icons.person_outline,
                    ),

                    const SizedBox(height: 20.0),
                    Dropdown(
                      hint: "Gender",
                      onChanged: (v) {
                        RegisterController.gender = v!;
                        Provider.of<RegisterController>(context, listen: false)
                            .setErrorMsg({'gender': false});
                      },
                      items: const ["Male", "Female", "Other"],
                      icon: Icons.person_outline,
                      defaultValue: RegisterController.gender,
                      onClear: () {
                        RegisterController.gender = "";
                      },
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
                      onTap: () {
                        Provider.of<RegisterController>(context, listen: false)
                            .setErrorMsg({'dob': false});
                        _openDatePicker(context);
                      },
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
                    ErrorText(
                      text: "Date of birth can't be blank",
                      visible: Provider.of<RegisterController>(
                        context,
                        listen: true,
                      ).errMsg['dob']!,
                    ),

                    const SizedBox(height: 20.0),
                    InkWell(
                      onTap: () {
                        _openTimePicker(context);
                      },
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(10.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30.0),
                          border: Border.all(color: const Color(0xFF1690A7)),
                        ),
                        child: Row(
                          children: [
                            const Icon(Icons
                                .access_time), // icon changed to match time
                            const SizedBox(width: 10.0),
                            Text(
                              selectedTime != null
                                  ? formatTime(selectedTime!)
                                  : "Time of Birth",
                              style: const TextStyle(
                                fontSize: 14.0,
                                fontWeight: FontWeight.w500,
                                color: Color(0xFF0C5461),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 20.0),
                    DetailsTextfield(
                      controller: RegisterController.placeOfBirth,
                      hintText: "Place of Birth",
                      icon: Icons.person_outline,
                      onTap: () {
                        Provider.of<RegisterController>(context, listen: false)
                            .setErrorMsg({'birthPlace': false});
                      },
                    ),
                    ErrorText(
                      text: "Place of birth can't be blank",
                      visible: Provider.of<RegisterController>(
                        context,
                        listen: true,
                      ).errMsg['birthPlace']!,
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
      ),
      bottomSheet: RegistrationBottomButtons(
        onNextTap: () {
          Provider.of<RegisterController>(
            context,
            listen: false,
          ).personalFstSubmit(context);
        },
        isBack: false,
      ),
    );
  }
}
