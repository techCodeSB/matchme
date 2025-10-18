import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:matchme/constant.dart';
import 'package:matchme/controller/register_controller.dart';
import 'package:matchme/screen/goto_profile.dart';
import 'package:matchme/widgets/my_snackbar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:permission_handler/permission_handler.dart';


class AgreementController extends ChangeNotifier {
  File? _pdfFile;
  String filename = "";

  Future<void> pickedAgreement(ctx) async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf'],
      );
      filename = result!.names[0].toString();

      // ignore: unnecessary_null_comparison
      if (result != null && result.files.single.path != null) {
        _pdfFile = File(result.files.single.path!);
        mySnackBar(ctx, "File selected: ${result.files.single.name}");
      } else {
        mySnackBar(ctx, "No file selected");
      }
    } catch (e) {
      mySnackBar(ctx, "Error picking file");
    }
    notifyListeners();
  }

  void uploadAgreement(ctx) async {
    Provider.of<RegisterController>(ctx, listen: false).setLoader(true);

    Uri url = Uri.parse("${Constant.api}users/upload-agreement");
    final SharedPreferences pref = await SharedPreferences.getInstance();
    final token = pref.getString("token");

    if (_pdfFile == null) {
      mySnackBar(ctx, "Upload agreement file");
      Provider.of<RegisterController>(ctx, listen: false).setLoader(false);
      return;
    }

    try {
      List<int> fileByts = await _pdfFile!.readAsBytes();
      String base64Data = base64Encode(fileByts);
      var req = await http.post(
        url,
        headers: {"Content-Type": 'application/json'},
        body: jsonEncode({
          "token": token,
          "file": base64Data,
          "registration_step": '17',
        }),
      );

      var res = jsonDecode(req.body);
      if (req.statusCode == 200) {
        mySnackBar(ctx, res['message']);
        Navigator.push(
          ctx,
          MaterialPageRoute(
            builder: (ctx) => const GotoProfile(),
          ),
        );
      } else {
        mySnackBar(ctx, res['err']);
      }
      notifyListeners();
    } catch (e) {
      mySnackBar(ctx, "Something went wrong");
      debugPrint("Error fetching user data: $e");
    }

    Provider.of<RegisterController>(ctx, listen: false).setLoader(false);
  }

  Future<void> downloadAgreement(ctx) async {
    Uri url = Uri.parse("${Constant.api}users/view-agreement");
    final SharedPreferences pref = await SharedPreferences.getInstance();
    final token = pref.getString("token");

    try {
      final response = await http.get(url, headers: {
        "Authorization": "Bearer $token",
        "Accept": "application/pdf",
      });

      if (response.statusCode != 200) {
        mySnackBar(
            ctx, "Failed to download. Status code: ${response.statusCode}");
        return;
      }

      Directory? dir;

      if (Platform.isAndroid) {
        // ✅ Step 1: Check Android version
        int sdkInt = int.parse((await _getAndroidSdkInt()).toString());

        if (sdkInt >= 30) {
          // ✅ Android 11 and above → MANAGE_EXTERNAL_STORAGE
          var manageStatus = await Permission.manageExternalStorage.status;
          if (!manageStatus.isGranted) {
            manageStatus = await Permission.manageExternalStorage.request();
          }

          if (manageStatus.isDenied) {
            mySnackBar(ctx, "Please allow file access to download agreement.");
            return;
          } else if (manageStatus.isPermanentlyDenied) {
            mySnackBar(
                ctx, "Please enable 'Files and media' permission in settings.");
            await openAppSettings();
            return;
          }

          dir = Directory("/storage/emulated/0/Download");
        } else {
          // ✅ Android 10 and below → STORAGE permission
          var status = await Permission.storage.status;
          if (!status.isGranted) {
            status = await Permission.storage.request();
          }

          if (status.isDenied) {
            mySnackBar(ctx, "Storage permission denied. Please allow access.");
            status = await Permission.storage.request();
            if (!status.isGranted) return;
          } else if (status.isPermanentlyDenied) {
            mySnackBar(ctx, "Enable storage permission from settings.");
            await openAppSettings();
            return;
          }

          dir = await getExternalStorageDirectory();
        }
      } else if (Platform.isIOS) {
        dir = await getApplicationDocumentsDirectory();
      } else {
        dir = await getDownloadsDirectory();
      }

      if (dir == null) {
        mySnackBar(ctx, "Unable to access download directory");
        return;
      }

      final file = File("${dir.path}/agreement.pdf");
      await file.writeAsBytes(response.bodyBytes);

      _pdfFile = file;
      mySnackBar(ctx, "Agreement downloaded to: ${file.path}");
    } catch (e) {
      mySnackBar(ctx, "Something went wrong: $e");
    }
  }

// ✅ Helper to get Android SDK version
  Future<int> _getAndroidSdkInt() async {
    if (Platform.isAndroid) {
      final version = await Process.run('getprop', ['ro.build.version.sdk']);
      return int.tryParse(version.stdout.toString().trim()) ?? 0;
    }
    return 0;
  }
}
