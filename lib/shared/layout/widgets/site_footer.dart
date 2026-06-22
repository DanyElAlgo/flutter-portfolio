import 'package:flutter/material.dart';

class SiteFooter extends StatelessWidget {
  const SiteFooter({super.key});

  static const List<String> _navLinks = ['Home', 'About', 'Contact'];
  static const List<String> _contacts = [
    'email',
    'github',
    'linkedin',
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final year = DateTime.now().year;

    return Container(
      width: double.infinity,
      color: theme.colorScheme.surfaceContainerHighest,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
      child: Column(
        children: [
          SizedBox(
            width: double.infinity,
            child: Wrap(
              alignment: WrapAlignment.center,
              spacing: 48,
              runSpacing: 24,
              children: [
                _FooterColumn(title: 'Navigation', items: _navLinks),
                _FooterColumn(title: 'Contact', items: _contacts),
              ],
            ),
          ),
          const SizedBox(height: 24),
          Divider(color: theme.colorScheme.outlineVariant),
          const SizedBox(height: 12),
          Text(
            '© $year Portfolio. All rights reserved.',
            style: theme.textTheme.bodySmall,
          ),
        ],
      ),
    );
  }
}

class _FooterColumn extends StatelessWidget {
  const _FooterColumn({required this.title, required this.items});

  final String title;
  final List<String> items;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),
        for (final item in items)
          Padding(
            padding: const EdgeInsets.only(bottom: 6),
            child: Text(item, style: theme.textTheme.bodyMedium),
          ),
      ],
    );
  }
}
