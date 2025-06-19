import 'package:flutter/material.dart';
import '../constant.dart';

class Dropdown extends StatefulWidget {
  final String hint;
  final ValueChanged<String?> onChanged;
  final List<String> items;
  final IconData? icon;

  const Dropdown({
    super.key,
    required this.hint,
    required this.onChanged,
    required this.items,
    required this.icon,
  });

  @override
  State<Dropdown> createState() => _DropdownState();
}

class _DropdownState extends State<Dropdown> {
  String? selectedValue;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 45.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30.0),
        border: Border.all(color: const Color(0xFF1690A7), width: 1.0),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Row(
          children: [
            Icon(
              widget.icon,
              color: const Color(0xFF0C5461),
            ),
            const SizedBox(width: 10.0),
            Expanded(
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: selectedValue,
                  hint: Text(
                    widget.hint,
                    style: TextStyle(
                      fontFamily: Constant.subHadding,
                      color:const Color(0xFF0C5461),
                    ),
                  ),
                  items: widget.items.map((String item) {
                    return DropdownMenuItem<String>(
                      value: item,
                      child: Text(item),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedValue = value;
                    });
                    widget.onChanged(value); // call the callback
                  },
                  icon: const Icon(
                    Icons.keyboard_arrow_down_rounded,
                    color: Color(0xFF033A44),
                  ),
                  style: const TextStyle(
                    color: Color(0xFF0C5461),
                    fontSize: 16.0,
                    fontWeight: FontWeight.w500,
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
