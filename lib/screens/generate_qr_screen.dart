import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:library_management_system/utils/flushmessage.dart';
import 'package:path_provider/path_provider.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:screenshot/screenshot.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:saver_gallery/saver_gallery.dart';

class GenerateQrScreen extends StatefulWidget {
  final Map<String, dynamic> data;
  const GenerateQrScreen({super.key, required this.data});

  @override
  State<GenerateQrScreen> createState() => _GenerateQrScreenState();
}

class _GenerateQrScreenState extends State<GenerateQrScreen> {
  final ScreenshotController screenshotController = ScreenshotController();
  @override
  Widget build(BuildContext context) {
    final String jsonData = jsonEncode(widget.data);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Generate Qr Code"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Screenshot(
              controller: screenshotController,
              child: QrImageView(
                backgroundColor: Colors.white,
                data: jsonData,
                size: 300,
                gapless: true,
                version: QrVersions.auto,
              ),
            ),
            const SizedBox(height: 10),
            TextButton(
                onPressed: () async {
                  await saveCapturedImage();
                },
                child: const Text("Save Image"))
          ],
        ),
      ),
    );
  }

  Future<void> saveCapturedImage() async {
    // Capture the screenshot as Uint8List
    final Uint8List? uint8list = await screenshotController.capture();

    if (uint8list != null) {
      // Request permission to write to external storage
      final PermissionStatus status = await Permission.storage.request();
      if (status.isGranted) {
        try {
          // Get the device's directory to save the file (like Pictures)
          final directory = await getExternalStorageDirectory();
          String path = '${directory!.path}/Pictures';

          // Make sure the directory exists
          if (!Directory(path).existsSync()) {
            Directory(path).createSync(recursive: true);
          }

          // Create file path and save the image
          final String fileName =
              'qr_code_${DateTime.now().millisecondsSinceEpoch}.png';
          final result = await SaverGallery.saveImage(uint8list,
              name: fileName, androidExistNotSave: true);

          if (result.isSuccess) {
            FlushMessage.successFlushMessage(
                context, "Image saved successfully");
          } else {
            FlushMessage.errorFlushMessage(context, "Unable To Save Image");
          }
        } catch (e) {
          FlushMessage.errorFlushMessage(context, "Error saving image: $e");
        }
      } else {
        FlushMessage.errorFlushMessage(
            context, "Storage permission not granted");
      }
    } else {
      await openAppSettings();
      FlushMessage.errorFlushMessage(context, "Failed to capture image");
    }
  }
}
