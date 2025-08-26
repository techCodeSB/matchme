import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:matchme/constant.dart';
import 'package:matchme/screen/goto_profile.dart';
import 'package:matchme/widgets/my_snackbar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;
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
    Uri url = Uri.parse("${Constant.api}users/upload-agreement");
    final SharedPreferences pref = await SharedPreferences.getInstance();
    final token = pref.getString("token");

    if (_pdfFile == null) {
      mySnackBar(ctx, "Upload agreement file");
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

      if (response.statusCode == 200) {
        Directory? dir;

        if (Platform.isAndroid) {
          // Ask for storage permission
          if (await Permission.storage.request().isGranted) {
            dir = Directory(
                "/storage/emulated/0/Download"); // Android Download folder
          } else {
            mySnackBar(ctx, "Storage permission denied");
            return;
          }
        } else if (Platform.isIOS) {
          dir = await getApplicationDocumentsDirectory();
        } else {
          dir = await getDownloadsDirectory(); // Desktop platforms
        }

        if (dir == null) {
          mySnackBar(ctx, "Unable to access download directory");
          return;
        }

        final file = File("${dir.path}/agreement.pdf");
        await file.writeAsBytes(response.bodyBytes);

        _pdfFile = file;
        mySnackBar(ctx, "Agreement downloaded to: downloads/agreement.pdf");
      } else {
        mySnackBar(
            ctx, "Failed to download. Status code: ${response.statusCode}");
      }
    } catch (e) {
      mySnackBar(ctx, "Something went wrong: $e");
    }
  }
}
