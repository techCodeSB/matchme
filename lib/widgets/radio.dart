import 'package:flutter/material.dart';
import '../constant.dart';

class Radio extends StatefulWidget {
  final String? title;
  final List<String> items;
  final ValueChanged<String?> onChanged;
  final String? defaultValue;

  const Radio({
    super.key,
    this.title,
    required this.items,
    required this.onChanged,
    this.defaultValue,
  });

  @override
  State<Radio> createState() => _RadioState();
}

class _RadioState extends State<Radio> {
  int? selectedIndex;

  @override
  void initState() {
    super.initState();

    if (widget.defaultValue != null && widget.defaultValue!.isNotEmpty) {
      final lowerDefault = widget.defaultValue!;
      final lowerItems = widget.items.map((e) => e).toList();

      selectedIndex = lowerItems.indexOf(lowerDefault);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(top: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          widget.title != null
              ? Text(
                  widget.title!,
                  style: TextStyle(
                    fontFamily: Constant.subHadding,
                    fontSize: 18.0,
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
                  widget.onChanged(widget.items[index]);
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 5.0, vertical: 10.0),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: isSelected ? Constant.highlightColor : Colors.white,
                    border:
                        Border.all(color: const Color(0xFF033A44), width: 1.5),
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  child: Text(
                    widget.items[index],
                    style: TextStyle(
                        color: isSelected ? Colors.white : Colors.black,
                        fontWeight: FontWeight.w500,
                        fontSize: 16.0),
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
