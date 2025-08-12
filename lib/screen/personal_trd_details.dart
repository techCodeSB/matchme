import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:matchme/screen/personal_sec_details.dart';
import 'package:matchme/widgets/my_snackbar.dart';
import 'package:matchme/widgets/registration_bottom_buttons.dart';
import 'package:percent_indicator/percent_indicator.dart';
import '../controller/register_controller.dart';
import 'package:provider/provider.dart';
import '../constant.dart';
import '../widgets/dropdown.dart';
import '../widgets/details_hero.dart';
import '../widgets/details_textfield.dart';
import '../widgets/radio.dart' as my_radio;
import '../widgets/error_text.dart';
import 'package:icons_plus/icons_plus.dart';

class PersonalTrdDetails extends StatefulWidget {
  const PersonalTrdDetails({super.key});

  @override
  State<PersonalTrdDetails> createState() => _PersonalTrdDetailsState();
}

class _PersonalTrdDetailsState extends State<PersonalTrdDetails> {
  bool dontDisplayProfile = false;
  DateTime? fromYear;
  DateTime? toYear;
  String maritalStatus = "Never Married";

  void _openDatePicker(BuildContext context, which) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: (which == "from" ? fromYear : toYear) ?? DateTime.now(),
      firstDate: DateTime(1985),
      lastDate: DateTime.now(),
      initialDatePickerMode: DatePickerMode.year,
    );

    if (pickedDate != null) {
      setState(() {
        if (which == "from") {
          if (toYear != null && pickedDate.year > toYear!.year) {
            mySnackBar(context, "Invalid years select");
            return;
          }
          fromYear = pickedDate;
          RegisterController.fromMaritalStatusYear = pickedDate.year.toString();
        } else {
          if (fromYear != null && pickedDate.year < fromYear!.year) {
            mySnackBar(context, "Invalid years select");
            return;
          }
          toYear = pickedDate;
          RegisterController.toMaritalStatusYear = pickedDate.year.toString();
        }
      });
    }
  }

  @override
  void initState() {
    super.initState();
    if (RegisterController.maritalStatus != "") {
      maritalStatus = RegisterController.maritalStatus;
    }

    if (RegisterController.fromMaritalStatusYear != "" &&
        RegisterController.toMaritalStatusYear != "") {
      fromYear = DateTime(int.parse(RegisterController.fromMaritalStatusYear));
      toYear = DateTime(int.parse(RegisterController.toMaritalStatusYear));
    }

    dontDisplayProfile = RegisterController.showWeightOnProfile;
  }

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
                          percent: 0.14,
                          center: Text(
                            "14%",
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
                    const SizedBox(height: 20.0),
                    DetailsTextfield(
                      type: TextInputType.phone,
                      controller: RegisterController.whatsappNumber,
                      hintText: "Whatsapp No. (+9194XXX, +143XXX)",
                      icon: FontAwesome.whatsapp_brand,
                      onTap: () {
                        Provider.of<RegisterController>(context, listen: false)
                            .setErrorMsg({'whatsappNumber': false});
                      },
                    ),
                    ErrorText(
                      text:
                          "Only numbers and +symbol allowed (no space, (),-)Ex. (+919876543210, +143890999909)",
                      visible:
                          Provider.of<RegisterController>(context, listen: true)
                              .errMsg['whatsappNumber']!,
                    ),
                    const SizedBox(height: 20.0),
                    Row(
                      children: [
                        Flexible(
                          flex: 1,
                          child: Dropdown(
                            hint: "Height (Feet)",
                            onChanged: (v) {
                              RegisterController.heightFeet = v!;
                              Provider.of<RegisterController>(context,
                                      listen: false)
                                  .setErrorMsg(
                                {'height': false},
                              );
                            },
                            items: const ["4", "5", "6", "7"],
                            icon: Icons.height_rounded,
                            onClear: () {
                              RegisterController.heightFeet = "";
                            },
                            defaultValue: RegisterController.heightFeet,
                          ),
                        ),
                        const SizedBox(width: 20.0),
                        Flexible(
                          flex: 1,
                          child: Dropdown(
                            hint: "Height (Inch.)",
                            onChanged: (v) {
                              RegisterController.heightInch = v!;
                              Provider.of<RegisterController>(context,
                                      listen: false)
                                  .setErrorMsg({'height': false});
                            },
                            items: const [
                              "0",
                              "1",
                              "2",
                              "3",
                              "4",
                              "5",
                              "6",
                              "7",
                              "8",
                              "9",
                              "10",
                              "11",
                            ],
                            icon: Icons.height_rounded,
                            onClear: () {
                              RegisterController.heightInch = "";
                            },
                            defaultValue: RegisterController.heightInch,
                          ),
                        ),
                      ],
                    ),
                    ErrorText(
                      text: "Height can't be blank",
                      visible:
                          Provider.of<RegisterController>(context, listen: true)
                              .errMsg['height']!,
                    ),
                    const SizedBox(height: 20.0),
                    Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: DetailsTextfield(
                            type: TextInputType.number,
                            controller: RegisterController.weight,
                            hintText: "Weight",
                            icon: FontAwesome.weight_scale_solid,
                            onTap: () {
                              Provider.of<RegisterController>(context,
                                      listen: false)
                                  .setErrorMsg({'weight': false});
                            },
                          ),
                        ),
                        const SizedBox(width: 20.0),
                        Expanded(
                          flex: 1,
                          child: Dropdown(
                            hint: "Unit",
                            onChanged: (v) {
                              RegisterController.weightUnit = v!;
                              Provider.of<RegisterController>(context,
                                      listen: false)
                                  .setErrorMsg({'weightUnit': false});
                            },
                            items: const ["Kgs", "lbs"],
                            icon: FontAwesome.weight_scale_solid,
                            onClear: () {
                              RegisterController.weightUnit = "";
                            },
                            defaultValue: RegisterController.weightUnit,
                          ),
                        )
                      ],
                    ),
                    ErrorText(
                      text: "Weight and unit can't be blank",
                      visible: Provider.of<RegisterController>(context,
                                  listen: true)
                              .errMsg['weight']! ||
                          Provider.of<RegisterController>(context, listen: true)
                              .errMsg['weightUnit']!,
                    ),
                    const SizedBox(height: 5.0),
                    Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.zero,
                          child: Checkbox(
                            fillColor: WidgetStateProperty.resolveWith<Color>(
                                (Set<WidgetState> states) {
                              if (states.contains(WidgetState.disabled)) {
                                return Colors.white;
                              }
                              return Constant.highlightColor;
                            }),
                            value: dontDisplayProfile,
                            onChanged: (v) {
                              setState(() {
                                dontDisplayProfile = v!;
                              });
                              RegisterController.showWeightOnProfile =
                                  dontDisplayProfile;
                            },
                            visualDensity: VisualDensity.compact,
                            materialTapTargetSize:
                                MaterialTapTargetSize.shrinkWrap,
                          ),
                        ),
                        const Text("Don't display on my profile"),
                      ],
                    ),
                    // const SizedBox(height: 10.0),
                    my_radio.Radio(
                      title: "Tell us about your eating preferences?",
                      items: const ["Veg", "Non-Veg", "Vegan"],
                      onChanged: (v) {
                        RegisterController.eatingPref = v!;
                        Provider.of<RegisterController>(context, listen: false)
                            .setErrorMsg({"eatingPref": false});
                      },
                      defaultValue: RegisterController.eatingPref,
                    ),
                    ErrorText(
                      text: "Eating Preferance can't be blank",
                      visible:
                          Provider.of<RegisterController>(context, listen: true)
                              .errMsg['eatingPref']!,
                    ),
                    const SizedBox(height: 20.0),
                    Dropdown(
                      hint: "Marital Status",
                      onChanged: (v) {
                        RegisterController.maritalStatus = v!;
                        Provider.of<RegisterController>(context, listen: false)
                            .setErrorMsg({'maritalStatus': false});
                        setState(() {
                          maritalStatus = v;
                        });
                      },
                      items: const ["Never Married", "Divorced", "Widowed"],
                      icon: Icons.person_outline,
                      defaultValue: RegisterController.maritalStatus,
                      onClear: () {
                        RegisterController.maritalStatus = "";
                        setState(() {
                          maritalStatus = "Never Married";
                        });
                      },
                    ),
                    ErrorText(
                      text: "Marital Status can't be blank",
                      visible:
                          Provider.of<RegisterController>(context, listen: true)
                              .errMsg['maritalStatus']!,
                    ),
                    const SizedBox(height: 20.0),
                    Visibility(
                      visible: maritalStatus != "Never Married" ? true : false,
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: InkWell(
                                  onTap: () {
                                    Provider.of<RegisterController>(context,
                                            listen: false)
                                        .setErrorMsg({'dob': false});
                                    _openDatePicker(context, "from");
                                  },
                                  child: Container(
                                    width: double.infinity,
                                    padding: const EdgeInsets.all(10.0),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(30.0),
                                      border: Border.all(
                                          color: const Color(0xFF1690A7)),
                                    ),
                                    child: Row(
                                      children: [
                                        const Icon(Icons.date_range_outlined),
                                        const SizedBox(width: 10.0),
                                        Text(
                                          fromYear != null
                                              ? DateFormat("yyyy")
                                                  .format(fromYear!)
                                                  .toString()
                                              : "From Years",
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
                              ),
                              const SizedBox(width: 20.0),
                              Expanded(
                                child: InkWell(
                                  onTap: () {
                                    Provider.of<RegisterController>(context,
                                            listen: false)
                                        .setErrorMsg(
                                            {'fromMaritalStatus': false});
                                    Provider.of<RegisterController>(context,
                                            listen: false)
                                        .setErrorMsg(
                                            {'toMaritalStatus': false});
                                    _openDatePicker(context, "to");
                                  },
                                  child: Container(
                                    width: double.infinity,
                                    padding: const EdgeInsets.all(10.0),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(30.0),
                                      border: Border.all(
                                          color: const Color(0xFF1690A7)),
                                    ),
                                    child: Row(
                                      children: [
                                        const Icon(Icons.date_range_outlined),
                                        const SizedBox(width: 10.0),
                                        Text(
                                          toYear != null
                                              ? DateFormat("yyyy")
                                                  .format(toYear!)
                                                  .toString()
                                              : "To Years",
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
                              ),
                            ],
                          ),
                          ErrorText(
                            text: "Select From and To years",
                            visible: Provider.of<RegisterController>(context,
                                        listen: true)
                                    .errMsg['fromMaritalStatus']! ||
                                Provider.of<RegisterController>(context,
                                        listen: true)
                                    .errMsg['toMaritalStatus']!,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20.0),
                    Visibility(
                      visible: maritalStatus != "Never Married" ? true : false,
                      child: Column(
                        children: [
                          my_radio.Radio(
                            title: "Do you have kids?",
                            items: const [
                              "Yes",
                              "No",
                            ],
                            onChanged: (v) {
                              RegisterController.doYouHaveKids = v!;
                              Provider.of<RegisterController>(context,
                                      listen: false)
                                  .setErrorMsg({"haveKids": false});
                            },
                            defaultValue: RegisterController.doYouHaveKids,
                          ),
                          ErrorText(
                            text: "require this field",
                            visible: Provider.of<RegisterController>(context,
                                    listen: true)
                                .errMsg['haveKids']!,
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
      ),
      bottomSheet: RegistrationBottomButtons(
        onNextTap: () {
          Provider.of<RegisterController>(
            context,
            listen: false,
          ).personalTrdSubmit(context);
        },
        onBackTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const PersonalSecDetails(),
            ),
          );
        },
      ),
    );
  }
}
