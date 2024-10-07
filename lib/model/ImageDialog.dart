import 'package:flutter/material.dart';

class ImageDialog {
  static void show(BuildContext context, String imagePath) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Center(
          child: AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
            contentPadding: EdgeInsets.zero,
            content: SizedBox(
              width: MediaQuery.of(context).size.width *
                  0.8, // Adjust the width as needed
              child: SingleChildScrollView(
                child: ClipRRect(
                  borderRadius:
                      BorderRadius.circular(8.0), // Same radius as AlertDialog
                  child: Image.asset(
                    imagePath,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
