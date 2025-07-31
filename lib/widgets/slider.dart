import 'package:flutter/material.dart';
import 'package:matchme/constant.dart';

// ============================
// This Widget use in Profile
// ============================

class ProfileSlider extends StatefulWidget {
  final List<String> imgs;

  const ProfileSlider({
    super.key,
    required this.imgs,
  });

  @override
  State<ProfileSlider> createState() => _ProfileSliderState();
}

class _ProfileSliderState extends State<ProfileSlider> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        PageView.builder(
          onPageChanged: (page) {
            setState(() {
              currentIndex = page;
            });
          },
          itemCount: widget.imgs.length,
          itemBuilder: (context, index) {
            return Container(
              width: double.infinity,
              height: double.infinity,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(30.0),
                  bottomRight: Radius.circular(30.0),
                ),
                image: DecorationImage(
                  // image: AssetImage(widget.imgs[index]),
                  image: NetworkImage("${Constant.imageUrl}${widget.imgs[index]}"),
                  fit: BoxFit.cover,
                ),
              ),
            );
          },
        ),
        Positioned(
          bottom: 40.0,
          right: 0.0,
          left: 0.0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              for (int i = 0; i < widget.imgs.length; i++)
                Container(
                  width: 30.0,
                  height: 4.0,
                  color: currentIndex == i ? Colors.black : Colors.white,
                  margin: const EdgeInsets.only(right: 10.0),
                ),
            ],
          ),
        )
      ],
    );
  }
}
