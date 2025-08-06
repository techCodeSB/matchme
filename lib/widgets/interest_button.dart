import 'package:flutter/material.dart';
import '../constant.dart';

class InterestButton extends StatefulWidget {
  final IconData? icons;
  final String text;
  final ValueChanged<List<String?>> onChanged;
  final bool isSelected;

  const InterestButton({
    super.key,
    required this.text,
    this.icons,
    required this.onChanged,
    required this.isSelected,
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

        widget.onChanged(activeInterest);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30.0),
          border: Border.all(color: const Color(0xFF033A44), width: 1.5),
          color: widget.isSelected
              ? Constant.highlightColor
              : Colors.white,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            widget.icons != null
                ? Icon(
                    widget.icons,
                    color: widget.isSelected
                        ? Colors.white
                        : Colors.black,
                  )
                : const Text(""),
            const SizedBox(width: 7.0),
            Text(
              widget.text,
              overflow: TextOverflow.ellipsis,
              softWrap: false,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: widget.isSelected
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
