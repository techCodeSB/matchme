import 'package:flutter/material.dart';
import '../constant.dart';

class Radio extends StatefulWidget {
  final String? title;
  final List<String> items;
  final ValueChanged<String?> onChanged;

  const Radio({
    super.key,
    this.title,
    required this.items,
    required this.onChanged,
  });

  @override
  State<Radio> createState() => _RadioState();
}

class _RadioState extends State<Radio> {
  int? selectedIndex;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(top: 10.0),
      child: Column(
        children: [
          widget.title != null
              ? Text(
                  widget.title!,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: Constant.subHadding,
                    fontSize: 15.0,
                    color: const Color(0xFF333333),
                  ),
                )
              : const Text(""),
          const SizedBox(height: 20.0),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: widget.items.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 10.0,
              crossAxisSpacing: 10.0,
              childAspectRatio: 3.8,
            ),
            itemBuilder: (context, index) {
              final isSelected = selectedIndex == index;
              return InkWell(
                onTap: () {
                  setState(() => selectedIndex = index);
                  widget.onChanged(widget.items[index].toLowerCase());
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 10.0),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: isSelected ? const Color(0xFF033A44) : Colors.white,
                    border: Border.all(color: const Color(0xFF033A44), width: 1.5),
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  child: Text(
                    widget.items[index],
                    style: TextStyle(
                      color: isSelected ? Colors.white : Colors.black,
                      fontWeight: FontWeight.w500,
                      fontSize: 16.0
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
