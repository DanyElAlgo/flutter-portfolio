class Project {
  const Project({
    required this.title,
    required this.description,
    this.imagePath,
    this.repoUrl,
    this.deployedUrl,
  });

  final String title;
  final String description;

  final String? imagePath;

  final String? repoUrl;

  final String? deployedUrl;

  factory Project.fromJson(Map<String, dynamic> json) {
    return Project(
      title: json['title'] as String? ?? '',
      description: json['description'] as String? ?? '',
      imagePath: _nonEmpty(json['imagePath'] as String?),
      repoUrl: _nonEmpty(json['repoUrl'] as String?),
      deployedUrl: _nonEmpty(json['deployedUrl'] as String?),
    );
  }

  static String? _nonEmpty(String? value) {
    if (value == null || value.trim().isEmpty) return null;
    return value;
  }
}
