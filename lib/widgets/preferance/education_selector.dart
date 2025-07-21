import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../controller/preferance_controller.dart';
import '../../constant.dart';

class EducationSelector extends StatefulWidget {
  const EducationSelector({super.key});

  @override
  State<EducationSelector> createState() => EducationSelectorState();
}

class EducationSelectorState extends State<EducationSelector> {
  List<String> education = ["Any", "School", "Grad", "Post-Grad", "Ph.D"];
  String? selectedEducation;

  @override
  Widget build(BuildContext context) {
    // final size = MediaQuery.of(context);
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20.0),
      decoration: const BoxDecoration(
        color: Color(0xFF033A44),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(40.0),
          bottomLeft: Radius.circular(40.0),
          bottomRight: Radius.circular(40.0),
        ),
      ),
      child: Row(
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
                    ...education.map((age) {
                      return DropdownMenuItem(
                        value: age,
                        child: Text(age.toString()),
                      );
                    }),
                  ],
                  onChanged: (v) {
                    setState(() {
                      selectedEducation = v;
                    });
                    if (selectedEducation != null) {
                      Provider.of<PreferanceController>(
                        context,
                        listen: false,
                      ).nextIndex(4);

                      Provider.of<PreferanceController>(
                        context,
                        listen: false,
                      ).education = selectedEducation!;
                    }
                  },

                  hint: Center(
                    child: Text(
                      selectedEducation != null
                          ? selectedEducation.toString()
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
    );
  }
}
