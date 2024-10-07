import 'package:flutter/material.dart';
import 'package:mehndi_app/model/Feedback/FeedBack.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class ProfileManagement extends StatefulWidget {
  const ProfileManagement({super.key});

  @override
  State<ProfileManagement> createState() => _ProfileManagementState();
}

class _ProfileManagementState extends State<ProfileManagement> {
  late String appNamespace;

  @override
  void initState() {
    super.initState();
    _getAppNamespace();
  }

  Future<void> _getAppNamespace() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    setState(() => appNamespace = packageInfo.packageName);
  }

  void _navigateToPlayStore() async {
    if (appNamespace.isEmpty) {
      print('App namespace is not available');
      return;
    }

    final url = "https://play.google.com/store/apps/details?id=$appNamespace";
    await canLaunch(url)
        ? await launch(url)
        : print('Could not launch the Play Store');
  }

  Future<void> onShare(BuildContext context) async {
    final box = context.findRenderObject() as RenderBox?;
    String linkToShare =
        "https://play.google.com/store/apps/details?id=$appNamespace";
    String text = "Check out this link: $linkToShare";
    String subject = "Sharing with Friends";

    try {
      await Share.share(
        text,
        subject: subject,
        sharePositionOrigin: box!.localToGlobal(Offset.zero) & box.size,
      );
    } catch (e) {
      print("Error sharing: $e");
    }
  }

  void openPrivacyPolicy() async {
    const privacyPolicyUrl = "";
    await canLaunch(privacyPolicyUrl)
        ? await launch(privacyPolicyUrl)
        : print('Could not launch $privacyPolicyUrl');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFCEFDF),
      appBar: AppBar(
        backgroundColor: const Color(0xFFFCEFDF),
        title: const Center(
          child: Text(
            "Profile Management",
            style: TextStyle(
              color: Colors.black,
              fontFamily: 'Lora-VariableFont_wght.ttf',
            ),
          ),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: const Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),
              child: const CircleAvatar(
                radius: 100,
                backgroundColor: Colors.white,
                backgroundImage: AssetImage('assets/images/person.png'),
              ),
            ),
            const SizedBox(height: 20),
            buildContainer("Privacy and Policy", Icons.security,
                () => openPrivacyPolicy()),
            const SizedBox(height: 20),
            buildContainer("Share App", Icons.share, () => onShare(context)),
            const SizedBox(height: 20),
            buildContainer(
                "Rate This App", Icons.star, () => _navigateToPlayStore()),
            const SizedBox(height: 20),
            buildContainer("About Us", Icons.info, () {}),
            const SizedBox(height: 20),
            buildContainer(
                "Feedback", Icons.feedback, () => _showFeedbackDialog(context)),
          ],
        ),
      ),
    );
  }

  Widget buildContainer(String title, IconData icon, Function() onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 300,
        height: 50,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(
                left: 10,
              ),
              child: Text(
                title,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontFamily: 'Lora-VariableFont_wght.ttf',
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 20),
              child: Icon(icon, color: Colors.brown),
            ),
          ],
        ),
      ),
    );
  }

  void _showFeedbackDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) => GestureDetector(
        onTap: () => Navigator.of(context).pop(),
        child: FeedbackDialog.showFeedbackDialog(context, (String feedback) {
          print('Feedback submitted: $feedback');
        }),
      ),
    );
  }
}
