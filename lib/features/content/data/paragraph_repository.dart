import 'dart:convert';

import 'package:flutter/services.dart' show rootBundle;

import '../domain/paragraph.dart';

class ParagraphRepository {
  const ParagraphRepository({this.assetPath = _defaultAssetPath});

  static const String _defaultAssetPath = 'assets/content/paragraphs.json';

  final String assetPath;

  Future<List<Paragraph>> loadParagraphs() async {
    final raw = await rootBundle.loadString(assetPath, cache: false);
    final decoded = jsonDecode(raw) as List<dynamic>;
    return decoded
        .map((entry) => Paragraph.fromJson(entry as Map<String, dynamic>))
        .toList();
  }
}
