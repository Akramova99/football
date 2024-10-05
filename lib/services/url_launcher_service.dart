import 'package:url_launcher/url_launcher.dart';

class UrlBrowser {
  static Future<void> launchInBrowser(String urlString) async {
    Uri url = Uri.parse(urlString);

    if (!await launchUrl(
      url,
      mode: LaunchMode.externalApplication,
    )) {
      throw Exception('Could not launch $url');
    }
  }
}