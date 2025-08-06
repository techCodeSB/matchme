import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../controller/preferance_controller.dart';
import '../../constant.dart';

class FamilybgSelector extends StatefulWidget {
  const FamilybgSelector({super.key});

  @override
  State<FamilybgSelector> createState() => FamilybgSelectorState();
}

class FamilybgSelectorState extends State<FamilybgSelector> {
  List<String> familyBg = ["Any", "Business", "Service"];
  String? selectedfamilyBg;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final familyBg =
          Provider.of<PreferanceController>(context, listen: false).familyBg;
      if (familyBg != "") {
        setState(() {
          selectedfamilyBg = familyBg;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // final size = MediaQuery.of(context);
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
                        ...familyBg.map((age) {
                          return DropdownMenuItem(
                            value: age,
                            child: Text(age.toString()),
                          );
                        }),
                      ],
                      onChanged: (v) {
                        setState(() {
                          selectedfamilyBg = v;
                        });
                        if (selectedfamilyBg != null) {
                          Provider.of<PreferanceController>(
                            context,
                            listen: false,
                          ).familyBg = selectedfamilyBg!;
                        }
                      },

                      hint: Center(
                        child: Text(
                          selectedfamilyBg != null
                              ? selectedfamilyBg.toString()
                              : "Select",
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
                  if (selectedfamilyBg != null) {
                    Provider.of<PreferanceController>(
                      context,
                      listen: false,
                    ).nextIndex(6);
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
