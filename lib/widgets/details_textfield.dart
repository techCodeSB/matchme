import 'package:flutter/material.dart';
import 'package:match_me/constant.dart';

class DetailsTextfield extends StatefulWidget {
  final String hintText;
  final IconData icon;
  final TextEditingController controller;
  final onTap;

  const DetailsTextfield({
    super.key,
    required this.hintText,
    required this.icon,
    required this.controller,
    this.onTap
  });

  @override
  State<DetailsTextfield> createState() => _DetailsTextfieldState();
}

class _DetailsTextfieldState extends State<DetailsTextfield> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      onTap: (){
        widget.onTap();
      },
      controller: widget.controller,
      style: TextStyle(
        fontFamily: Constant.subHadding,
        color:const Color(0xFF0C5461),
      ),
      decoration: InputDecoration(
        prefixIcon: Icon(
          widget.icon,
          color: const Color(0xFF0C5461),
        ),
        hintText: widget.hintText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30.0),
          borderSide: const BorderSide(
            color: Color(0xFF1690A7),
            width: 1.0,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30.0),
          borderSide: const BorderSide(
            color: Color(0xFF1690A7),
            width: 1.0,
          ),
        ),
        contentPadding: const EdgeInsets.all(10.0
        ),
      ),
    );
  }
}
