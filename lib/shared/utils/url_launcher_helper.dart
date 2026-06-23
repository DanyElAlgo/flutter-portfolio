import 'package:url_launcher/url_launcher.dart';

Future<bool> launchExternalUrl(Uri uri) {
  return launchUrl(uri, mode: LaunchMode.externalApplication);
}

Future<bool> launchEmail({
  required String to,
  String? subject,
  String? body,
}) {
  final uri = Uri(
    scheme: 'mailto',
    path: to,
    query: _encodeQuery({
      if (subject != null && subject.isNotEmpty) 'subject': subject,
      if (body != null && body.isNotEmpty) 'body': body,
    }),
  );
  return launchExternalUrl(uri);
}

String? _encodeQuery(Map<String, String> params) {
  if (params.isEmpty) return null;
  return params.entries
      .map((e) => '${e.key}=${Uri.encodeComponent(e.value)}')
      .join('&');
}
