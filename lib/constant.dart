import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';

class Constant {
  static final String? haddingFont = GoogleFonts.josefinSans().fontFamily;
  static final String? subHadding = GoogleFonts.outfit().fontFamily;
  static Icon backIcon = const Icon(Icons.arrow_back_ios, size: 20.0);
  static String api = "http://10.0.2.2:8080/api/v1/";
  static String imageUrl = "http://10.0.2.2:8080/api/v1/users/upload/";
}
