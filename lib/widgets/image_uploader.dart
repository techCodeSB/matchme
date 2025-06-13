import 'package:flutter/material.dart';
import 'package:dotted_border/dotted_border.dart';

class ImageUploader extends StatefulWidget {
  const ImageUploader({super.key});

  @override
  State<ImageUploader> createState() => _ImageUploaderState();
}

class _ImageUploaderState extends State<ImageUploader> {
  @override
  Widget build(BuildContext context) {
    return DottedBorder(
      dashPattern: const [10, 3],
      color: const Color(0xFF033A44),
      strokeWidth: 2.0,
      borderType: BorderType.RRect,
      radius: const Radius.circular(20.0),
      child: const SizedBox(
        height: double.infinity,
        child: Center(
          child: Icon(
            Icons.add_circle_rounded,
            color: Color(0xFF033A44),
            size: 35.0,
          ),
        ),
      ),
    );
  }
}
