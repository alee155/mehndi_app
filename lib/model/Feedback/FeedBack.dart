import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';

class FeedbackDialog {
  static Widget showFeedbackDialog(
      BuildContext context, Function(String) onSubmit) {
    final key = GlobalKey<FormState>();
    TextEditingController subjectContr =
        TextEditingController(text: 'Feedback from Mehndi App');
    TextEditingController bodyContr = TextEditingController();

    TextEditingController emailContr =
        TextEditingController(text: 'zbrkhakwani@gmail.com');

    sendEmail(String body) async {
      final Email email = Email(
        body: body,
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
                title: Text(
                  'Feedback',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.teal.shade900,
                  ),
                ),
                content: SingleChildScrollView(
                  child: Form(
                    key: key,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
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
                      ],
                    ),
                  ),
                ),
                actions: [
                  TextButton(
                    child: Text(
                      'Submit Feedback',
                      style: TextStyle(
                        color: Colors.teal.shade900,
                      ),
                    ),
                    onPressed: () async {
                      key.currentState!.save();
                      sendEmail(bodyContr.text);
                      Navigator.of(context).pop();
                      onSubmit(bodyContr.text);
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
