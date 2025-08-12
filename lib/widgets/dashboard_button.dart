import 'package:flutter/material.dart';
import '../constant.dart';

class DashboardButton extends StatefulWidget {
  final IconData icon;
  final String text;
  final VoidCallback onChange;

  const DashboardButton({
    super.key,
    required this.icon,
    required this.text,
    required this.onChange,
  });

  @override
  State<DashboardButton> createState() => _DashboardButtonState();
}

class _DashboardButtonState extends State<DashboardButton> {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Expanded(
      child: InkWell(
        onTap: widget.onChange,
        child: Container(
          height: size.height * 0.1,
          padding: const EdgeInsets.symmetric(vertical: 5.0),
          decoration: BoxDecoration(
            // color: const Color(0xFF245C66),
            gradient: const LinearGradient(
              colors: [Color.fromARGB(255, 80, 137, 147), Color(0xFF245C66)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                widget.icon,
                color: Colors.white,
                size: 32.0,
              ),
              const SizedBox(height: 7.0),
              Text(
                widget.text,
                style: TextStyle(
                  fontFamily: Constant.haddingFont,
                  color: Colors.white,
                  fontSize: 15.0,
                  fontWeight: FontWeight.w600,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
