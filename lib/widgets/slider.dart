import 'package:flutter/material.dart';
import 'package:matchme/constant.dart';
import 'package:insta_image_viewer/insta_image_viewer.dart';

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
            return AnimatedOpacity(
              opacity: currentIndex == index ? 1.0 : 0.5,
              duration: const Duration(milliseconds: 300),
              child: Container(
                width: double.infinity,
                height: double.infinity,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(30.0),
                    bottomRight: Radius.circular(30.0),
                  ),
                  // image: DecorationImage(
                  //   image: NetworkImage(
                  //     "${Constant.imageUrl}${widget.imgs[index]}",
                  //   ),
                  //   fit: BoxFit.cover,
                  // ),
                ),
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(30.0),
                    bottomRight: Radius.circular(30.0),
                  ),
                  child: InstaImageViewer(
                    backgroundIsTransparent: true,
                    imageUrl:"${Constant.imageUrl}${widget.imgs[index]}" ,
                    child: Image(
                      fit: BoxFit.cover,
                      image: Image.network(
                        "${Constant.imageUrl}${widget.imgs[index]}",
                      ).image,
                    ),
                  ),
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
                AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  width: currentIndex == i ? 30.0 : 10.0,
                  height: 4.0,
                  margin: const EdgeInsets.only(right: 8.0),
                  decoration: BoxDecoration(
                    color: currentIndex == i ? Colors.black : Colors.white,
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                ),
            ],
          ),
        )
      ],
    );
  }
}
