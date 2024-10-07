import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:http/http.dart' as http;
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:share_plus/share_plus.dart';

class OnlineDisplayScreen extends StatefulWidget {
  final String categoryName;

  const OnlineDisplayScreen(this.categoryName, {super.key});

  @override
  _OnlineDisplayScreenState createState() => _OnlineDisplayScreenState();
}

class _OnlineDisplayScreenState extends State<OnlineDisplayScreen> {
  late Future<List<String>> _imagesFuture;

  @override
  void initState() {
    super.initState();
    _imagesFuture = fetchImages();
    _requestStoragePermission(); // Request storage permission when the screen initializes
  }

  Future<void> _requestStoragePermission() async {
    // Request storage permission
    var status = await Permission.storage.request();
    if (!status.isGranted) {
      // Permission denied, handle accordingly
      print("Storage permission denied");
    }
  }

  Future<List<String>> fetchImages() async {
    final response = await http.get(Uri.parse(
        'https://mehndi.thetechnologia.com/api/Category/Name?name=${widget.categoryName}'));
    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      List<String> images = [];
      for (var item in data) {
        images.add(item);
      }
      return images;
    } else {
      throw Exception('Failed to load images for ${widget.categoryName}');
    }
  }

  Future<void> _shareDownloadedImage(String imageUrl) async {
    try {
      String localFilePath = await _downloadAndSaveImage(imageUrl);
      await Share.shareFiles([localFilePath]);
      print('Image downloaded and shared successfully');
    } catch (e) {
      print("Error downloading/sharing image: $e");
    }
  }

  Future<String> _downloadAndSaveImage(String imageUrl) async {
    final Directory appDocDir = await getApplicationDocumentsDirectory();
    final String appDocPath = appDocDir.path;
    const String fileName = 'Mehndi';

    showDialog(
      context: context,
      barrierDismissible: false, // Prevent user from dismissing the dialog
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: const Color(0xFFFCEFDF),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                LoadingAnimationWidget.twistingDots(
                  leftDotColor: Colors.black,
                  rightDotColor: Colors.brown,
                  size: 60,
                ),
                const SizedBox(height: 20),
                const Text("Downloading Image..."),
              ],
            ),
          ),
        );
      },
    );

    try {
      http.Response response = await http.get(Uri.parse(imageUrl));

      if (response.statusCode == 200) {
        // Check content type to ensure it's an image
        String contentType = response.headers['content-type'] ?? '';
        if (!contentType.startsWith('image')) {
          throw Exception('Downloaded file is not an image');
        }

        // Extract file extension from content type
        String extension = contentType.split('/').last;

        // Save the image with appropriate file extension
        final File file = File('$appDocPath/$fileName.$extension');
        await file.writeAsBytes(response.bodyBytes);

        // Save the image to gallery
        await GallerySaver.saveImage(file.path);

        print('Image downloaded and saved successfully');

        // Close the loading dialog
        Navigator.pop(context);

        // Show dialog to inform the user that the image has been downloaded
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              backgroundColor: const Color(0xFFFCEFDF),
              title: const Text(
                "Image Downloaded",
                style: TextStyle(color: Colors.black),
              ),
              content: const Text(
                "The image has been successfully downloaded and saved.",
                style: TextStyle(color: Colors.green),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context); // Close the dialog
                  },
                  child: const Text(
                    "OK",
                    style: TextStyle(color: Colors.green),
                  ),
                ),
              ],
            );
          },
        );

        return file.path; // Return the local file path
      } else {
        Navigator.pop(context); // Close the loading dialog
        throw Exception('Failed to download image: ${response.statusCode}');
      }
    } catch (e) {
      print("Error downloading/saving image: $e");
      Navigator.pop(context); // Close the loading dialog
      rethrow;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFFCEFDF),
        title: Text(widget.categoryName),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: FutureBuilder<List<String>>(
          future: _imagesFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else {
              return ListView.builder(
                physics: const AlwaysScrollableScrollPhysics(),
                itemCount: snapshot.data!.length,
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () {
                      _shareDownloadedImage(
                          "https://mehndi.thetechnologia.com/${snapshot.data![index]}");
                    },
                    child: Container(
                      margin: const EdgeInsets.all(8.0),
                      padding: const EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFCEFDF),
                        borderRadius: BorderRadius.circular(8.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          Image.network(
                            "https://mehndi.thetechnologia.com/${snapshot.data![index]}",
                            fit: BoxFit.contain,
                            height: 200,
                            width: double.infinity,
                          ),
                          const SizedBox(height: 8),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              IconButton(
                                icon: const Icon(Icons.favorite_border),
                                onPressed: () {
                                  // Add your onPressed action for favorite icon here
                                },
                              ),
                              IconButton(
                                icon: const Icon(Icons.file_download),
                                onPressed: () {
                                  _downloadAndSaveImage(
                                      "https://mehndi.thetechnologia.com/${snapshot.data![index]}");
                                },
                              ),
                              IconButton(
                                icon: const Icon(Icons.share),
                                onPressed: () {
                                  _shareDownloadedImage(
                                      "https://mehndi.thetechnologia.com/${snapshot.data![index]}");
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}
