import 'dart:io';
import 'package:flutter/material.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:matchme/constant.dart';
import '../controller/photoupload_controller.dart';
import 'package:provider/provider.dart';

class ImageUploader extends StatefulWidget {
  final File? image;
  final String? pos;
  final String? uploadedImage;

  const ImageUploader({
    super.key,
    this.image,
    this.pos,
    this.uploadedImage,
  });

  @override
  State<ImageUploader> createState() => _ImageUploaderState();
}

class _ImageUploaderState extends State<ImageUploader> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Provider.of<PhotouploadController>(context, listen: false)
            .showSheet(context, widget.pos ?? "one");
      },
      child: DottedBorder(
        dashPattern: const [10, 3],
        color: const Color(0xFF033A44),
        strokeWidth: 2.0,
        borderType: BorderType.RRect,
        radius: const Radius.circular(20.0),
        child: widget.image == null
            ? SizedBox(
                height: double.infinity,
                child: widget.uploadedImage == null
                    ? const Center(
                        child: Icon(
                          Icons.add_circle_rounded,
                          color: Color(0xFF033A44),
                          size: 35.0,
                        ),
                      )
                    : ClipRRect(
                      borderRadius: BorderRadius.circular(20.0),
                      child: Image.network(
                          "${Constant.imageUrl}${widget.uploadedImage}",
                          fit: BoxFit.cover,
                          width: double.infinity,
                          height: double.infinity,
                        ),
                    ),
              )
            : SizedBox(
                width: double.infinity,
                height: double.infinity,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20.0),
                  child: Image.file(
                    File(widget.image!.path),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
      ),
    );
  }
}
