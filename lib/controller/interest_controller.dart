import 'dart:async';

import 'package:flutter/material.dart';

class InterestController extends ChangeNotifier {
  bool snap = false;
  String swipeDirection = "none"; // "left", "right", "up"
  bool isLovesSymbolRed = false;
  List<String> stackData = [
    "http://13.203.218.134:1337/uploads/testimonial_2_2ad2cab837.png",
    "http://13.203.218.134:1337/uploads/Cancer_Care_F_Image_a80443046f.jpg",
    "http://13.203.218.134:1337/uploads/Obstetrics_and_Gynecology_F_Image_43c3d6cae1.jpg",
    "http://13.203.218.134:1337/uploads/testimonial_3_1f50ddc0a5.png",
  ];

  List<String> newData = [
    "http://13.203.218.134:1337/uploads/test_1_7f8edbceb1.png",
    "http://13.203.218.134:1337/uploads/testimonial_4_1fa56045f8.png",
    "http://13.203.218.134:1337/uploads/3_cosmetic_dentistry_procedures_you_did_not_know_about_9529ab5fb0.jpg",
    "http://13.203.218.134:1337/uploads/17_4_things_you_need_to_know_about_eye_yoga_today_1c125ada85.jpg"
  ];

  void setIsLovesSymbolRed() {
    isLovesSymbolRed = true;
    notifyListeners();

    Timer(const Duration(milliseconds: 1300), () {
      isLovesSymbolRed = false;
      notifyListeners();
    });
  }

  void setSnap(v) {
    snap = v;
    notifyListeners();
  }

  void pushStackData(img) {
    stackData.insert(0, img);
    notifyListeners();
  }

  Future<void> popStackData({required String direction}) async {
    if (snap || stackData.isEmpty) return;

    swipeDirection = direction;
    snap = true;
    notifyListeners();

    // Wait for swipe animation to complete
    await Future.delayed(const Duration(milliseconds: 1600));

    // Remove the top card
    stackData.removeLast();
    notifyListeners();

    // Allow a short delay to let UI settle before inserting
    await Future.delayed(const Duration(milliseconds: 30));

    // Reset snap before inserting new card to avoid animation glitch
    snap = false;
    notifyListeners();

    // Add a new card to the bottom of the stack (start of the list)
    if (newData.isNotEmpty) {
      stackData.insert(0, newData.removeAt(0));
      notifyListeners();
    }
  }
}
