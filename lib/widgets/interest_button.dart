import 'package:flutter/material.dart';
import '../constant.dart';

class InterestButton extends StatefulWidget {
  final IconData icons;
  final String text;

  const InterestButton({
    super.key,
    required this.icons,
    required this.text,
  });

  @override
  State<InterestButton> createState() => _InterestButtonState();
}

class _InterestButtonState extends State<InterestButton> {
  List<String> activeInterest = [];

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        setState(() {
          if (activeInterest.contains(widget.text)) {
            activeInterest.remove(widget.text);
          } else {
            activeInterest.add(widget.text);
          }
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 13.0, vertical: 10.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30.0),
          color: activeInterest.contains(widget.text)
              ? const Color(0xFF033A44)
              : Colors.white,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              widget.icons,
              color: activeInterest.contains(widget.text)
                  ? Colors.white
                  : Colors.black,
            ),
            const SizedBox(width: 7.0),
            Text(
              widget.text,
              style: TextStyle(
                color: activeInterest.contains(widget.text)
                    ? Colors.white
                    : Colors.black,
                fontFamily: Constant.subHadding,
                fontSize: 16.0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
