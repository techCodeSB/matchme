import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../controller/preferance_controller.dart';


class RelegionSelector extends StatefulWidget {
  const RelegionSelector({super.key});

  @override
  State<RelegionSelector> createState() => _RelegionSelectorState();
}

class _RelegionSelectorState extends State<RelegionSelector> {
  final List<String> religionOptions = [
    "Hindu",
    "Sikh",
    "Christian",
    "Jain",
    "Buddhist",
    "Muslim",
  ];

  List<String> selectedReligions = [];

  void toggleReligion(String religion) {
    setState(() {
      if (selectedReligions.contains(religion)) {
        selectedReligions.remove(religion);
      } else {
        selectedReligions.add(religion);
      }
    });
  }

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final relegion = Provider.of<PreferanceController>(context, listen: false)
          .relegion;
      setState(() {
        selectedReligions = relegion;
      });
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
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(15.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(30.0),
            ),
            child: Center(
              child: Wrap(
                spacing: 10.0,
                runSpacing: 10.0,
                children: religionOptions.map((religion) {
                  final isSelected = selectedReligions.contains(religion);
                  return FilterChip(
                    label: Text(religion),
                    selected: isSelected,
                    onSelected: (_) => toggleReligion(religion),
                    selectedColor: const Color(0xFF1690A7),
                    backgroundColor: Colors.grey[200],
                    checkmarkColor: Colors.white,
                    labelStyle: TextStyle(
                      color: isSelected ? Colors.white : Colors.black,
                      fontWeight: FontWeight.w600,
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
          const SizedBox(height: 5.0),
          Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: Align(
              alignment: Alignment.topRight,
              child: MaterialButton(
                onPressed: () {
                  Provider.of<PreferanceController>(
                    context,
                    listen: false,
                  ).nextIndex(12);
            
                  Provider.of<PreferanceController>(
                    context,
                    listen: false,
                  ).relegion = selectedReligions;
                },
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0)
                ),
                child: const Text(
                  "Next",
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
