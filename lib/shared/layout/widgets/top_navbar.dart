import 'package:flutter/material.dart';

class TopNavbar extends StatelessWidget implements PreferredSizeWidget {
  const TopNavbar({super.key});

  /// Placeholder navigation links.
  static const List<String> _links = ['Home', 'About', 'Contact'];

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return AppBar(
      backgroundColor: theme.colorScheme.inversePrimary,
      title: Text(
        'Portfolio',
        style: theme.textTheme.titleLarge?.copyWith(
          fontWeight: FontWeight.bold,
        ),
      ),
      actions: [
        for (final link in _links)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: TextButton(
              onPressed: () {
                // TODO: Implement navigation logic here.
              },
              child: Text(link),
            ),
          ),
        const SizedBox(width: 12),
      ],
    );
  }
}
