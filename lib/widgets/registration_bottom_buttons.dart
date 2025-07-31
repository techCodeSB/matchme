import 'package:flutter/material.dart';
import 'package:matchme/constant.dart';

class RegistrationBottomButtons extends StatefulWidget {
  final Function? onNextTap;
  final Function? onBackTap;
  final bool isBack;
  final bool isNext;

  const RegistrationBottomButtons({
    super.key,
    this.onNextTap,
    this.onBackTap,
    this.isBack = true,
    this.isNext = true,
  });

  @override
  State<RegistrationBottomButtons> createState() =>
      _RegistrationBottomButtonsState();
}

class _RegistrationBottomButtonsState extends State<RegistrationBottomButtons> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: size.width * 0.05,
        vertical: size.height * 0.02,
      ),
      child: Row(
        children: [
          widget.isBack == true
              ? Expanded(
                  child: InkWell(
                    onTap: () {
                      widget.onBackTap!();
                    },
                    child: Container(
                      height: 50.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30.0),
                        border: Border.all(
                          color: const Color(0xFF033A44),
                          width: 2.0,
                        ),
                      ),
                      child: Center(
                        child: Text(
                          "Back",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                            fontFamily: Constant.subHadding,
                          ),
                        ),
                      ),
                    ),
                  ),
                )
              : const Text(""),
          SizedBox(width: widget.isBack ? 20.0 : 0.0),
          widget.isNext == true
              ? Expanded(
                  child: InkWell(
                    onTap: () {
                      widget.onNextTap!();
                    },
                    child: Container(
                      height: 50.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30.0),
                        color: const Color(0xFF033A44),
                      ),
                      child: Center(
                        child: Text(
                          "Next",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                            fontFamily: Constant.subHadding,
                          ),
                        ),
                      ),
                    ),
                  ),
                )
              : const Text(""),
        ],
      ),
    );
  }
}
