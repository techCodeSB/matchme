import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../controller/preferance_controller.dart';
import '../../constant.dart';

class HeightSelector extends StatefulWidget {
  const HeightSelector({super.key});

  @override
  State<HeightSelector> createState() => HeightSelectorState();
}

class HeightSelectorState extends State<HeightSelector> {
  List<int> inch = [4, 5, 6, 7];
  List<int> feet = List.generate(11, (index) => index);
  int? selectedInch;
  int? selectedFeet;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final height =
          Provider.of<PreferanceController>(context, listen: false).height;
      if (height != "") {
        setState(() {
          selectedFeet = int.parse(height.split(".")[0]);
          selectedInch = int.parse(height.split(".")[1]);
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
              Padding(
                padding: const EdgeInsets.only(left: 25.0),
                child: Text(
                  "Feet",
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
                  "Inch",
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
                        ...inch.map((i) {
                          return DropdownMenuItem(
                            value: i,
                            child: Text(i.toString()),
                          );
                        }),
                      ],
                      onChanged: (v) {
                        setState(() {
                          selectedInch = v;
                        });
                        if (selectedInch != null && selectedFeet != null) {
                          Provider.of<PreferanceController>(context,
                                      listen: false)
                                  .height =
                              "${selectedFeet.toString()}.${selectedInch.toString()}";
                        }
                      },

                      hint: Center(
                        child: Text(
                          selectedInch != null
                              ? selectedInch.toString()
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
                        ...feet.map((age) {
                          return DropdownMenuItem(
                            value: age,
                            child: Text(age.toString()),
                          );
                        }),
                      ],
                      onChanged: (v) {
                        setState(() {
                          selectedFeet = v;
                        });
                        if (selectedInch != null && selectedFeet != null) {
                          Provider.of<PreferanceController>(context,
                                      listen: false)
                                  .height =
                              "${selectedFeet.toString()}.${selectedInch.toString()}";
                        }
                      },

                      hint: Center(
                        child: Text(
                          selectedFeet != null
                              ? selectedFeet.toString()
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
                  if (selectedInch != null && selectedFeet != null) {
                    Provider.of<PreferanceController>(
                      context,
                      listen: false,
                    ).nextIndex(2);
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
