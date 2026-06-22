class Paragraph {
  const Paragraph({required this.title, required this.content});

  final String title;
  final String content;

  factory Paragraph.fromJson(Map<String, dynamic> json) {
    return Paragraph(
      title: json['title'] as String? ?? '',
      content: json['content'] as String? ?? '',
    );
  }
}
