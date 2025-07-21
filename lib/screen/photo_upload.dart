import 'package:flutter/material.dart';
import 'package:matchme/controller/photoupload_controller.dart';
import 'package:provider/provider.dart';
import '../widgets/details_hero.dart';
import '../widgets/image_uploader.dart';
import '../constant.dart';
import '../widgets/container_button.dart';

class PhotoUpload extends StatefulWidget {
  const PhotoUpload({super.key});

  @override
  State<PhotoUpload> createState() => _PhotoUploadState();
}

class _PhotoUploadState extends State<PhotoUpload> {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: SafeArea(
        child: Container(
          width: double.infinity,
          height: double.infinity,
          color: const Color(0xFFF5F7F7),
          child: ListView(
            children: [
              DetailsHero(size: size),
              // *********************** TOP BAR CLOSE ***********************

              Text(
                'Upload your photos',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                  fontFamily: Constant.haddingFont,
                  fontSize: 25.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "We'd love to see you. Upload a photo for\nyour dating journey.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: Constant.subHadding,
                  fontSize: 15.0,
                  color: const Color(0xFF333333),
                ),
              ),
              const SizedBox(height: 40.0),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: SizedBox(
                  width: double.infinity,
                  height: size.height * 0.9 / 2,
                  child: Column(
                    children: [
                      SizedBox(
                        height: size.height * 0.5 / 2,
                        width: double.infinity,
                        child: Row(
                          children: [
                            Expanded(
                              flex: 2,
                              child: ImageUploader(
                                pos: "one",
                                image: Provider.of<PhotouploadController>(
                                  context,
                                  listen: true,
                                ).images['one'],
                              ),
                            ),
                            const SizedBox(width: 15.0),
                            Expanded(
                              flex: 1,
                              child: Column(
                                children: [
                                  Expanded(
                                    child: ImageUploader(
                                      pos: "two",
                                      image: Provider.of<PhotouploadController>(
                                        context,
                                        listen: true,
                                      ).images['two'],
                                    ),
                                  ),
                                  const SizedBox(height: 15.0),
                                  Expanded(
                                    child: ImageUploader(
                                      pos: "three",
                                      image: Provider.of<PhotouploadController>(
                                        context,
                                        listen: true,
                                      ).images['three'],
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      const SizedBox(height: 20.0),
                      SizedBox(
                        height: size.height * 0.3 / 2,
                        width: double.infinity,
                        child: Row(
                          children: [
                            Expanded(
                              child: ImageUploader(
                                pos: "four",
                                image: Provider.of<PhotouploadController>(
                                  context,
                                  listen: true,
                                ).images['four'],
                              ),
                            ),
                            const SizedBox(width: 15.0),
                            Expanded(
                              child: ImageUploader(
                                pos: "five",
                                image: Provider.of<PhotouploadController>(
                                  context,
                                  listen: true,
                                ).images['five'],
                              ),
                            ),
                            const SizedBox(width: 15.0),
                            Expanded(
                              child: ImageUploader(
                                pos: "six",
                                image: Provider.of<PhotouploadController>(
                                  context,
                                  listen: true,
                                ).images['six'],
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
              // const Spacer(),
              SizedBox(
                width: double.infinity,
                child: Image.asset(
                  "assets/images/Vector 1.png",
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 30.0),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: ContainerButton(
                  text: "Continue",
                  color: const Color(0xFF033A44),
                  textColor: Colors.white,
                  onTap: () {
                    Provider.of<PhotouploadController>(context, listen: false)
                        .upload(context);
                  },
                ),
              ),
              const SizedBox(height: 30.0),
            ],
          ),
        ),
      ),
    );
  }
}
