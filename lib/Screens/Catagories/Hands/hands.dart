import 'package:flutter/material.dart';
import 'package:mehndi_app/model/ImageDialog.dart';
import 'package:mehndi_app/model/ImageDownloader.dart';
import 'package:mehndi_app/model/shareDownloadedImage.dart';
import 'package:share_plus/share_plus.dart';

class HandsScreen extends StatefulWidget {
  const HandsScreen({
    super.key,
    this.favoriteImagePaths = const [], // Remove 'const' keyword here
  });

  final List<String> favoriteImagePaths;
  @override
  _HandsScreenState createState() => _HandsScreenState();
}

class _HandsScreenState extends State<HandsScreen> {
  final List<String> imagePaths = [
    'assets/images/handspic/hand1.jpeg',
    'assets/images/handspic/hand2.jpeg',
    'assets/images/handspic/hand3.jpeg',
    'assets/images/handspic/hand4.jpeg',
    'assets/images/handspic/hand6.jpeg',
    'assets/images/handspic/hand5.jpg',
    'assets/images/handspic/hand7.jpg',
    'assets/images/handspic/hand8.jpg',
  ];
  final List<String> imageTexts = [
    'Henna Harmony',
    'Mehndi Magic',
    'Handcrafted Henna',
    'Enchanting Mehndi',
    'Elegant Mehndi',
    'Artistic Henna',
    'Mystical Mehndi',
    'Ornate',
  ];

  List<bool> isFavoritedList = List.generate(8, (index) => false);

  final List<String> favoriteImagePaths = [];

  @override
  Widget build(BuildContext context) {
    void shareDownloadedImage(String imagePath) async {
      final String tempImagePath =
          await ImageSharing.copyImageToTempDir(imagePath);
      Share.shareFiles([tempImagePath]);
    }

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 250, 226, 196),
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: const Center(
          child: Text(
            " Collection",
            style: TextStyle(color: Colors.white, fontSize: 22),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: imagePaths.length,
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  onTap: () {
                    ImageDialog.show(context, imagePaths[index]);
                  },
                  child: Container(
                    margin: const EdgeInsets.all(8.0),
                    padding: const EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
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
                        Image.asset(
                          imagePaths[index],
                          fit: BoxFit.cover,
                          height: 200,
                          width: double.infinity,
                        ),
                        const SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Text(
                              imageTexts[index],
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                fontFamily: 'Lora-VariableFont_wght.ttf',
                                color: Colors.brown,
                              ),
                            ),
                            IconButton(
                              icon: isFavoritedList[index]
                                  ? const Icon(Icons.favorite,
                                      color: Colors.pink)
                                  : const Icon(Icons.favorite_border),
                              onPressed: () {
                                setState(() {
                                  isFavoritedList[index] =
                                      !isFavoritedList[index];
                                  if (isFavoritedList[index]) {
                                    widget.favoriteImagePaths
                                        .add(imagePaths[index]);
                                  } else {
                                    widget.favoriteImagePaths
                                        .remove(imagePaths[index]);
                                  }
                                });
                              },
                            ),
                            IconButton(
                              icon: const Icon(Icons.file_download),
                              onPressed: () {
                                ImageDownloader.downloadAndSaveImage(
                                    context, imagePaths[index]);
                              },
                            ),
                            IconButton(
                              icon: const Icon(Icons.share),
                              onPressed: () {
                                shareDownloadedImage(imagePaths[index]);
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
