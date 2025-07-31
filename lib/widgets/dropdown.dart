import 'package:flutter/material.dart';
import '../constant.dart';

class Dropdown extends StatefulWidget {
  final String hint;
  final ValueChanged<String?> onChanged;
  final Function? onClear;
  final List<String> items;
  final IconData? icon;
  final String? defaultValue;

  const Dropdown(
      {super.key,
      required this.hint,
      required this.onChanged,
      required this.items,
      required this.icon,
      this.defaultValue,
      this.onClear});

  @override
  State<Dropdown> createState() => _DropdownState();
}

class _DropdownState extends State<Dropdown> {
  String? selectedValue;

  @override
  void initState() {
    super.initState();

    if (widget.defaultValue != null && widget.defaultValue!.isNotEmpty) {
      selectedValue = widget.defaultValue;
    }
  }

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
                  menuMaxHeight: 150.0,
                  value: selectedValue,
                  hint: Text(
                    widget.hint,
                    style: TextStyle(
                      fontFamily: Constant.subHadding,
                      color: const Color(0xFF0C5461),
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
                  icon: selectedValue == null
                      ? const Icon(
                          Icons.keyboard_arrow_down_rounded,
                          color: Color(0xFF033A44),
                        )
                      : InkWell(
                          onTap: () {
                            setState(() {
                              selectedValue = null;
                            });
                            widget.onClear!();
                          },
                          child: const Icon(
                            Icons.close,
                            size: 18.0,
                          ),
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
