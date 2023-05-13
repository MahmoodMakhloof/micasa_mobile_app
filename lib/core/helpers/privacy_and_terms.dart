import 'package:url_launcher/url_launcher.dart' as url_launcher;

Future<void> openPrivacyPolicy() {
  return _openWebView(Uri.parse('https://teachcamp.net/app/privacy'));
}

Future<void> openAboutUs() {
  return _openWebView(Uri.parse('https://teachcamp.net/app/about'));
}

Future<void> openTermsOfService() {
  return _openWebView(Uri.parse('https://teachcamp.net/app/terms'));
}

Future<void> _openWebView(Uri uri) async {
  if (!await url_launcher.canLaunchUrl(uri)) return;
  await url_launcher.launchUrl(uri);
}
