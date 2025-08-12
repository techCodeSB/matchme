import 'package:flutter/material.dart';
import 'package:matchme/constant.dart';
import 'package:matchme/controller/profile_controller.dart';
import 'package:matchme/controller/psychometric_controller.dart';
import 'package:matchme/widgets/details_hero.dart';
import 'package:matchme/widgets/my_snackbar.dart';
import 'package:provider/provider.dart';

class Psychometric extends StatefulWidget {
  const Psychometric({super.key});

  @override
  State<Psychometric> createState() => _PsychometricState();
}

class _PsychometricState extends State<Psychometric> {
  int activeIndex = 0;
  String activeId = "";
  Map<int, String> selectedAnswers = {};

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    var allData =
        Provider.of<PsychometricController>(context, listen: true).qaData;

    if (allData == null || allData.isEmpty) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    var qaData = allData[activeIndex];
    activeId = selectedAnswers[activeIndex] ?? "";

    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('Psychometric'),
      //   centerTitle: true,
      // ),
      body: Container(
        width: double.infinity,
        color: Colors.white,
        child: ListView(
          children: [
            DetailsHero(size: size),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: size.width * 0.05,
                vertical: size.height * 0.01,
              ),
              child: Text(
                "${qaData['question']}",
                style: TextStyle(
                  fontFamily: Constant.subHadding,
                  fontSize: 30.0,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF033A44),
                ),
              ),
            ),
            SizedBox(height: size.height * 0.02),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Wrap(
                spacing: 8,
                runSpacing: 20,
                children: qaData['options'].map<Widget>((op) {
                  final isSelected = activeId == op["answer"];
                  return InkWell(
                    onTap: () {
                      setState(() {
                        selectedAnswers[activeIndex] = op["answer"];
                        activeId = op["answer"];
                      });
                    },
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 15.0),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? Constant.highlightColor
                            : const Color(0xFFD8F9FF),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            child: Text(
                              op['answer'],
                              overflow: TextOverflow.clip,
                              style: TextStyle(
                                fontSize: 17,
                                fontFamily: Constant.subHadding,
                                color: isSelected
                                    ? Colors.white
                                    : const Color(0xFF033A44),
                              ),
                            ),
                          ),
                          isSelected
                              ? const Icon(
                                  Icons.check_circle,
                                  color: Colors.white,
                                )
                              : const SizedBox.shrink(),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
            const SizedBox(height: 30.0),
            SizedBox(
              width: double.infinity,
              child: Image.asset(
                "assets/images/Vector 1.png",
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 80.0),
          ],
        ),
      ),
      bottomSheet: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: size.width * 0.05,
          vertical: size.height * 0.02,
        ),
        child: Row(
          children: [
            activeIndex > 0
                ? Expanded(
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          if (activeIndex > 0) {
                            activeIndex--;
                          }
                        });
                      },
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
                            "Previous",
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
                  )
                : const SizedBox.shrink(),
            SizedBox(width: activeIndex > 0 ? 20.0 : 0.0),
            Expanded(
              child: InkWell(
                onTap: () async {
                  if (activeId.isEmpty) return;

                  if (activeIndex < allData.length - 1) {
                    Provider.of<PsychometricController>(context, listen: false)
                        .nextCall(activeIndex, activeId);

                    setState(() {
                      activeIndex++;
                    });
                  } else {
                    await Provider.of<PsychometricController>(context,
                            listen: false)
                        .submit(activeIndex, activeId);

                    // showDialog(
                    //   context: context,
                    //   builder: (context) => AlertDialog(
                    //     title: const Text("Submitted"),
                    //     content:
                    //         const Text("Your answers have been submitted."),
                    //     actions: [
                    //       TextButton(
                    //         onPressed: () {
                    //           Provider.of<ProfileController>(context, listen: false).getUserData(context);
                    //           Navigator.pop(context); //Close Popup;
                    //           Navigator.pop(context); //Back to Dashboard;
                    //         },
                    //         child: const Text("OK"),
                    //       )
                    //     ],
                    //   ),
                    // );

                    mySnackBar(context, "Your answers have been submitted.");
                    Provider.of<ProfileController>(context, listen: false).getUserData(context);
                    Navigator.pop(context); //Close Popup;
                    Navigator.pop(context); //Back to Dashboard;
                  }
                },
                child: Container(
                  height: 50.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30.0),
                    color: activeId.isEmpty
                        ? Colors.grey
                        : const Color(0xFF033A44),
                  ),
                  child: Center(
                    child: Text(
                      activeIndex == allData.length - 1 ? "Submit" : "Next",
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
      ),
    );
  }
}
