import 'dart:convert';

import 'package:flutter/services.dart' show rootBundle;

import '../domain/project.dart';

class ProjectRepository {
  const ProjectRepository({this.assetPath = _defaultAssetPath});

  static const String _defaultAssetPath = 'assets/content/projects.json';

  final String assetPath;

  Future<List<Project>> loadProjects() async {
    final raw = await rootBundle.loadString(assetPath, cache: false);
    final decoded = jsonDecode(raw) as List<dynamic>;
    return decoded
        .map((entry) => Project.fromJson(entry as Map<String, dynamic>))
        .toList();
  }
}
