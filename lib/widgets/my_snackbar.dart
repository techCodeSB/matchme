import 'package:flutter/material.dart';

ScaffoldFeatureController mySnackBar(ctx, text) {
  return ScaffoldMessenger.of(ctx).showSnackBar(
    SnackBar(
      content: Text(text),
      duration: const Duration(seconds: 2),
      closeIconColor: Colors.yellow,
      showCloseIcon: true,
      behavior: SnackBarBehavior.floating,
    ),
  );
}
