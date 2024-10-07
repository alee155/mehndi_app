import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:path_provider/path_provider.dart';

class ImageDownloader {
  static Future<void> downloadAndSaveImage(
      BuildContext context, String imagePath) async {
    bool downloading = true;

    final ByteData data = await rootBundle.load(imagePath);
    final List<int> bytes = data.buffer.asUint8List();

    final Directory appDocDir = await getApplicationDocumentsDirectory();
    final String appDocPath = appDocDir.path;
    const String fileName = 'Mehndi';

    try {
      final File file = File('$appDocPath/$fileName.jpg');
      await file.writeAsBytes(bytes);

      // Save the image to gallery
      await GallerySaver.saveImage(file.path);

      print('Image saved successfully');

      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Image saved successfully"),
      ));
    } catch (e) {
      print("Error saving image: $e");
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Error saving image: $e"),
      ));
    } finally {
      downloading = false;

      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Download Complete'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }
}
