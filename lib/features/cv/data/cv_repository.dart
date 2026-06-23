import 'dart:convert';

import 'package:flutter/services.dart' show rootBundle;

import '../domain/cv.dart';

class CvRepository {
  const CvRepository({this.assetPath = _defaultAssetPath});

  static const String _defaultAssetPath = 'assets/content/cv.json';

  final String assetPath;

  Future<Cv> loadCv() async {
    final raw = await rootBundle.loadString(assetPath, cache: false);
    final decoded = jsonDecode(raw) as Map<String, dynamic>;
    return Cv.fromJson(decoded);
  }
}
