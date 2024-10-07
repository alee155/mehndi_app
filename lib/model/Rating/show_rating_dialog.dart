// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:rating_dialog/rating_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../App_Utils/app_utils.dart';

class RatingDialogManager {
  // to show rating dialoge
  static Future<dynamic> showRatingDialog(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool hasGivenFeedback = prefs.getBool('hasGivenFeedback') ?? false;

    //If Feedback is given then show Exit Dialog
    if (hasGivenFeedback) {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          // ignore: deprecated_member_use
          return WillPopScope(
            onWillPop: () async => false,
            child: AlertDialog(
              backgroundColor: Colors.white,
              content: const Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Lottie.asset(
                  //   'assets/images/bye.json', // Replace with your animation file
                  //   width: 160,
                  //   height: 150,
                  //   repeat: true,
                  //   reverse: true,
                  // ),
                  SizedBox(height: 16),
                  Text(
                    'Are you sure you want to exit the app?',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
              actionsAlignment: MainAxisAlignment.spaceEvenly,
              actionsPadding: const EdgeInsets.all(10),
              actions: [
                SizedBox(
                  height: 40,
                  width: 110,
                  child: TextButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                        Colors.black,
                      ),
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text(
                      'Cancel',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 40,
                  width: 110,
                  child: TextButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                        Colors.black,
                      ),
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                      SystemNavigator.pop();
                    },
                    child: const Text(
                      'Exit',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      );
    } else {
      final dialog = RatingDialog(
        initialRating: 0,
        starColor: Colors.yellow,
        title: const Text(
          'Mehndi App',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 25,
            color: Colors.brown,
            fontWeight: FontWeight.bold,
          ),
        ),
        message: const Text(
          'Please give us a rating by tapping on the stars below:',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 13,
            color: Colors.black,
          ),
        ),
        image: Image.asset(
          "assets/images/fivestar.png",
          height: 100,
          width: 100,
        ),
        // image: const FlutterLogo(size: 100),
        submitButtonText: 'Submit',
        enableComment: false,
        onSubmitted: (response) async {
          print('rating: ${response.rating}, comment: ${response.comment}');

          //If ratting is less then 3 then show Comment dialog and send to Email
          if (response.rating <= 3.0) {
            showDialog(
              context: context,
              builder: (context) {
                return _showFeedbackDialog(context, response.rating);
              },
            );
            //else navigate to play store for feedback
          } else {
            String packageName = await AppUtils.getPackageName();
            AppUtils.launchUrl(
                'https://play.google.com/store/apps/details?id=$packageName');
            // await StoreRedirect.redirect(
            //     androidAppId: packageName, iOSAppId: packageName);

            SharedPreferences prefs = await SharedPreferences.getInstance();
            prefs.setBool('hasGivenFeedback', true);
          }
        },
      );

      showDialog(
        context: context,
        builder: (context) {
          return dialog;
        },
      );
    }
  }

  //Method to show feedback comment dialog
  static _showFeedbackDialog(BuildContext context, double rating) {
    final key = GlobalKey<FormState>();
    TextEditingController subjectContr =
        TextEditingController(text: 'Feedback from Fake Call App');
    TextEditingController bodyContr = TextEditingController();

    TextEditingController emailContr =
        TextEditingController(text: 'mailto:muhammad155ali155@gmail.com');

    sendEmail(String body, double rating) async {
      final String emailBody = 'Rating: $rating\nFeedback: $body';
      final Email email = Email(
        body: emailBody,
        subject: subjectContr.text,
        recipients: [emailContr.text],
        isHTML: false,
      );

      await FlutterEmailSender.send(email);
    }

    return Stack(
      children: [
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          bottom: 0,
          child: Container(
            color: Colors.transparent,
            child: Center(
              child: AlertDialog(
                backgroundColor: Colors.lime.shade50,
                title: const Text(
                  'Feedback',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                content: SingleChildScrollView(
                  child: Form(
                    key: key,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // Container to hide the email and subject input
                        Container(),
                        Container(),

                        SizedBox(
                          width: 240,
                          height: 120,
                          child: TextFormField(
                            controller: bodyContr,
                            maxLines: null,
                            expands: true,
                            keyboardType: TextInputType.multiline,
                            decoration: const InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              hintText: 'Write Description!!',
                              hintStyle: TextStyle(
                                color: Colors.grey,
                              ),
                              border: OutlineInputBorder(),
                            ),
                          ),
                        ),
                        Text(
                          'Your Rating is: $rating',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.green,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                actions: [
                  TextButton(
                    child: const Text(
                      'Submit Feedback',
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                    onPressed: () async {
                      key.currentState!.save();
                      sendEmail(bodyContr.text, rating);
                      Navigator.of(context).pop();
                      SharedPreferences prefs =
                          await SharedPreferences.getInstance();
                      prefs.setBool('hasGivenFeedback', true);
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
