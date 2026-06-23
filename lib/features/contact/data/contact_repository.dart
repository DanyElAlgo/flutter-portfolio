import 'dart:convert';

import 'package:flutter/services.dart' show rootBundle;

import '../domain/contact_link.dart';

class ContactRepository {
  const ContactRepository({this.assetPath = _defaultAssetPath});

  static const String _defaultAssetPath = 'assets/content/contact.json';

  final String assetPath;

  Future<ContactInfo> loadContact() async {
    final raw = await rootBundle.loadString(assetPath, cache: false);
    final decoded = jsonDecode(raw) as Map<String, dynamic>;
    return ContactInfo.fromJson(decoded);
  }
}
