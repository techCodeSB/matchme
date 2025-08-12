import 'package:flutter/material.dart';
import 'package:matchme/constant.dart';

ScaffoldFeatureController mySnackBar(ctx, text) {
  return ScaffoldMessenger.of(ctx).showSnackBar(
    SnackBar(
      content: Text(
        text,
        style:const TextStyle(fontSize: 19.0),
      ),
      duration: const Duration(seconds: 5),
      closeIconColor: Constant.highlightColor,
      showCloseIcon: true,
      behavior: SnackBarBehavior.floating,
      backgroundColor: const Color(0XFF033A44),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30.0)
      ),
      padding:const EdgeInsets.only(left: 30.0),
    ),
  );
}
