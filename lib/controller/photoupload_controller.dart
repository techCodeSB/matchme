import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../widgets/my_snackbar.dart';
import '../constant.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:path/path.dart' as path;

class PhotouploadController extends ChangeNotifier {
  final Map<String, dynamic> images = {
    "one": null,
    "two": null,
    "three": null,
    "four": null,
    "five": null,
    "six": null
  };

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
          height: MediaQuery.of(context).size.height * 0.1,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20.0),
              topRight: Radius.circular(20.0),
            ),
          ),
          child: Center(
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
        );
      },
    );
  }

  // Function to upload images
  Future<void> upload(ctx) async {
    // Choose first 5 image;
    for (var e in images.keys) {
      if (images[e] == null && e != "six") {
        mySnackBar(ctx, "Choose first 5 image.");
        return;
      }
    }

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');
    var uri = Uri.parse('${Constant.api}users/upload');
    var req = http.MultipartRequest('POST', uri);
    req.fields['token'] = token!;

    for (var entry in images.entries) {
      final fieldName = entry.key;
      final file = entry.value;

      if (file != null && file is File) {
        final extension = path.extension(file.path).toLowerCase();
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

    var res = await req.send();
    if (res.statusCode == 200) {
      mySnackBar(ctx, 'Upload successful');
    } else {
      mySnackBar(ctx, "Upload failed");
      // final body = await res.stream.bytesToString();
    }
  }
}
