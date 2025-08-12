 import 'package:flutter/material.dart';
import 'package:matchme/constant.dart';

Widget buildBorderedTile(String title, String subtitle) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 7.0, vertical: 5.0),
      decoration: BoxDecoration(
        color: const Color.fromARGB(211, 241, 241, 241),
        borderRadius: BorderRadius.circular(10.0),
        border: const Border(
          bottom: BorderSide(
            color: Color.fromARGB(255, 204, 202, 202),
            width: 0.5,
          ),
        ),
      ),
      child: ListTile(
        title: Text(
          title,
          style: TextStyle(
            fontFamily: Constant.haddingFont,
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 17.0,
          ),
        ),
        subtitle: Text(
          subtitle,
          style: TextStyle(
            fontFamily: Constant.subHadding,
            fontWeight: FontWeight.bold,
            color: const Color(0xFF033A44),
            fontSize: 15.0,
          ),
        ),
      ),
    );
  }