import 'package:flutter/material.dart';

class ErrorText extends StatefulWidget {
  final String text;
  final bool visible;

  const ErrorText({
    super.key,
    required this.text,
    required this.visible,
  });

  @override
  State<ErrorText> createState() => _ErrorTextState();
}

class _ErrorTextState extends State<ErrorText> {
  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: widget.visible,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.only(left: 10, top: 3.0),
        child: Text(
          widget.text,
          style: const TextStyle(
            color: Colors.red,
            fontSize: 13.0,
          ),
        ),
      ),
    );
  }
}
