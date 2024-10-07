import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class AppUtils {
  static Future<String> getPackageName() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    return packageInfo.packageName;
  }
  static Future<void> launchUrl(String url) async {
    if (!await canLaunch(url)) {
      throw Exception('Could not launch $url');
    }
    await launch(url);
  }
}
