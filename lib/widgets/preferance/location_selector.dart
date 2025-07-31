import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../controller/preferance_controller.dart';
import '../../constant.dart';

class LocationSelector extends StatefulWidget {
  const LocationSelector({super.key});

  @override
  State<LocationSelector> createState() => LocationSelectorState();
}

class LocationSelectorState extends State<LocationSelector> {
  List<String> location = ["Any where", "India", "Abroad"];
  String? selectedlocation;



  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final location = Provider.of<PreferanceController>(context, listen: false)
          .location;
      setState(() {
        selectedlocation = location;
      });
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
                        ...location.map((age) {
                          return DropdownMenuItem(
                            value: age,
                            child: Text(age.toString()),
                          );
                        }),
                      ],
                      onChanged: (v) {
                        setState(() {
                          selectedlocation = v;
                        });
                        if (selectedlocation != null) {
                          Provider.of<PreferanceController>(
                            context,
                            listen: false,
                          ).location = selectedlocation!;

                          Provider.of<PreferanceController>(
                            context,
                            listen: false,
                          ).scrollToBottom();
                        }
                      },

                      hint: Center(
                        child: Text(
                          selectedlocation != null
                              ? selectedlocation.toString()
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
                  if (selectedlocation != null) {
                    Provider.of<PreferanceController>(
                      context,
                      listen: false,
                    ).setIsDone();
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
