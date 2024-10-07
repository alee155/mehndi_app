import 'dart:io';

import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';

class ImageSharing {
  static Future<String> copyImageToTempDir(String imagePath) async {
    final ByteData data = await rootBundle.load(imagePath);
    final List<int> bytes = data.buffer.asUint8List();

    final Directory tempDir = await getTemporaryDirectory();
    final String tempPath = tempDir.path;
    final String fileName = imagePath.split('/').last;

    final File tempFile = File('$tempPath/$fileName');
    await tempFile.writeAsBytes(bytes);

    return tempFile.path;
  }
}
