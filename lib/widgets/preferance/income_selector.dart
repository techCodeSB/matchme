import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../controller/preferance_controller.dart';
import '../../constant.dart';

class IncomeSelector extends StatefulWidget {
  const IncomeSelector({super.key});

  @override
  State<IncomeSelector> createState() => IncomeSelectorState();
}

class IncomeSelectorState extends State<IncomeSelector> {
  List<String> education = [
    "Any",
    "Under 10 Lakhs",
    "10 Lakhs and Above",
    "20 Lakhs and Above",
    "30 Lakhs and Above",
    "40 Lakhs and Above",
    "50 Lakhs and Above",
    "60 Lakhs and Above",
    "70 Lakhs and Above",
    "80 Lakhs and Above",
    "90 Lakhs and Above",
    "1 Crore and Above",
    "5 Crore and Above",
  ];
  String? selectedIncome;

  @override
  Widget build(BuildContext context) {
    // final size = MediaQuery.of(context);
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(10.0),
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
                      selectedIncome = v;
                    });
                    if (selectedIncome != null) {
                      Provider.of<PreferanceController>(
                        context,
                        listen: false,
                      ).nextIndex(8);

                      Provider.of<PreferanceController>(
                        context,
                        listen: false,
                      ).personalIncome = selectedIncome!;
                    }
                  },

                  hint: Center(
                    child: Text(
                      selectedIncome != null
                          ? selectedIncome.toString()
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
