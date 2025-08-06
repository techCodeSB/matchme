import 'package:flutter/material.dart';
import '../../controller/preferance_controller.dart';
import 'package:provider/provider.dart';
import '../../constant.dart';

class AgeSelector extends StatefulWidget {
  const AgeSelector({super.key});

  @override
  State<AgeSelector> createState() => AgeSelectorState();
}

class AgeSelectorState extends State<AgeSelector> {
  List<int> ages = List.generate(24, (index) => index + 21);
  int? fromAge = 0;
  int? toAge = 0;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final agePref =
          Provider.of<PreferanceController>(context, listen: false).agePref;
      if (agePref.isNotEmpty) {
        setState(() {
          fromAge = int.tryParse(agePref["from"] ?? '0') ?? 0;
          toAge = int.tryParse(agePref["to"] ?? '0') ?? 0;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
      decoration: const BoxDecoration(
        color: Color(0xFF033A44),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(40.0),
          bottomLeft: Radius.circular(40.0),
          bottomRight: Radius.circular(40.0),
        ),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 25.0),
                child: Text(
                  "From (Year)",
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: Constant.subHadding,
                    fontWeight: FontWeight.bold,
                    fontSize: 18.0,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 40.0),
                child: Text(
                  "To (Year)",
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: Constant.subHadding,
                    fontWeight: FontWeight.bold,
                    fontSize: 18.0,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton(
                      isExpanded: true, //for center a hint text + center widget
                      menuMaxHeight: 250.0,
                      items: [
                        ...ages.map((age) {
                          return DropdownMenuItem(
                            value: age,
                            child: Text(age.toString()),
                          );
                        }),
                      ],
                      onChanged: (v) {
                        // Ensure that the 'from' age is not greater than the 'to' age
                        if (v! < toAge!) {
                          setState(() {
                            fromAge = v;
                          });
                        } else if (toAge == 0) {
                          setState(() {
                            fromAge = v;
                          });
                        }
                        if (fromAge! > 0 && toAge! > 0) {
                          Provider.of<PreferanceController>(context,
                                  listen: false)
                              .agePref = {
                            "from": fromAge.toString(),
                            "to": toAge.toString()
                          };
                        }
                      },

                      hint: Center(
                        child: Text(
                          fromAge != 0 ? fromAge.toString() : "Select",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: const Color(0xFF0C5461),
                            fontFamily: Constant.subHadding,
                            fontSize: 18.0,
                          ),
                        ),
                      ),
                      icon: const Text(""),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 20.0),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton(
                      isExpanded: true, //for center a hint text + center widget
                      menuMaxHeight: 250.0,
                      items: [
                        ...ages.map((age) {
                          return DropdownMenuItem(
                            value: age,
                            child: Text(age.toString()),
                          );
                        }),
                      ],
                      onChanged: (v) {
                        // Ensure that the 'to' age is not less than the 'from' age
                        if (v! > fromAge!) {
                          setState(() {
                            toAge = v;
                          });
                        }
                        if (fromAge! > 0 && toAge! > 0) {
                          Provider.of<PreferanceController>(context,
                                  listen: false)
                              .agePref = {
                            "from": fromAge.toString(),
                            "to": toAge.toString()
                          };
                        }
                      },
                      hint: Center(
                        child: Text(
                          toAge != 0 ? toAge.toString() : "Select",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: const Color(0xFF0C5461),
                            fontFamily: Constant.subHadding,
                            fontSize: 18.0,
                          ),
                        ),
                      ),
                      icon: const Text(""),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: Align(
              alignment: Alignment.centerRight,
              child: MaterialButton(
                onPressed: () {
                  if (fromAge! > 0 && toAge! > 0) {
                    Provider.of<PreferanceController>(
                      context,
                      listen: false,
                    ).nextIndex(0);
                  }
                },
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0)),
                color: Colors.white,
                child: const Text("Next"),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
