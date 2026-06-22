import 'package:flutter/material.dart';

import '../../domain/paragraph.dart';

class ParagraphCard extends StatelessWidget {
  const ParagraphCard({super.key, required this.paragraph});

  final Paragraph paragraph;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 12),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(paragraph.title, style: theme.textTheme.headlineSmall),
            const SizedBox(height: 12),
            Text(
              paragraph.content,
              style: theme.textTheme.bodyLarge?.copyWith(height: 1.5),
            ),
          ],
        ),
      ),
    );
  }
}
