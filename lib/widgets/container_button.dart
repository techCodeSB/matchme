import 'package:flutter/material.dart';
import '../constant.dart';

class ContainerButton extends StatefulWidget {
  final String text;
  final Color color;
  final Color textColor;
  final Function() onTap;

  const ContainerButton({
    super.key,
    required this.text,
    required this.color,
    required this.textColor,
    required this.onTap,
  });

  @override
  State<ContainerButton> createState() => _ContainerButtonState();
}

class _ContainerButtonState extends State<ContainerButton> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        widget.onTap();
      },
      child: Container(
        width: double.infinity,
        height: 60.0,
        padding: const EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30.0),
          color: widget.color,
        ),
        child: Center(
          child: Text(
            widget.text,
            style: TextStyle(
              fontFamily: Constant.haddingFont,
              color: widget.textColor,
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
