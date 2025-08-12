import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:matchme/controller/splash_controller.dart';
import 'package:matchme/screen/lifestyle_1.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../widgets/my_snackbar.dart';
import '../constant.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:path/path.dart' as path;
import 'package:flutter_image_compress/flutter_image_compress.dart';

class PhotouploadController extends ChangeNotifier {
  Map<String, dynamic> images = {
    "one": null,
    "two": null,
    "three": null,
    "four": null,
    "five": null,
    "six": null
  };

  static Map<String, dynamic> uploadedImages = {}; // uploaded img store;

  Future<File> _compressImage(File file) async {
    final outPath = file.path.replaceFirst(
      path.extension(file.path),
      '_compressed${path.extension(file.path)}',
    );

    final compressed = await FlutterImageCompress.compressAndGetFile(
      file.absolute.path,
      outPath,
      quality: 70, // Adjust 0–100
    );

    // If compression fails, return original file
    if (compressed == null) return file;

    return File(compressed.path);
  }

  // Function to open the camera
  Future<void> openCamera(context, pos) async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.camera);
    Navigator.pop(context);

    if (image != null) {
      // Handle the captured image
      images[pos] = File(image.path);
      notifyListeners();
    }
  }

  // Function to open the gallery
  Future<void> openGallery(context, pos) async {
    PermissionStatus status;

    if (await Permission.photos.isGranted ||
        await Permission.mediaLibrary.isGranted) {
      status = PermissionStatus.granted;
    } else {
      status = await Permission.photos.request();
    }

    if (status.isGranted) {
      final ImagePicker picker = ImagePicker();
      final XFile? image = await picker.pickImage(source: ImageSource.gallery);
      Navigator.pop(context);

      if (image != null) {
        images[pos] = File(image.path);
        notifyListeners();
        debugPrint("Image path Gallery: ${image.path}");
      }
    } else {
      mySnackBar(context, "Permission denied.");
    }
  }

  // Function to show the bottom sheet for image selection
  void showSheet(ctx, pos) {
    showModalBottomSheet(
      context: ctx,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.15,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20.0),
              topRight: Radius.circular(20.0),
            ),
          ),
          child: Column(
            children: [
              const SizedBox(height: 8),
              const Icon(
                Icons.horizontal_rule_outlined,
                size: 35.0,
                color: Colors.black,
              ),
              const SizedBox(height: 16),
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.camera_alt,
                      color: Color(0xFF033A44),
                      size: 30.0,
                    ),
                    TextButton(
                      onPressed: () {
                        // Add your take photo logic here
                        openCamera(ctx, pos);
                      },
                      child: const Text(
                        "Take Photo",
                        style: TextStyle(
                          color: Color(0xFF033A44),
                          fontSize: 16.0,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    const SizedBox(width: 60.0),
                    const Icon(
                      Icons.photo,
                      color: Color(0xFF033A44),
                      size: 30.0,
                    ),
                    TextButton(
                      onPressed: () {
                        // Add your take photo logic here
                        openGallery(ctx, pos);
                      },
                      child: const Text(
                        "Gallery",
                        style: TextStyle(
                          color: Color(0xFF033A44),
                          fontSize: 16.0,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  // Function to upload images
  Future<void> upload(ctx) async {
    // Choose first 4 image;
    if (uploadedImages.isEmpty) {
      for (var e in images.keys) {
        if ((e != "five" && e != "six") && images[e] == null) {
          mySnackBar(ctx, "Choose first 4 image.");
          return;
        }
      }
    }

    // Time of update: not select any image;
    if (uploadedImages.isNotEmpty && images.values.every((v) => v == null)) {
      Navigator.pop(ctx);
      return;
    }

    Uri url2 = Uri.parse("${Constant.api}users/update");
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');
    var uri = Uri.parse('${Constant.api}users/upload');
    var req = http.MultipartRequest('POST', uri);
    req.fields['token'] = token!;
    var getStatus = await SplashController.getSteps();
    var status = getStatus['registration_status'];

    for (var entry in images.entries) {
      final fieldName = entry.key;
      final file = entry.value;

      if (file != null && file is File) {
        final compressedFile = await _compressImage(file);
        final extension = path.extension(compressedFile.path).toLowerCase();
        String? mimeType;

        if (extension == '.jpg' || extension == '.jpeg') {
          mimeType = 'jpeg';
        } else if (extension == '.png') {
          mimeType = 'png';
        } else {
          continue;
        }

        req.files.add(await http.MultipartFile.fromPath(
          fieldName,
          file.path,
          contentType: MediaType('image', mimeType),
        ));
      }
    }

    var req2 = await http.post(
      url2,
      body: jsonEncode({
        "token": token,
        "registration_step": "10",
      }),
      headers: {"Content-Type": "application/json"},
    );

    var res = await req.send();
    if (res.statusCode == 200 && req2.statusCode == 200) {
      mySnackBar(ctx, 'Upload successful');
      if (status == "0") {
        Navigator.pushReplacement(
          ctx,
          MaterialPageRoute(
            builder: (context) => const Lifestyle1(),
          ),
        );
      } else {
        Navigator.pop(ctx, true);
      }

      images = {
        "one": null,
        "two": null,
        "three": null,
        "four": null,
        "five": null,
        "six": null
      };
    } else {
      mySnackBar(ctx, "Upload failed");
      // final body = await res.stream.bytesToString();
    }
  }

  void clearUploadedPhoto() {
    images = {
      "one": null,
      "two": null,
      "three": null,
      "four": null,
      "five": null,
      "six": null
    };
    uploadedImages.clear();
  }
}
